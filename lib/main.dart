import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nostalgix/application/auth_cubit/auth_cubit.dart';
import 'package:nostalgix/application/bottom_navbar_cubit/bottom_navbar_cubit.dart';
import 'package:nostalgix/dependency_injection.dart';
import 'package:nostalgix/presentation/splash/splash_page.dart';
import 'package:provider/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjection();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fToast.init(navigatorKey.currentContext!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthCubit>()),
        BlocProvider(create: (context) => getIt<BottomNavbarCubit>()),
        Provider.value(value: fToast),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'Nostalgix',
        theme: ThemeData(
          splashFactory: NoSplash.splashFactory,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
        ),
        builder: (context, child) {
          return Overlay(
            initialEntries: [
              if (child != null) ...[
                OverlayEntry(builder: (_) => child),
              ],
            ],
          );
        },
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
