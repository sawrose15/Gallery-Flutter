import 'package:photo_api/photo_api.dart';

enum PhotoViewFilter {
  oldest_latest,
  alphabetically,
  favorite
}

extension PhotoViewFilterX on PhotoViewFilter {
  bool apply(Photo photo) {
    switch (this) {
      case PhotoViewFilter.oldest_latest:
        return true;
      case PhotoViewFilter.alphabetically:
        return false;
      case PhotoViewFilter.favorite:
        return false;
    }
  }

  Iterable<Photo> applyAll(Iterable<Photo> photos){
    return photos.where(apply);
  }
}