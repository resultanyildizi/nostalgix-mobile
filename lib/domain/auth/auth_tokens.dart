import 'package:equatable/equatable.dart';

class AuthTokens extends Equatable {
  const AuthTokens({required this.refreshToken, required this.accessToken});

  factory AuthTokens.fromMap(Map<String, dynamic> map) {
    return AuthTokens(
      refreshToken: map['refresh_token'] as String,
      accessToken: map['access_token'] as String,
    );
  }

  final String refreshToken;
  final String accessToken;

  @override
  List<Object?> get props => [refreshToken, accessToken];
}
