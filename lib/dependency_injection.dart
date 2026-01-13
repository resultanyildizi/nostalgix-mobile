import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:nostalgix/application/auth_cubit/auth_cubit.dart';
import 'package:nostalgix/application/bottom_navbar_cubit/bottom_navbar_cubit.dart';
import 'package:nostalgix/infrastructure/auth/auth_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

final getIt = GetIt.instance;

Future<void> setupInjection() async {
  final sharedPref = await SharedPreferences.getInstance();

  // Third party dependencies.
  getIt.registerSingleton<Client>(Client());
  getIt.registerSingleton<Uuid>(Uuid());
  getIt.registerSingleton<SharedPreferences>(sharedPref);
  getIt.registerSingleton<FlutterSecureStorage>(FlutterSecureStorage());

  // Infrastructure layer dependencies.
  getIt.registerSingleton<AuthClient>(AuthClient(
    uuid: getIt<Uuid>(),
    client: getIt<Client>(),
    secureStorage: getIt<FlutterSecureStorage>(),
  ));

  // Application layer dependencies.
  getIt.registerFactory<AuthCubit>(() {
    return AuthCubit(getIt<AuthClient>());
  });
  getIt.registerFactory<BottomNavbarCubit>(() {
    return BottomNavbarCubit();
  });
}
