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

  late final _$userAtom = Atom(name: 'AppStoreBase.user', context: context);

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  @override
  String toString() {
    return '''
hasInternetConnection: ${hasInternetConnection},
isUserLoggedIn: ${isUserLoggedIn},
user: ${user}
    ''';
  }
}
