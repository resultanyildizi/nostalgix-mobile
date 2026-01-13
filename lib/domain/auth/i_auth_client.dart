import 'package:dartz/dartz.dart';
import 'package:nostalgix/domain/auth/auth_tokens.dart';
import 'package:nostalgix/domain/auth/user.dart';
import 'package:nostalgix/domain/failure/failure.dart';

abstract class IAuthClient {
  Future<Either<Failure, Unit>> loginAnonymously();
  Future<Either<Failure, Unit>> logout();
  Future<Either<Failure, User>> getUser();
  Future<Either<Failure, AuthTokens>> getStoredTokens();
}
