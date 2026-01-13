import 'package:dartz/dartz.dart';

extension EitherExt<L, R> on Either<L, R> {
  Option<L> toLeftOption() {
    return fold(some, (_) => none());
  }
}
