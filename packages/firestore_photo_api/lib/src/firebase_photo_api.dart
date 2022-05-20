import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:photo_api/photo_api.dart';
import 'package:uuid/uuid.dart';

/// class to implement [PhotoApi] interface using firebase
class FirebasePhotoApi implements PhotoApi {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  /// path for firestore photo collections
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
  Stream<List<Photo>> getPhotos({
    required String userId,
    String startAfterId = '',
  }) {
    return photoCollection
        .where('uploadedBy', isEqualTo: userId)
        .orderBy('id')
        .startAfter([startAfterId])
        .limit(10)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((e) => e.data()).toList(),
        );
  }

  @override
  Future<void> savePhoto(File file, Photo photo) async {
    final url = await savePhotoToStorage(file, photo.uploadedBy);
    final updatedPhoto = photo.copyWith(
      fileName: 'picture${Random().nextInt(90000) + 10000}',
      filePath: url,
    );
    await photoCollection.add(updatedPhoto);
  }

  /// method to save photos in the firebase storage.
  Future<String> savePhotoToStorage(File file, String userId) async {
    final task =
        _firebaseStorage.ref(userId).child(const Uuid().v4()).putFile(file);
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

  @override
  Future<void> updatePhoto(Photo photo) async {
    final check = await photoCollection.where('id', isEqualTo: photo.id).get();
    try {
      final currentPhoto = check.docs[0].reference.id;
      await photoCollection.doc(currentPhoto).update(photo.toJson());
    } catch (e) {
      throw PhotoNotFoundException();
    }
  }
}
