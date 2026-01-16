import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nostalgix/application/auth_cubit/auth_cubit.dart';
import 'package:nostalgix/presentation/common/functions/handle_failure.dart';
import 'package:nostalgix/presentation/common/widgets/custom_toast.dart';
import 'package:nostalgix/presentation/common/widgets/primary_button.dart';
import 'package:nostalgix/presentation/constants/app_assets.dart';
import 'package:nostalgix/presentation/constants/app_fonts.dart';
import 'package:nostalgix/presentation/extensions/context_extension.dart';
import 'package:nostalgix/presentation/home/home_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:scale_button/scale_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage._();

  static PageTransition<dynamic> route() {
    return PageTransition(
      type: PageTransitionType.fade,
      childBuilder: (_) => LoginPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthCubit, AuthState>(
            listenWhen: (previous, current) {
              return previous.userOption.isNone() &&
                  current.userOption.isSome();
            },
            listener: (context, state) {
              Navigator.pushReplacement(context, HomePage.route());
            },
          ),
          BlocListener<AuthCubit, AuthState>(
            listenWhen: (previous, current) {
              return previous.processFailOption.isNone() &&
                  current.processFailOption.isSome();
            },
            listener: (context, state) {
              handleFailure(context, state.failOrCrash);
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: context.appTheme.background,
          body: LayoutBuilder(
            builder: (context, constraints) {
              print(constraints.maxHeight);
              return Stack(
                children: [
                  LoginPageHeaderImage(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight > 850.0
                        ? constraints.maxHeight * 0.74
                        : constraints.maxHeight * 0.7,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            LoginPageAppTitle(),
                            const SizedBox(height: 16),
                            LoginPageHeaderTitle(),
                            const SizedBox(height: 16),
                            LoginPageHeaderDescription(),
                            const SizedBox(height: 32),
                            PrimaryButton(
                              onTap: () {
                                HapticFeedback.lightImpact();
                                // TODO(resultanyildizi): start onboarding steps here
                              },
                              title: 'Start Restoring',
                            ),
                            const SizedBox(height: 16),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Have an account? ',
                                    style: TextStyle(
                                      color: context.appTheme.textSecondary,
                                      fontFamily: AppFonts.lato.family,
                                      fontSize: 14,
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: ScaleButton(
                                      onTap: () {
                                        HapticFeedback.lightImpact();
                                        context.read<AuthCubit>().loginAnon();
                                      },
                                      child: Text(
                                        'Log in',
                                        style: TextStyle(
                                          height: 1.33,
                                          color: context.appTheme.primary,
                                          fontFamily: AppFonts.lato.family,
                                          fontWeight: FontWeight.w600,
                                          decoration: TextDecoration.underline,
                                          decorationColor:
                                              context.appTheme.primary,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class LoginPageHeaderDescription extends StatelessWidget {
  const LoginPageHeaderDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Watch your cherished family photos move, smile, and embrace again with our gentle AI animation engine',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: context.appTheme.textSecondary,
        fontFamily: AppFonts.lato.family,
      ),
    );
  }
}

class LoginPageHeaderTitle extends StatelessWidget {
  const LoginPageHeaderTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        style: TextStyle(
          height: 1.1,
          fontFamily: AppFonts.playfair.family,
          fontWeight: FontWeight.w500,
          fontSize: 42,
          color: context.appTheme.textPrimary,
        ),
        children: [
          TextSpan(
            text: 'Bring Your Past ',
          ),
          TextSpan(
            text: 'Back to Life',
            style: TextStyle(
              color: context.appTheme.primary,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class LoginPageAppTitle extends StatelessWidget {
  const LoginPageAppTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 1,
          width: 30,
          decoration: BoxDecoration(
            color: context.appTheme.primary,
          ),
        ),
        const SizedBox(width: 16),
        Text(
          'NOSTALGIX AI',
          style: TextStyle(
            color: context.appTheme.primary,
          ),
        ),
        const SizedBox(width: 16),
        Container(
          height: 1,
          width: 30,
          decoration: BoxDecoration(
            color: context.appTheme.primary,
          ),
        ),
      ],
    );
  }
}

class LoginPageHeaderImage extends StatelessWidget {
  const LoginPageHeaderImage({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        // =========================
        // Background Image
        Image.asset(
          AppAssets.loginHeader.path,
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: 0,
          child: Container(
            height: 200,
            width: width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter,
                colors: [
                  Colors.transparent,
                  context.appTheme.background.withValues(alpha: 0.4),
                  context.appTheme.background,
                ],
              ),
            ),
          ),
        ),
        // =========================
        // Titles and Subtitles
      ],
    );
  }
}
