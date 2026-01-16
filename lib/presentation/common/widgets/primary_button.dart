import 'package:flutter/material.dart';
import 'package:nostalgix/presentation/constants/app_fonts.dart';
import 'package:nostalgix/presentation/extensions/context_extension.dart';
import 'package:scale_button/scale_button.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.title,
  });

  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ScaleButton(
      bound: 0.2,
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.appTheme.primary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontFamily: AppFonts.playfair.family,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
