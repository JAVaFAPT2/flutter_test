import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

import '../constants/app_constants.dart';
// import '../network/api_client.dart';
import '../network/network_interceptor.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Logger
  getIt.registerLazySingleton<Logger>(() => Logger(
        printer: PrettyPrinter(
          methodCount: 2,
          errorMethodCount: 8,
          lineLength: 120,
          colors: true,
          printEmojis: true,
          dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
        ),
      ));

  // Network - Dio
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout:
          const Duration(milliseconds: AppConstants.connectionTimeout),
      receiveTimeout: const Duration(milliseconds: AppConstants.receiveTimeout),
      sendTimeout: const Duration(milliseconds: AppConstants.sendTimeout),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Add interceptors
    dio.interceptors.add(NetworkInterceptor(getIt<Logger>()));

    return dio;
  });

  // API Client - will be implemented with proper models later
  // getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt<Dio>()));

  // Core utilities
  _registerCoreUtilities();

  // Features - will be implemented later
  // _registerAuthFeature();
  // _registerHomeFeature();
  // _registerProductFeature();
  // _registerCartFeature();
  // _registerOrderFeature();
  // _registerProfileFeature();
}

void _registerCoreUtilities() {
  // Storage utilities
  // getIt.registerLazySingleton<StorageService>(
  //   () => StorageService(getIt<SharedPreferences>()),
  // );

  // Cache utilities
  // getIt.registerLazySingleton<CacheService>(
  //   () => CacheService(getIt<SharedPreferences>()),
  // );

  // Validation utilities
  // getIt.registerLazySingleton<ValidationService>(
  //   () => ValidationService(),
  // );

  // Image processing utilities
  // getIt.registerLazySingleton<ImageService>(
  //   () => ImageService(),
  // );
}

// Future feature registrations will be added here
// void _registerAuthFeature() {
//   // Auth data sources
//   // Auth repositories
//   // Auth use cases
//   // Auth BLoCs
// }

// void _registerHomeFeature() {
//   // Home data sources
//   // Home repositories
//   // Home use cases
//   // Home BLoCs
// }

// void _registerProductFeature() {
//   // Product data sources
//   // Product repositories
//   // Product use cases
//   // Product BLoCs
// }

// void _registerCartFeature() {
//   // Cart data sources
//   // Cart repositories
//   // Cart use cases
//   // Cart BLoCs
// }

// void _registerOrderFeature() {
//   // Order data sources
//   // Order repositories
//   // Order use cases
//   // Order BLoCs
// }

// void _registerProfileFeature() {
//   // Profile data sources
//   // Profile repositories
//   // Profile use cases
//   // Profile BLoCs
// }
