import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// class method for user
class User extends Equatable {
  ///@macro constructor for user class.
  const User({@required this.id, this.email, this.userName});

  ///user id
  final String? id;
  ///email for user
  final String? email;
  /// username of user
  final String? userName;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [id, email, userName];
}
