import 'package:equatable/equatable.dart';
import 'package:nostalgix/domain/auth/auth_method.dart';
import 'package:nostalgix/domain/auth/subcription.dart';

class User extends Equatable {
  const User({
    required this.userID,
    required this.name,
    required this.customerID,
    required this.subscription,
    required this.credits,
    required this.isNewUser,
    required this.authMethod,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      userID: map['id'],
      customerID: map['customer_id'],
      credits: map['credits'],
      isNewUser: map['is_new_user'],
      authMethod: AuthMethod.fromKey(map['auth_method']),
      subscription: map['subcription'] != null
          ? Subscription.fromMap(map['subcription'])
          : null,
    );
  }

  final String userID;
  final String name;
  final String customerID;
  final int credits;
  final bool isNewUser;
  final Subscription? subscription;
  final AuthMethod authMethod;

  @override
  List<Object?> get props => [
        userID,
        name,
        customerID,
        credits,
        subscription,
        authMethod,
      ];
}
