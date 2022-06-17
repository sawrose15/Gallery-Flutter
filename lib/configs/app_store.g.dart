// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on AppStoreBase, Store {
  late final _$hasInternetConnectionAtom =
      Atom(name: 'AppStoreBase.hasInternetConnection', context: context);

  @override
  bool get hasInternetConnection {
    _$hasInternetConnectionAtom.reportRead();
    return super.hasInternetConnection;
  }

  @override
  set hasInternetConnection(bool value) {
    _$hasInternetConnectionAtom.reportWrite(value, super.hasInternetConnection,
        () {
      super.hasInternetConnection = value;
    });
  }

  late final _$currentUserAtom =
      Atom(name: 'AppStoreBase.currentUser', context: context);

  @override
  User? get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(User? value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$isUserLoggedInAtom =
      Atom(name: 'AppStoreBase.isUserLoggedIn', context: context);

  @override
  bool get isUserLoggedIn {
    _$isUserLoggedInAtom.reportRead();
    return super.isUserLoggedIn;
  }

  @override
  set isUserLoggedIn(bool value) {
    _$isUserLoggedInAtom.reportWrite(value, super.isUserLoggedIn, () {
      super.isUserLoggedIn = value;
    });
  }

  late final _$saveUserAsyncAction =
      AsyncAction('AppStoreBase.saveUser', context: context);

  @override
  Future<void> saveUser(User value) {
    return _$saveUserAsyncAction.run(() => super.saveUser(value));
  }

  late final _$deleteUserAsyncAction =
      AsyncAction('AppStoreBase.deleteUser', context: context);

  @override
  Future<void> deleteUser() {
    return _$deleteUserAsyncAction.run(() => super.deleteUser());
  }

  @override
  String toString() {
    return '''
hasInternetConnection: ${hasInternetConnection},
currentUser: ${currentUser},
isUserLoggedIn: ${isUserLoggedIn}
    ''';
  }
}
