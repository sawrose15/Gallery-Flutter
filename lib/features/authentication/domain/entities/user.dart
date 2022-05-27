import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';
part 'user.freezed.dart';

@Freezed()
class User with _$User {
  const User._();

  const factory User({
    String? uid,
    String? email,
  }) = _User;

  static const empty = User(uid: '');

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
