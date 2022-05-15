import 'dart:io';

import 'package:photo_api/photo_api.dart';

abstract class PhotoApi {
  PhotoApi();

  Stream<List<Photo>> getPhotos(String userId);

  Future<void> savePhoto(File file, Photo photo);

  Future<void> addPhotoToFav(Photo photo);

  Future<void> deletePhoto(Photo photo);

  Future<void> updatePhoto(Photo photo);
}

class PhotoNotFoundException implements Exception {}
