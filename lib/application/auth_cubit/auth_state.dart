part of 'auth_cubit.dart';

final class AuthState extends Equatable {
  const AuthState({
    required this.userOption,
    required this.processFailOption,
    required this.isProcessing,
  });

  factory AuthState.initial() {
    return AuthState(
      userOption: none(),
      processFailOption: none(),
      isProcessing: false,
    );
  }

  final Option<User> userOption;
  final Option<Failure> processFailOption;
  final bool isProcessing;

  AuthState copyWith({
    Option<User>? userOption,
    Option<Failure>? processFailOption,
    bool? isProcessing,
  }) {
    return AuthState(
      isProcessing: isProcessing ?? this.isProcessing,
      userOption: userOption ?? this.userOption,
      processFailOption: processFailOption ?? this.processFailOption,
    );
  }

  @override
  List<Object?> get props => [
        userOption,
        processFailOption,
        isProcessing,
      ];
}
