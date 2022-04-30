import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:photo_api/photo_api.dart';
import 'package:uuid/uuid.dart';

class FirebasePhotoApi implements PhotoApi {
  ///@{macro} firebasePhotoApi
  FirebasePhotoApi({
    required FirebaseStorage firebaseStorage,
    required FirebaseFirestore firebaseFirestore,
  })  : _firebaseStorage = firebaseStorage,
        _firebaseFirestore = firebaseFirestore;

  final FirebaseStorage _firebaseStorage;
  final FirebaseFirestore _firebaseFirestore;

  Reference get _galleryRef =>
      _firebaseStorage.ref('${FirebaseAuth.instance.currentUser?.uid}');

  late final photoCollection =
      _firebaseFirestore.collection('photos').withConverter(
            fromFirestore: (snapshot, _) => Photo.fromJson(snapshot.data()!),
            toFirestore: (photo, _) => photo.toJson(),
          );

  @override
  Future<void> addPhotoToFav(Photo photo) async {
    final checkPhoto =
        await photoCollection.where('id', isEqualTo: photo.id).get();
    final currentPhotoId = checkPhoto.docs[0].reference.id;
    await photoCollection.doc(currentPhotoId).update(photo.toJson());
  }

  @override
  Stream<List<Photo>> getPhotos() {
    return photoCollection
        .where('uploadedBy', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((e) => e.data()).toList(),
        );
  }

  @override
  Future<void> savePhoto(File file, Photo photo) async {
    final url = await savePhotoToStorage(file);
    final updatedPhoto =
        photo.copyWith(fileName: 'picture${const Uuid().v4()}', filePath: url);
    await photoCollection.add(updatedPhoto);
  }

  Future<String> savePhotoToStorage(File file) async {
    final task = _galleryRef.child(const Uuid().v4()).putFile(file);
    final downloadUrl = await task;
    final url = await downloadUrl.ref.getDownloadURL();
    return url;
  }

  @override
  Future<void> deletePhoto(Photo photo) async {
    final checkPhoto =
        await photoCollection.where('id', isEqualTo: photo.id).get();
    final currentPhotoId = checkPhoto.docs[0].reference.id;

    try {
      await _firebaseStorage.refFromURL(photo.filePath).delete();
      await photoCollection.doc(currentPhotoId).delete();
    } catch (e) {
      throw PhotoNotFoundException();
    }
  }
}
