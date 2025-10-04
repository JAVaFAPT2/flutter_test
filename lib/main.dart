import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'src/core/constants/app_constants.dart';
import 'src/core/di/injection_container.dart' as di;
import 'app/routes/app_router.dart';
import 'core/design_system/app_theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/product/presentation/bloc/product_bloc.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'shared/cubit/navigation_cubit.dart';
import 'core/fake/fake_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await di.initializeDependencies();

  // Add sample products matching Figma designs with detailed data
  await FakeFirestore.instance.seedProducts([
    {
      'id': 'figma-sample-1',
      'name': 'Xuân Thịnh Mậu',
      'subtitle': 'Nước mắm nhĩ cá cơm',
      'price': '225,000 VNĐ',
      'description':
          'Nước mắm nhĩ cá cơm than là loại món ăn bổ dưỡng bậc nhất, với 13 loại enzyme mà cơ thể con người không thể tự tổng hợp được, rất cần thiết cho hệ thần kinh của chúng ta.',
      'imageUrl': 'assets/figma_exports/product_xtm_500ml.png',
      'images': [
        'assets/figma_exports/product_xtm_500ml.png',
        'assets/figma_exports/gallery_image_1.png',
        'assets/figma_exports/gallery_image_2.png',
      ],
      'volumes': ['500 ML', '330 ML', '250 ML'],
      'volumePrices': {
        '500 ML': 225000,
        '330 ML': 153000,
        '250 ML': 120000,
      },
      'rating': 5.0,
      'reviewCount': 125,
      'category': 'premium',
      'origin': 'Phú Quốc, Việt Nam',
      'ingredients': ['Cá cơm', 'Muối biển', 'Nước'],
      'nutritionInfo': {
        'Protein': '15g/100ml',
        'Sodium': '12g/100ml',
        'Calories': '45 kcal/100ml',
      },
      'inStock': true,
      'stockQuantity': 50,
      'isFeatured': true,
      'isOnSale': false,
      'brand': 'Xuân Thịnh Mậu',
    },
    {
      'id': 'figma-sample-2',
      'name': 'Vĩnh Thái',
      'subtitle': 'Nước mắm nhĩ cá cơm',
      'price': '153,000 VNĐ',
      'description':
          'Nước mắm nhĩ cá cơm than là loại món ăn bổ dưỡng bậc nhất, với 13 loại enzyme mà cơ thể con người không thể tự tổng hợp được, rất cần thiết cho hệ thần kinh của chúng ta.',
      'imageUrl': 'assets/figma_exports/product_vinh_thai.png',
      'images': [
        'assets/figma_exports/product_vinh_thai.png',
        'assets/figma_exports/gallery_image_3.png',
      ],
      'volumes': ['500 ML', '330 ML', '250 ML'],
      'volumePrices': {
        '500 ML': 200000,
        '330 ML': 153000,
        '250 ML': 110000,
      },
      'rating': 4.8,
      'reviewCount': 89,
      'category': 'traditional',
      'origin': 'Nha Trang, Việt Nam',
      'ingredients': ['Cá cơm', 'Muối biển', 'Nước', 'Đường'],
      'nutritionInfo': {
        'Protein': '14g/100ml',
        'Sodium': '11g/100ml',
        'Calories': '42 kcal/100ml',
      },
      'inStock': true,
      'stockQuantity': 30,
      'isFeatured': false,
      'isOnSale': true,
      'originalPrice': '180,000 VNĐ',
      'discountPercentage': 15,
      'brand': 'Vĩnh Thái',
    },
    {
      'id': 'sample-3',
      'name': 'Nước mắm Phú Quốc',
      'subtitle': 'Nước mắm truyền thống',
      'price': '180,000 VNĐ',
      'description':
          'Nước mắm Phú Quốc truyền thống với hương vị đậm đà, được ủ trong thùng gỗ bạch đàn.',
      'imageUrl': 'assets/figma_exports/product_xtm_500ml.png',
      'images': ['assets/figma_exports/product_xtm_500ml.png'],
      'volumes': ['500 ML', '330 ML'],
      'volumePrices': {
        '500 ML': 180000,
        '330 ML': 130000,
      },
      'rating': 4.5,
      'reviewCount': 67,
      'category': 'premium',
      'origin': 'Phú Quốc, Việt Nam',
      'ingredients': ['Cá cơm', 'Muối biển'],
      'nutritionInfo': {
        'Protein': '16g/100ml',
        'Sodium': '13g/100ml',
      },
      'inStock': true,
      'stockQuantity': 25,
      'isFeatured': false,
      'isOnSale': false,
      'brand': 'Phú Quốc',
    },
  ]);

  runApp(const VietnameseFishSauceApp());
}

/// Main application widget for Vietnamese fish sauce e-commerce app
class VietnameseFishSauceApp extends StatelessWidget {
  const VietnameseFishSauceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => di.getIt<AuthBloc>()),
        BlocProvider<ProductBloc>(create: (_) => di.getIt<ProductBloc>()),
        BlocProvider<CartBloc>(create: (_) => di.getIt<CartBloc>()),
        BlocProvider<NavigationCubit>(create: (_) => NavigationCubit()),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (prev, curr) =>
            prev.isAuthenticated != curr.isAuthenticated,
        listener: (context, state) {
          if (state.isAuthenticated) {
            GoRouter.of(context).go('/home');
          }
        },
        child: MaterialApp.router(
          title: AppConstants.appName,
          theme: AppTheme.light(),
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('vi', 'VN'), // Vietnamese
            Locale('en', 'US'), // English fallback
          ],
        ),
      ),
    );
  }
}
