import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:budget_mobile/core/routes/router.dart';
import 'package:budget_mobile/di/injection.config.dart';
import 'package:budget_mobile/core/network/interceptors/dio_interceptor.dart';

//* Get instance of GetIt.
final locator = GetIt.instance;

@InjectableInit(initializerName: r'$initGetIt', preferRelativeImports: true, asExtension: false)
Future<void> configure() async => $initGetIt(locator);

@module
abstract class RegisterModule {
  //* Register AppRouter
  @lazySingleton
  AppRouter get appRouter => AppRouter();

  //* Register SharedPreferences module
  @lazySingleton
  Future<SharedPreferences> get sharedPreferences async {
    return await SharedPreferences.getInstance();
  }

  //* Register Dio module
  @lazySingleton
  Dio get client {
    final options = BaseOptions(sendTimeout: const Duration(seconds: 60));
    return Dio(options)..addInterceptors();
  }
}
