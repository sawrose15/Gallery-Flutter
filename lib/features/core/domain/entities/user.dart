part of 'models.dart';

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
