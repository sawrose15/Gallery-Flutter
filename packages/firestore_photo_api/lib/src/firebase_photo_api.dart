import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photo_api/photo_api.dart';

class FirebasePhotoApi implements PhotoApi {

  FirebasePhotoApi({
    required FirebaseFirestore firestore,
}): _firestore = firestore;

  final FirebaseFirestore _firestore;

  late final photoCollection =
      _firestore.collection('photos').withConverter(
          fromFirestore: (snapshot, _) => Photo.fromJson(snapshot.data()!),
          toFirestore: (photo, _) => photo.toJson(),
      );

  @override
  Future<void> addPhotoToFav(Photo photo) {
    throw UnimplementedError();
  }

  @override
  Stream<List<Photo>> getPhotos(User user) {
    return photoCollection.orderBy('id').snapshots().map(
            (snapshot) => snapshot.docs.map((e) => e.data()).toList(),
    );
  }

  @override
  Future<void> savePhoto(Photo photo) async {
  }

  @override
  Future<void> savePhotos(List<Photo> photos) {
    // TODO: implement savePhotos
    throw UnimplementedError();
  }
}