import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:injectable/injectable.dart';
import 'package:photo_gallery/features/authentication/domain/entities/user.dart';
import 'package:photo_gallery/features/authentication/domain/repositories/auth_repository_interface.dart';
import 'package:photo_gallery/features/core/data/models/exceptions.dart';
import 'package:photo_gallery/features/core/data/models/failure.dart';

abstract class RemoteDataSource {
  Future<User> loginWithEmailAndPassword(UserParams params);
  Future<User> registerWithEmailAndPassword(UserParams params);
  Future<bool> logout();
  Future<User> checkAuthentication();
}

@LazySingleton(as: RemoteDataSource)
class RemoteDataSourceImpl implements RemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Future<User> loginWithEmailAndPassword(UserParams params) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
      return User(
        uid: result.user!.uid,
        email: result.user!.email,
      );
    } on FirebaseException catch (exception) {
      throw ServerException(exception.message!);
    } catch (_) {
      throw LoginException();
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await _auth.signOut();
      return true;
    } on FirebaseException catch (exception) {
      throw ServerException(exception.message!);
    } catch (_) {
      throw LogoutException();
    }
  }

  @override
  Future<User> registerWithEmailAndPassword(UserParams params) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
      return User(
        uid: result.user!.uid,
        email: result.user!.email,
      );
    } on FirebaseException catch (ex) {
      throw ServerFailure(ex.message!);
    } catch (_) {
      throw RegisterException();
    }
  }

  @override
  Future<User> checkAuthentication() async {
    try {
      if (_auth.currentUser != null) {
        return User(
          email: _auth.currentUser!.email,
          uid: _auth.currentUser!.uid,
        );
      } else {
        throw CheckAuthenticationException();
      }
    } catch (_) {
      throw CheckAuthenticationException();
    }
  }
}
