import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:nostalgix/domain/auth/auth_tokens.dart';
import 'package:nostalgix/domain/failure/failure.dart';
import 'package:uuid/uuid.dart';

typedef NetworkRequest = Future<Response> Function(String accessToken);

typedef ExceptionCallback<T> = Future<Either<Failure, T>> Function(Object e);
typedef ResponseCallback<T> = Future<Either<Failure, T>> Function(Response r);

mixin AuthMixin {
  FlutterSecureStorage get secureStorage;
  Client get client;
  Uuid get uuid;

  static const deviceKeyKey = 'device_key';
  static const refreshTokenKey = 'refresh_token';
  static const accessTokenKey = 'access_token';

  Future<String> getUniqueDeviceKey() async {
    var deviceKey = await secureStorage.read(key: deviceKeyKey);
    if (deviceKey == null) {
      deviceKey = uuid.v4();
      await secureStorage.write(key: deviceKeyKey, value: deviceKey);
    }
    return deviceKey;
  }

  Future<Either<Failure, Unit>> storeAuthTokens({
    required AuthTokens authTokens,
  }) async {
    try {
      await secureStorage.write(
        key: refreshTokenKey,
        value: authTokens.refreshToken,
      );
      await secureStorage.write(
        key: accessTokenKey,
        value: authTokens.accessToken,
      );
      return right(unit);
    } catch (e) {
      return left(UnknownFailure(e.toString()));
    }
  }

  Future<Either<Failure, Unit>> removeAuthTokens() async {
    try {
      await secureStorage.delete(key: refreshTokenKey);
      await secureStorage.delete(key: accessTokenKey);
      return right(unit);
    } catch (e) {
      return left(UnknownFailure(e.toString()));
    }
  }

  Future<Either<Failure, AuthTokens>> getAuthTokens() async {
    try {
      final refreshToken = await secureStorage.read(key: refreshTokenKey);
      final accessToken = await secureStorage.read(key: accessTokenKey);
      if (refreshToken == null || accessToken == null) {
        return left(NotFoundFailure());
      }
      return right(AuthTokens(
        refreshToken: refreshToken,
        accessToken: accessToken,
      ));
    } catch (e) {
      return left(UnknownFailure(e.toString()));
    }
  }

  Future<AuthTokens?> _getAccessToken(String refreshToken) async {
    final response = await client.post(
      Uri.parse('http://localhost:8080/v1/auth/refresh'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({
        'device_key': await getUniqueDeviceKey(),
        'refresh_token': refreshToken,
      }),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return AuthTokens.fromMap(body);
    }
    return null;
  }

  Future<Either<Failure, T>> sendRequestWithTokens<T>(
    NetworkRequest request,
    ResponseCallback<T> onResponse,
    ExceptionCallback<T> onException,
  ) async {
    try {
      var accessToken = await secureStorage.read(key: accessTokenKey);
      final refreshToken = await secureStorage.read(key: refreshTokenKey);

      if (accessToken == null) {
        if (refreshToken == null) return left(UnauthorizedFailure());
        final newTokens = await _getAccessToken(refreshToken);
        if (newTokens == null) return left(UnauthorizedFailure());
        await storeAuthTokens(authTokens: newTokens);
        accessToken = newTokens.accessToken;
      }

      final response1 = await request(accessToken);
      if (response1.statusCode == HttpStatus.unauthorized) {
        if (refreshToken == null) return left(UnauthorizedFailure());
        final newTokens = await _getAccessToken(refreshToken);
        if (newTokens == null) return left(UnauthorizedFailure());
        await storeAuthTokens(authTokens: newTokens);
        accessToken = newTokens.accessToken;
      }

      return onResponse(await request(accessToken));
    } catch (e) {
      print('Exception on sendRequestWithTokens: $e');
      return onException(e);
    }
  }
}
