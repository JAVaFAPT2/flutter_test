import 'package:get_it/get_it.dart';

/// Thin wrapper over GetIt to keep DI calls consistent and hide raw API
class ServiceLocator {
  ServiceLocator._();
  static final GetIt _getIt = GetIt.instance;

  static T locate<T extends Object>() => _getIt<T>();

  static void registerSingleton<T extends Object>(T instance) =>
      _getIt.registerSingleton<T>(instance);

  static void registerLazySingleton<T extends Object>(T Function() factoryFn) =>
      _getIt.registerLazySingleton<T>(factoryFn);

  static void registerFactory<T extends Object>(T Function() factoryFn) =>
      _getIt.registerFactory<T>(factoryFn);
}

