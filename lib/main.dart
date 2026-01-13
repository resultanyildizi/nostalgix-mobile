import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nostalgix/application/auth_cubit/auth_cubit.dart';
import 'package:nostalgix/application/bottom_navbar_cubit/bottom_navbar_cubit.dart';
import 'package:nostalgix/dependency_injection.dart';
import 'package:nostalgix/presentation/splash/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthCubit>()),
        BlocProvider(create: (context) => getIt<BottomNavbarCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nostalgix',
        theme: ThemeData(
          splashFactory: NoSplash.splashFactory,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
        ),
        home: SplashPage(),
      ),
    );
  }
}
// class NoSplash extends StatelessWidget {
//   NoSplash({this.child});

//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return NotificationListener<OverscrollIndicatorNotification>(
//         onNotification: (OverscrollIndicatorNotification overscroll) {
//           overscroll.disallowGlow();
//           return true;
//         },
//         child: child);
//   }
// }
