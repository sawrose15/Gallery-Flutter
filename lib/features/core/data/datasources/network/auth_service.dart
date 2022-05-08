import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:injectable/injectable.dart';
import 'package:photo_gallery/features/core/data/models/failure.dart';
import 'package:photo_gallery/features/core/domain/entities/models.dart';

abstract class AuthService {
  Future<User> loginWithUser(
    String email,
    String password,
  );
  Future<User> signUpUser(
    String email,
    String password,
  );
  Future<bool> logout();
}

@LazySingleton(as: AuthService)
class AuthServiceImpl implements AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<User> loginWithUser(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return User(
        email: result.user!.email,
        uid: result.user!.uid,
      );
    } on FirebaseAuthException catch (e) {
      throw ServerError(message: e.message);
    } catch (_) {
      throw const ServerError();
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await _auth.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      throw ServerError(message: e.message);
    } catch (_) {
      throw const ServerError();
    }
  }

  @override
  Future<User> signUpUser(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return User(uid: result.user!.uid, email: result.user!.email);
    } on FirebaseAuthException catch (e) {
      throw ServerError(message: e.message);
    } catch (_) {
      throw const ServerError();
    }
  }
}
