import 'package:photo_api/photo_api.dart';

abstract class PhotoApi{
  const PhotoApi();

  Stream<List<Photo>> getPhotos();

  Future<void> savePhoto(Photo photo);

  Future<void> savePhotos(List<Photo> photos);

  Future<void> addPhotoToFav(Photo photo);
}

class PhotoNotFoundException implements Exception{}