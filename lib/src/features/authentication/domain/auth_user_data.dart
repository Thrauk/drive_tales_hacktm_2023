import 'package:equatable/equatable.dart';

class AuthUserData extends Equatable {
  const AuthUserData({
    required this.id,
    this.email,
    this.displayName,
    this.photo,
  });

  AuthUserData.fromJson(Map<String, dynamic> json)
      : photo = json['photo'] as String?,
        id = json['id'] as String,
        displayName = json['displayName'] as String,
        email = json['email'] as String;

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'displayName': displayName,
    'photo': photo,
  };

  final String? email;

  final String id;

  final String? displayName;

  final String? photo;

  static const AuthUserData empty = AuthUserData(id: '');

  bool get isEmpty => this == AuthUserData.empty;

  bool get isNotEmpty => this != AuthUserData.empty;

  @override
  List<Object?> get props => <Object?>[email, id, displayName, photo];
}