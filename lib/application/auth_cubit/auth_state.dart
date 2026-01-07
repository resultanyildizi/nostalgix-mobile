part of 'auth_cubit.dart';

final class AuthState extends Equatable {
  const AuthState({
    required this.userOption,
    required this.signInFailOption,
    required this.isSigningIn,
  });

  factory AuthState.initial() {
    return AuthState(
      userOption: none(),
      signInFailOption: none(),
      isSigningIn: false,
    );
  }

  final Option<User> userOption;
  final Option<Failure> signInFailOption;
  final bool isSigningIn;

  AuthState copyWith({
    Option<User>? userOption,
    Option<Failure>? signInFailOption,
    bool? isSigningIn,
  }) {
    return AuthState(
      isSigningIn: isSigningIn ?? this.isSigningIn,
      userOption: userOption ?? this.userOption,
      signInFailOption: signInFailOption ?? this.signInFailOption,
    );
  }

  @override
  List<Object?> get props => [userOption, signInFailOption, isSigningIn];
}
