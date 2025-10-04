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
import '../../core/env/config.dart';
import '../../core/network/http_client.dart';
import '../../core/network/interceptors.dart';
import '../../core/tenant/tenant_provider.dart';
// import '../../core/logging/logger.dart';
import '../../../core/fake/fake_firestore.dart';
import '../../../features/product/application/bloc/product_detail_bloc.dart'
    as newdetail;
import '../../../features/product/domain/usecases/get_product_detail_query.dart'
    as newusecase;
import '../../../features/product/domain/repositories/product_repository.dart'
    as newrepo;
import '../../../features/product/data/repositories/product_repository_impl.dart'
    as features_product_repo;
import '../../../features/product/application/bloc/product_list_bloc.dart'
    as newlist;
import '../../../features/product/domain/usecases/get_products_query.dart'
    as newlistusecase;

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

  // Dio client with base options
  final dio = Dio(BaseOptions(
    baseUrl: AppConfig.baseUrl,
    connectTimeout: AppConfig.connectTimeout,
    receiveTimeout: AppConfig.receiveTimeout,
    headers: const {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  // Register Dio and our HttpClient wrapper
  getIt.registerSingleton<Dio>(dio);
  getIt.registerLazySingleton<HttpClient>(() => HttpClient(dio: dio));
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

  // Tenant provider (after SecureStorage is ready)
  final tenantProvider = TenantProvider(getIt<SecureStorage>());
  getIt.registerSingleton<TenantProvider>(tenantProvider);

  // Attach auth/tenant/logging interceptors now that dependencies exist
  final dio = getIt<Dio>();
  dio.interceptors.addAll([
    AuthInterceptor(() => getIt<SecureStorage>().getSecureToken()),
    TenantInterceptor(() => tenantProvider.getTenantId()),
    LoggingInterceptor(),
    LogInterceptor(requestBody: true, responseBody: true),
  ]);

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

  // New feature-layer product repository (using FakeFirestore for now)
  getIt.registerLazySingleton<newrepo.ProductRepository>(
    () => features_product_repo.ProductRepositoryImpl(FakeFirestore.instance),
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

  // New product detail query use case (DDD path)
  getIt.registerLazySingleton<newusecase.GetProductDetailQuery>(
    () => newusecase.GetProductDetailQuery(getIt<newrepo.ProductRepository>()),
  );

  // New product list query use case (DDD path)
  getIt.registerLazySingleton<newlistusecase.GetProductsQuery>(
    () => newlistusecase.GetProductsQuery(getIt<newrepo.ProductRepository>()),
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

  // New ProductDetailBloc
  getIt.registerFactory<newdetail.ProductDetailBloc>(
    () => newdetail.ProductDetailBloc(
      getDetail: getIt<newusecase.GetProductDetailQuery>(),
    ),
  );

  // New ProductListBloc
  getIt.registerFactory<newlist.ProductListBloc>(
    () => newlist.ProductListBloc(
      getProducts: getIt<newlistusecase.GetProductsQuery>(),
    ),
  );

  getIt.registerFactory<CartBloc>(
    () => CartBloc(),
  );
}
