

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  group('User', (){
    const id = "mock-id";
    const email = "mock-email";

    test('use value equality', (){
      expect(
          const User(id:id, email: email),
          equals(const User(id: id, email: email)));
    });

    test('isEmpty true for empty User', (){
      expect(User.empty.isEmpty, isTrue);
    });

    test('isEmpty false for non-empty User', (){
      const user = User(id: id, email: email);
      expect(user.isEmpty, isFalse);
    });

    test('isNotEmpty returns false for empty user', () {
      expect(User.empty.isNotEmpty, isFalse);
    });

    test('isNotEmpty returns true for non-empty user', () {
      const user = User(email: email, id: id);
      expect(user.isNotEmpty, isTrue);
    });

  });
}