import 'package:equatable/equatable.dart';

class Subscription extends Equatable {
  const Subscription({
    required this.type,
    required this.plan,
    required this.status,
    required this.period,
  });

  factory Subscription.fromMap(Map<String, dynamic> map) {
    return Subscription(
      type: SubscriptionType.fromKey(map['type'] as String),
      plan: map['plan'],
      status: map['status'],
      period: map['period'],
    );
  }

  final SubscriptionType type;
  final SubscriptionPlan plan;
  final SubscriptionStatus status;
  final SubscriptionPeriod period;

  @override
  List<Object?> get props => [type, plan, status, period];
}

enum SubscriptionType {
  normal('normal'),
  trial('trial'),
  intro('intro'),
  prepaid('prepaid'),
  promo('promo'),
  ;

  const SubscriptionType(this.key);
  factory SubscriptionType.fromKey(String key) {
    return values.firstWhere((v) => v.key == key);
  }
  final String key;
}

enum SubscriptionPlan {
  pro('pro');

  const SubscriptionPlan(this.key);
  factory SubscriptionPlan.fromKey(String key) {
    return values.firstWhere((v) => v.key == key);
  }
  final String key;
}

enum SubscriptionStatus {
  active('active'),
  expired('expired'),
  billingIssue('billing_issue'),
  ;

  const SubscriptionStatus(this.key);
  factory SubscriptionStatus.fromKey(String key) {
    return values.firstWhere((v) => v.key == key);
  }
  final String key;
}

enum SubscriptionPeriod {
  week1('1w'),
  month1('1m'),
  month6('6m'),
  year1('1y'),
  ;

  const SubscriptionPeriod(this.key);
  factory SubscriptionPeriod.fromKey(String key) {
    return values.firstWhere((v) => v.key == key);
  }
  final String key;
}
