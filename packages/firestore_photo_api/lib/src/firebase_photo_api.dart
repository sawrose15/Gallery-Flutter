import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:photo_api/photo_api.dart';
import 'package:uuid/uuid.dart';

class FirebasePhotoApi implements PhotoApi {
  ///@{macro} firebasePhotoApi
  FirebasePhotoApi(
      {required FirebaseStorage firebaseStorage,
      required FirebaseFirestore firebaseFirestore})
      : _firebaseStorage = firebaseStorage,
        _firebaseFirestore = firebaseFirestore;

  final FirebaseStorage _firebaseStorage;
  final FirebaseFirestore _firebaseFirestore;

  Map<String, Reference> refs = {};

  Reference get _galleryRef =>
      _firebaseStorage.ref('${FirebaseAuth.instance.currentUser?.uid}');

  late final photoCollection =
      _firebaseFirestore.collection('photos').withConverter(
            fromFirestore: (snapshot, _) => Photo.fromJson(snapshot.data()!),
            toFirestore: (photo, _) => photo.toJson(),
          );

  @override
  Future<void> addPhotoToFav(String userId, Photo photo) {
    throw UnimplementedError();
  }

  @override
  Stream<List<Photo>> getPhotos() {
    return photoCollection.orderBy('uploadedDate').snapshots().map(
          (snapshot) => snapshot.docs.map((e) => e.data()).toList(),
        );
  }

  @override
  Future<void> savePhoto(File file, Photo photo) async {
    final url = await savePhotoToStorage(file);
    var updatedPhoto = photo.copyWith(filePath: url);
    await photoCollection.add(updatedPhoto);
  }

  @override
  Future<void> savePhotos(String userId, List<Photo> photo) {
    throw UnimplementedError();
  }

  Future<String> savePhotoToStorage(File file) async {
    final task = _galleryRef.child(const Uuid().v4()).putFile(file);
    final downloadUrl = await task;
    final url = await downloadUrl.ref.getDownloadURL();
    print('Image link: $url');
    return url;
  }
}
