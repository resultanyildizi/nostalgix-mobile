import 'package:flutter/widgets.dart';
import 'package:nostalgix/domain/failure/failure.dart';
import 'package:nostalgix/presentation/common/widgets/custom_toast.dart';
import 'package:nostalgix/presentation/login/login_page.dart';

void handleFailure(BuildContext context, Failure failure) {
  switch (failure) {
    case UnknownFailure _:
      return CustomToast.showToast(
        context,
        message: 'Unexpected error.',
      );
    case NetworkFailure():
      return CustomToast.showToast(
        context,
        message: 'Network error.',
      );
    case NotFoundFailure():
      return CustomToast.showToast(
        context,
        message: 'The resource is not found.',
      );
    case UnauthorizedFailure():
      Navigator.pushAndRemoveUntil(
        context,
        LoginPage.route(),
        (_) => false,
      );
  }
}
