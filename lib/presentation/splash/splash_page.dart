import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nostalgix/application/auth_cubit/auth_cubit.dart';
import 'package:nostalgix/presentation/constants/app_assets.dart';
import 'package:nostalgix/presentation/constants/app_fonts.dart';
import 'package:nostalgix/presentation/extensions/context_extension.dart';
import 'package:nostalgix/presentation/home/home_page.dart';
import 'package:nostalgix/presentation/login/login_page.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    lowerBound: 0.6,
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authCubit = context.read<AuthCubit>();
      Future.delayed(
        const Duration(seconds: 1),
        authCubit.initialize,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listenWhen: (previous, current) {
            return previous.userOption.isNone() && current.userOption.isSome();
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
            Navigator.pushReplacement(context, LoginPage.route());
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: context.appTheme.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                ScaleTransition(
                  scale: _animation,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.asset(
                        width: size.width * 0.4,
                        height: size.width * 0.4,
                        AppAssets.nostalgixLogo.path,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'from AppDay',
                    style: TextStyle(
                      color: context.appTheme.textPrimary,
                      fontSize: 16,
                      fontFamily: AppFonts.lato.family,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
