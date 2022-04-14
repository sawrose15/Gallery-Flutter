import 'package:photo_api/photo_api.dart';

class PhotoRepository {
  const PhotoRepository({
    required PhotoApi photoApi
}): _photoApi = photoApi;

  final PhotoApi _photoApi;

  Stream<List<Photo>> getPhotos() => _photoApi.getPhotos();

  void savePhoto(Photo photo) => _photoApi.savePhoto(photo);

  void savePhotos(List<Photo> photos) => _photoApi.savePhotos(photos);

  void addPhotoToFav(Photo photo) => _photoApi.addPhotoToFav(photo);
}