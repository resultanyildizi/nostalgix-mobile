import 'package:flutter/material.dart';
import 'package:nostalgix/presentation/constants/app_fonts.dart';
import 'package:nostalgix/presentation/constants/app_theme.dart';
import 'package:nostalgix/presentation/extensions/context_extension.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appTheme.background,
      body: Column(
        children: [
          Center(
            child: Text(
              'ALBUM PAGE',
              style: TextStyle(
                fontFamily: AppFonts.lato.family,
                fontWeight: FontWeight.bold,
                color: context.appTheme.textPrimary,
              ),
            ),
          )
        ],
      ),
    );
  }
}
