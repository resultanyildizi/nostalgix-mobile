import 'package:flutter/material.dart';
import 'package:nostalgix/presentation/constants/app_theme.dart';

extension BuildContextExt on BuildContext {
  AppTheme get appTheme => AppTheme.light();
}
