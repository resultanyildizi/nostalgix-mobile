import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nostalgix/domain/auth/i_auth_client.dart';
import 'package:nostalgix/domain/auth/user.dart';
import 'package:nostalgix/domain/failure/failure.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authClient) : super(AuthState.initial());

  final IAuthClient _authClient;

  Future<void> initialize() async {
    return _getUser();
  }

  Future<void> loginAnonymously() async {
    emit(state.copyWith(
      userOption: none(),
      signInFailOption: none(),
      isSigningIn: true,
    ));

    final failOrTokens = await _authClient.loginAnonymously();

    return failOrTokens.fold(
      (failure) async {
        emit(state.copyWith(
          signInFailOption: some(failure),
          isSigningIn: false,
        ));
      },
      (_) async => _getUser(),
    );
  }

  Future<void> _getUser() async {
    final failOrUser = await _authClient.getUser();
    return failOrUser.fold(
      (failure) {
        emit(state.copyWith(
          signInFailOption: some(failure),
          isSigningIn: false,
        ));
      },
      (user) {
        emit(state.copyWith(
          userOption: some(user),
          isSigningIn: false,
        ));
      },
    );
  }
}
