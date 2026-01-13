import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:nostalgix/domain/auth/auth_tokens.dart';
import 'package:nostalgix/domain/auth/i_auth_client.dart';
import 'package:nostalgix/domain/auth/user.dart';
import 'package:nostalgix/domain/failure/failure.dart';
import 'package:nostalgix/infrastructure/auth/auth_mixin.dart';
import 'package:uuid/uuid.dart';

class AuthClient with AuthMixin implements IAuthClient {
  const AuthClient({
    required Uuid uuid,
    required Client client,
    required FlutterSecureStorage secureStorage,
  })  : _client = client,
        _uuid = uuid,
        _secureStorage = secureStorage;

  final Uuid _uuid;
  final Client _client;
  final FlutterSecureStorage _secureStorage;

  @override
  Client get client => _client;

  @override
  FlutterSecureStorage get secureStorage => _secureStorage;

  @override
  Uuid get uuid => _uuid;

  @override
  Future<Either<Failure, Unit>> loginAnonymously() async {
    try {
      final response = await _client.post(
        Uri.parse('http://localhost:8080/v1/auth/login/anonymous'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'device_key': await getUniqueDeviceKey()}),
      );

      if (response.statusCode == HttpStatus.ok) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        return storeAuthTokens(authTokens: AuthTokens.fromMap(body));
      } else if (response.statusCode == HttpStatus.unauthorized) {
        return left(UnauthorizedFailure());
      } else {
        return left(UnknownFailure(response.statusCode.toString()));
      }
    } on SocketException catch (_) {
      return left(NetworkFailure());
    } catch (e) {
      return left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getUser() async {
    return sendRequestWithTokens(
      (accessToken) {
        return client.get(
          Uri.parse('http://localhost:8080/v1/auth/user'),
          headers: {'Authorization': 'Bearer $accessToken'},
        );
      },
      (r) async {
        if (r.statusCode == HttpStatus.unauthorized) {
          return left(UnauthorizedFailure());
        } else if (r.statusCode == HttpStatus.notFound) {
          return left(NotFoundFailure());
        } else if (r.statusCode == HttpStatus.ok) {
          return right(
            User.fromMap(jsonDecode(r.body) as Map<String, dynamic>),
          );
        } else {
          return left(UnknownFailure(r.statusCode.toString()));
        }
      },
      (e) async {
        if (e is SocketException) {
          return left(NetworkFailure());
        } else {
          return left(UnknownFailure(e.toString()));
        }
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    return sendRequestWithTokens(
      (accessToken) async {
        return client.post(
          Uri.parse(
            'http://localhost:8080/v1/auth/logout',
          ),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken'
          },
          body: jsonEncode({'device_key': await getUniqueDeviceKey()}),
        );
      },
      (r) async {
        if (r.statusCode == HttpStatus.unauthorized) {
          return left(UnauthorizedFailure());
        } else if (r.statusCode == HttpStatus.notFound) {
          return left(NotFoundFailure());
        } else if (r.statusCode == HttpStatus.ok) {
          return removeAuthTokens();
        } else {
          return left(UnknownFailure(r.statusCode.toString()));
        }
      },
      (e) async {
        if (e is SocketException) {
          return left(NetworkFailure());
        } else {
          return left(UnknownFailure(e.toString()));
        }
      },
    );
  }

  @override
  Future<Either<Failure, AuthTokens>> getStoredTokens() {
    return getAuthTokens();
  }
}
