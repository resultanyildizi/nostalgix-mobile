import 'package:dartz/dartz.dart';

extension EitherExt<L, R> on Either<L, R> {
  Option<L> toLeftOption() {
    return fold(some, (_) => none());
  }
}

extension OptionExt<S> on Option<S> {
  S getOrCrash() {
    return fold(() => throw AssertionError(), id);
  }
}
