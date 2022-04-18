import 'dart:io';

import 'package:photo_api/photo_api.dart';

abstract class PhotoApi{
  PhotoApi();

  Stream<List<Photo>> getPhotos();

  Future<void> savePhoto(File file,Photo photo);

  Future<void> savePhotos(String userId,List<Photo> photos);

  Future<void> addPhotoToFav(String userId,Photo photo);
}

class PhotoNotFoundException implements Exception{}