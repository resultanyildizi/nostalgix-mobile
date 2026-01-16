import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nostalgix/presentation/constants/app_fonts.dart';
import 'package:nostalgix/presentation/extensions/context_extension.dart';
import 'package:provider/provider.dart';

class CustomToast extends StatelessWidget {
  const CustomToast({super.key, required this.message, this.icon});

  final String message;
  final IconData? icon;

  static void showToast(
    BuildContext context, {
    required String message,
    IconData icon = LucideIcons.triangleAlert500,
    ToastGravity gravity = ToastGravity.TOP,
  }) {
    final ftoast = context.read<FToast>();
    ftoast.showToast(
      gravity: gravity,
      child: CustomToast(
        message: message,
        icon: icon,
      ),
      toastDuration: Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appTheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 18,
              color: context.appTheme.primary,
            ),
            const SizedBox(width: 8),
          ],
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppFonts.playfair.family,
              color: context.appTheme.textPrimary,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
