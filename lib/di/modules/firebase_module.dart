import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_photo_api/firebase_photo_api.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_api/photo_api.dart';

/// Module to inject firebase dependencies
///
/// this files helps to maintain the firebase dependencies required for the project
@module
abstract class FirebaseModule {
  @lazySingleton
  PhotoApi get firebasePhotoApi => FirebasePhotoApi();

  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @lazySingleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
}
