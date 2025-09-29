import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../data/datasources/local/local_storage.dart';
import '../../data/datasources/local/secure_storage.dart';
import '../../data/datasources/remote/api_client.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/use_cases/auth/login_use_case.dart';
import '../../domain/use_cases/auth/otp_verification_use_case.dart';
import '../../domain/use_cases/auth/register_use_case.dart';
import '../../domain/use_cases/product/get_products_use_case.dart';
import '../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../features/product/presentation/bloc/product_bloc.dart';
import '../../../features/cart/presentation/bloc/cart_bloc.dart';

/// Dependency injection container using GetIt
/// Configured with Clean Architecture principles
final GetIt getIt = GetIt.instance;

/// Initialize all dependencies
Future<void> initializeDependencies() async {
  // External dependencies
  await _initializeExternalDependencies();

  // Data sources
  _initializeDataSources();

  // Repositories
  _initializeRepositories();

  // Use cases
  _initializeUseCases();

  // Blocs (State Management)
  _initializeBlocs();
}

/// Initialize external dependencies (third-party libraries)
Future<void> _initializeExternalDependencies() async {
  // SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // SecureStorage
  const secureStorage = FlutterSecureStorage();
  getIt.registerSingleton<FlutterSecureStorage>(secureStorage);

  // Dio client
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.mgf-vietnam.com',
    connectTimeout: const Duration(milliseconds: 30000),
    receiveTimeout: const Duration(milliseconds: 30000),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  // Add interceptors for logging and authentication
  dio.interceptors.addAll([
    LogInterceptor(requestBody: true, responseBody: true),
    // AuthInterceptor(), // Will be added when auth is implemented
  ]);

  getIt.registerSingleton<Dio>(dio);
}

/// Initialize data sources
void _initializeDataSources() {
  // Local storage data source
  getIt.registerLazySingleton<LocalStorage>(
    () => LocalStorageImpl(getIt<SharedPreferences>()),
  );

  // Secure storage data source
  getIt.registerLazySingleton<SecureStorage>(
    () => SecureStorageImpl(getIt<FlutterSecureStorage>()),
  );

  // API client data source
  getIt.registerLazySingleton<ApiClient>(
    () => ApiClientImpl(getIt<Dio>()),
  );
}

/// Initialize repositories
void _initializeRepositories() {
  // Authentication repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      localStorage: getIt<LocalStorage>(),
      secureStorage: getIt<SecureStorage>(),
      apiClient: getIt<ApiClient>(),
    ),
  );

  // Product repository
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      apiClient: getIt<ApiClient>(),
      localStorage: getIt<LocalStorage>(),
    ),
  );
}

/// Initialize use cases
void _initializeUseCases() {
  // Authentication use cases
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<OtpVerificationUseCase>(
    () => OtpVerificationUseCase(getIt<AuthRepository>()),
  );

  // Product use cases
  getIt.registerLazySingleton<GetProductsUseCase>(
    () => GetProductsUseCase(getIt<ProductRepository>()),
  );
}

/// Initialize blocs (State Management)
void _initializeBlocs() {
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      loginUseCase: getIt<LoginUseCase>(),
      registerUseCase: getIt<RegisterUseCase>(),
      otpUseCase: getIt<OtpVerificationUseCase>(),
      secureStorage: getIt<SecureStorage>(),
    ),
  );

  getIt.registerFactory<ProductBloc>(
    () => ProductBloc(
      getProductsUseCase: getIt<GetProductsUseCase>(),
    ),
  );

  getIt.registerFactory<CartBloc>(
    () => CartBloc(),
  );
}
