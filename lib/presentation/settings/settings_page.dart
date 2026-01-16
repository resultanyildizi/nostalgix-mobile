import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nostalgix/application/auth_cubit/auth_cubit.dart';
import 'package:nostalgix/presentation/constants/app_fonts.dart';
import 'package:nostalgix/presentation/extensions/context_extension.dart';
import 'package:scale_button/scale_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appTheme.background,
      appBar: AppBar(
        backgroundColor: context.appTheme.surface,
        shadowColor: context.appTheme.primary,
        elevation: 0.3,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: AppFonts.playfair.family,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: context.appTheme.textPrimary,
        ),
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: context.appTheme.border,
                ),
                color: context.appTheme.surface,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SettingsPageTile(
                    leadingIcon: Icons.question_mark_rounded,
                    trailingIcon: Icons.launch_rounded,
                    title: 'Help Center',
                    onTap: () {
                      HapticFeedback.lightImpact();
                      print('Hello, world');
                      // TODO(resultanyildizi): launch help web page
                    },
                  ),
                  Divider(
                    height: 0,
                  ),
                  SettingsPageTile(
                    leadingIcon: Icons.exit_to_app_rounded,
                    trailingIcon: Icons.chevron_right_rounded,
                    title: 'Logout',
                    onTap: () {
                      HapticFeedback.lightImpact();
                      context.read<AuthCubit>().logout();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SettingsPageTile extends StatelessWidget {
  const SettingsPageTile({
    super.key,
    required this.leadingIcon,
    required this.trailingIcon,
    required this.title,
    required this.onTap,
  });

  final IconData leadingIcon;
  final IconData trailingIcon;
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ScaleButton(
      bound: 0.2,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.appTheme.primary,
              ),
              height: 24,
              width: 24,
              child: Icon(
                leadingIcon,
                color: context.appTheme.surface,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontFamily: AppFonts.playfair.family,
                fontWeight: FontWeight.w500,
                color: context.appTheme.textPrimary,
              ),
            ),
            Spacer(),
            Icon(
              trailingIcon,
              color: context.appTheme.textSecondary,
              size: 16,
            )
          ],
        ),
      ),
    );
  }
}
