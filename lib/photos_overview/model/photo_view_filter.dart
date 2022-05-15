import 'package:firebase_auth/firebase_auth.dart';
import 'package:photo_api/photo_api.dart';

enum PhotoViewFilter {
  oldest_latest,
  latest_oldest,
  alphabetically_ascending,
  alphabetically_decending,
  favorite
}

int sortByName(Photo a, Photo b) => a.fileName.compareTo(b.fileName);

int sortByNameDesc(Photo a, Photo b) => b.fileName.compareTo(a.fileName);

int sortbyDate(Photo a, Photo b) => a.uploadedDate.compareTo(b.uploadedDate);

int sortbyDateDesc(Photo a, Photo b) =>
    b.uploadedDate.compareTo(a.uploadedDate);

extension PhotoViewFilterX on PhotoViewFilter {
  Iterable<Photo> apply(List<Photo> photos) {
    switch (this) {
      case PhotoViewFilter.oldest_latest:
        photos.sort(sortbyDate);
        return photos;
      case PhotoViewFilter.latest_oldest:
        photos.sort(sortbyDateDesc);
        return photos;
      case PhotoViewFilter.alphabetically_ascending:
        photos.sort(sortByName);
        return photos;
      case PhotoViewFilter.alphabetically_decending:
        photos.sort(sortByNameDesc);
        return photos;
      case PhotoViewFilter.favorite:
        return photos.where((photo) =>
            photo.isFav == true &&
            photo.uploadedBy == '${FirebaseAuth.instance.currentUser?.uid}');
    }
  }
}
