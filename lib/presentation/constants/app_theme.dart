import 'dart:ui';

class AppTheme {
  const AppTheme._({
    required this.background,
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
    required this.primary,
    required this.border,
  });

  factory AppTheme.light() {
    return AppTheme._(
      background: Color(0xFFFDFBF7),
      surface: Color(0xFFFFFFFF),
      textPrimary: Color(0xFF2C241B),
      textSecondary: Color(0xFF857F72),
      primary: Color(0xFFD4A373),
      border: Color.fromARGB(255, 219, 208, 196),
    );
  }

  final Color background;
  final Color surface;
  final Color textPrimary;
  final Color textSecondary;
  final Color primary;
  final Color border;
}
