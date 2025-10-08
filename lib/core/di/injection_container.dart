import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Core domain
import 'package:vietnamese_fish_sauce_app/core/domain/repositories/auth_repository.dart';
import 'package:vietnamese_fish_sauce_app/core/domain/usecases/auth/login_use_case.dart';
import 'package:vietnamese_fish_sauce_app/core/domain/usecases/auth/register_use_case.dart';
import 'package:vietnamese_fish_sauce_app/core/domain/usecases/auth/otp_verification_use_case.dart';

// Core fake data
import 'package:vietnamese_fish_sauce_app/core/fake/fake_firestore.dart';

// Auth feature
import 'package:vietnamese_fish_sauce_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:vietnamese_fish_sauce_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:vietnamese_fish_sauce_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:vietnamese_fish_sauce_app/features/auth/presentation/bloc/auth_bloc.dart';

// Cart feature
import 'package:vietnamese_fish_sauce_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/domain/usecases/add_item_to_cart.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/domain/usecases/remove_item_from_cart.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/domain/usecases/update_item_quantity.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/domain/usecases/clear_cart.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/domain/usecases/toggle_cart_edit_mode.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/domain/usecases/toggle_item_selection.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/domain/usecases/toggle_select_all.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/domain/usecases/delete_selected_items.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/domain/usecases/get_cart.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/data/datasources/cart_local_datasource.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/presentation/bloc/cart_bloc.dart';

// Product feature
import 'package:vietnamese_fish_sauce_app/features/product/domain/repositories/product_repository.dart';
import 'package:vietnamese_fish_sauce_app/features/product/domain/usecases/get_product_detail_query.dart';
import 'package:vietnamese_fish_sauce_app/features/product/domain/usecases/get_products_query.dart';
import 'package:vietnamese_fish_sauce_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:vietnamese_fish_sauce_app/features/product/application/bloc/product_detail_bloc.dart';
import 'package:vietnamese_fish_sauce_app/features/product/application/bloc/product_list_bloc.dart';
import 'package:vietnamese_fish_sauce_app/features/product/presentation/bloc/product_bloc.dart';

// Order feature
import 'package:vietnamese_fish_sauce_app/features/order/domain/repositories/order_repository.dart';
import 'package:vietnamese_fish_sauce_app/features/order/domain/usecases/get_orders_usecase.dart';
import 'package:vietnamese_fish_sauce_app/features/order/domain/usecases/get_order_detail_usecase.dart';
import 'package:vietnamese_fish_sauce_app/features/order/data/repositories/order_repository_impl.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/bloc/order_bloc.dart';

// Home feature
import 'package:vietnamese_fish_sauce_app/features/home/domain/repositories/home_repository.dart';
import 'package:vietnamese_fish_sauce_app/features/home/domain/usecases/get_banners.dart';
import 'package:vietnamese_fish_sauce_app/features/home/domain/usecases/get_categories.dart';
import 'package:vietnamese_fish_sauce_app/features/home/domain/usecases/get_featured_products.dart';
import 'package:vietnamese_fish_sauce_app/features/home/domain/usecases/get_sale_products.dart';
import 'package:vietnamese_fish_sauce_app/features/home/data/datasources/home_remote_datasource.dart';
import 'package:vietnamese_fish_sauce_app/features/home/data/repositories/home_repository_impl.dart';

// Profile feature
import 'package:vietnamese_fish_sauce_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:vietnamese_fish_sauce_app/features/profile/domain/usecases/get_user_profile.dart';
import 'package:vietnamese_fish_sauce_app/features/profile/domain/usecases/update_user_profile.dart';
import 'package:vietnamese_fish_sauce_app/features/profile/domain/usecases/change_password.dart';
import 'package:vietnamese_fish_sauce_app/features/profile/domain/usecases/update_settings.dart';
import 'package:vietnamese_fish_sauce_app/features/profile/data/repositories/profile_repository_impl.dart';

// Shared
import 'package:vietnamese_fish_sauce_app/shared/cubit/navigation_cubit.dart';

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

  // BLoCs and Cubits
  _initializeBlocs();
}

/// Initialize external dependencies (third-party libraries)
Future<void> _initializeExternalDependencies() async {
  // SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // FlutterSecureStorage
  const secureStorage = FlutterSecureStorage();
  getIt.registerSingleton<FlutterSecureStorage>(secureStorage);

  // FakeFirestore (temporary, replace with real Firebase/API later)
  getIt.registerSingleton<FakeFirestore>(FakeFirestore.instance);
}

/// Initialize data sources
void _initializeDataSources() {
  // Auth data sources
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(getIt<FlutterSecureStorage>()),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  // Cart data sources
  getIt.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(getIt<SharedPreferences>()),
  );

  // Home data sources
  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(getIt<FakeFirestore>()),
  );
}

/// Initialize repositories
void _initializeRepositories() {
  // Core auth repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt<AuthRemoteDataSource>(),
      localDataSource: getIt<AuthLocalDataSource>(),
    ),
  );

  // Cart repository
  getIt.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(getIt<CartLocalDataSource>()),
  );

  // Product repository
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(getIt<FakeFirestore>()),
  );

  // Order repository
  getIt.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(getIt<FakeFirestore>()),
  );

  // Home repository
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(getIt<HomeRemoteDataSource>()),
  );

  // Profile repository
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(getIt<SharedPreferences>()),
  );
}

/// Initialize use cases
void _initializeUseCases() {
  // Auth use cases
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<OtpVerificationUseCase>(
    () => OtpVerificationUseCase(getIt<AuthRepository>()),
  );

  // Cart use cases
  getIt.registerLazySingleton<AddItemToCart>(
    () => AddItemToCart(getIt<CartRepository>()),
  );

  getIt.registerLazySingleton<RemoveItemFromCart>(
    () => RemoveItemFromCart(getIt<CartRepository>()),
  );

  getIt.registerLazySingleton<UpdateItemQuantity>(
    () => UpdateItemQuantity(getIt<CartRepository>()),
  );

  getIt.registerLazySingleton<ClearCart>(
    () => ClearCart(getIt<CartRepository>()),
  );

  getIt.registerLazySingleton<ToggleCartEditMode>(
    () => ToggleCartEditMode(getIt<CartRepository>()),
  );

  getIt.registerLazySingleton<ToggleItemSelection>(
    () => ToggleItemSelection(getIt<CartRepository>()),
  );

  getIt.registerLazySingleton<ToggleSelectAll>(
    () => ToggleSelectAll(getIt<CartRepository>()),
  );

  getIt.registerLazySingleton<DeleteSelectedItems>(
    () => DeleteSelectedItems(getIt<CartRepository>()),
  );

  getIt.registerLazySingleton<GetCart>(
    () => GetCart(getIt<CartRepository>()),
  );

  // Product use cases
  getIt.registerLazySingleton<GetProductDetailQuery>(
    () => GetProductDetailQuery(getIt<ProductRepository>()),
  );

  getIt.registerLazySingleton<GetProductsQuery>(
    () => GetProductsQuery(getIt<ProductRepository>()),
  );

  // Order use cases
  getIt.registerLazySingleton<GetOrdersUseCase>(
    () => GetOrdersUseCase(getIt<OrderRepository>()),
  );

  getIt.registerLazySingleton<GetOrderDetailUseCase>(
    () => GetOrderDetailUseCase(getIt<OrderRepository>()),
  );

  // Home use cases
  getIt.registerLazySingleton<GetBanners>(
    () => GetBanners(getIt<HomeRepository>()),
  );

  getIt.registerLazySingleton<GetCategories>(
    () => GetCategories(getIt<HomeRepository>()),
  );

  getIt.registerLazySingleton<GetFeaturedProducts>(
    () => GetFeaturedProducts(getIt<HomeRepository>()),
  );

  getIt.registerLazySingleton<GetSaleProducts>(
    () => GetSaleProducts(getIt<HomeRepository>()),
  );

  // Profile use cases
  getIt.registerLazySingleton<GetUserProfile>(
    () => GetUserProfile(getIt<ProfileRepository>()),
  );

  getIt.registerLazySingleton<UpdateUserProfile>(
    () => UpdateUserProfile(getIt<ProfileRepository>()),
  );

  getIt.registerLazySingleton<ChangePassword>(
    () => ChangePassword(getIt<ProfileRepository>()),
  );

  getIt.registerLazySingleton<UpdateSettings>(
    () => UpdateSettings(getIt<ProfileRepository>()),
  );
}

/// Initialize BLoCs and Cubits
void _initializeBlocs() {
  // Auth BLoC
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      loginUseCase: getIt<LoginUseCase>(),
      registerUseCase: getIt<RegisterUseCase>(),
      otpUseCase: getIt<OtpVerificationUseCase>(),
      authRepository: getIt<AuthRepository>(),
    ),
  );

  // Cart BLoC
  getIt.registerFactory<CartBloc>(
    () => CartBloc(
      addItemToCart: getIt<AddItemToCart>(),
      removeItemFromCart: getIt<RemoveItemFromCart>(),
      updateItemQuantity: getIt<UpdateItemQuantity>(),
      clearCart: getIt<ClearCart>(),
      toggleCartEditMode: getIt<ToggleCartEditMode>(),
      toggleItemSelection: getIt<ToggleItemSelection>(),
      toggleSelectAll: getIt<ToggleSelectAll>(),
      deleteSelectedItems: getIt<DeleteSelectedItems>(),
      getCart: getIt<GetCart>(),
    ),
  );

  // Product BLoCs
  getIt.registerFactory<ProductBloc>(
    () => ProductBloc(
      getProductsUseCase: getIt<GetProductsQuery>(),
    ),
  );

  getIt.registerFactory<ProductDetailBloc>(
    () => ProductDetailBloc(
      getDetail: getIt<GetProductDetailQuery>(),
    ),
  );

  getIt.registerFactory<ProductListBloc>(
    () => ProductListBloc(
      getProducts: getIt<GetProductsQuery>(),
    ),
  );

  // Order BLoC
  getIt.registerFactory<OrderBloc>(
    () => OrderBloc(
      getOrders: getIt<GetOrdersUseCase>(),
    ),
  );

  // Navigation Cubit (shared)
  getIt.registerFactory<NavigationCubit>(
    () => NavigationCubit(),
  );
}
