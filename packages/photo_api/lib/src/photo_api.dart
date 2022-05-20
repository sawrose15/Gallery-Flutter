import 'dart:io';

import 'package:photo_api/photo_api.dart';

abstract class PhotoApi {
  PhotoApi();

  Stream<List<Photo>> getPhotos(
      {required String userId, String startAfterId = ''});

  Future<void> savePhoto(File file, Photo photo);

  Future<void> addPhotoToFav(Photo photo);

  Future<void> deletePhoto(Photo photo);

  Future<void> updatePhoto(Photo photo);
}

class PhotoNotFoundException implements Exception {}
