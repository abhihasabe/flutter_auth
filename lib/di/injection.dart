import 'package:gs_diamond/core/manager/cache_manager.dart';
import 'package:gs_diamond/core/manager/http_client_manager.dart';
import 'package:gs_diamond/core/manager/network_info_manager.dart';
import 'package:gs_diamond/features/authentication/presentation/bloc_cubit/login_cubit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> init() async {
  await initGlobals();
  await initManagers();
  await initCubits();
  await initUseCases();
  await initRepositories();
  await initDataSources();
}

Future<void> initGlobals() async {
  locator.registerLazySingleton<Future<SharedPreferences>>(
          () => SharedPreferences.getInstance());
  locator.registerLazySingleton<InternetConnectionChecker>(
          () => InternetConnectionChecker());
  locator.registerLazySingleton(() => http.Client());
}

Future<void> initManagers() async {
  var sharedPrefs = await locator.get<Future<SharedPreferences>>();
  locator.registerLazySingleton<HttpClientManager>(
          () => HttpClientManagerImpl(initClient: locator()));
  locator.registerLazySingleton<CacheManager>(
          () => CacheManagerImpl(initSharedPref: sharedPrefs));
  locator.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImpl(connectionChecker: locator()));
}

Future<void> initCubits() async {
  locator.registerFactory(() => LoginCubit());
}

Future<void> initUseCases() async {}

Future<void> initRepositories() async {}

Future<void> initDataSources() async {}

