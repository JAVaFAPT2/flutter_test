import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:vietnamese_fish_sauce_app/features/product/domain/entities/product_entity.dart';
import 'package:vietnamese_fish_sauce_app/features/product/domain/repositories/product_repository.dart';
import 'package:vietnamese_fish_sauce_app/features/product/presentation/cubit/product_detail_cubit.dart';

import 'product_detail_cubit_test.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  group('ProductDetailCubit', () {
    late ProductDetailCubit cubit;
    late MockProductRepository mockRepository;

    setUp(() {
      mockRepository = MockProductRepository();
      cubit = ProductDetailCubit(mockRepository);
    });

    tearDown(() {
      cubit.close();
    });

    group('ProductDetailLoadRequested', () {
      const productId = 'test-product-id';
      final testProduct = ProductEntity(
        id: productId,
        name: 'Test Product',
        subtitle: 'Test Subtitle',
        price: '100,000 VNĐ',
        imageUrl: 'test-image.jpg',
        volumes: ['500 ML', '330 ML', '250 ML'],
        volumePrices: {
          '500 ML': 100000,
          '330 ML': 80000,
          '250 ML': 60000,
        },
        rating: 4.5,
        reviewCount: 100,
        description: 'Test description',
        category: 'test-category',
        origin: 'Test Origin',
        ingredients: ['ingredient1', 'ingredient2'],
        nutritionInfo: {'protein': '10g'},
        inStock: true,
        stockQuantity: 50,
        isFeatured: false,
        isOnSale: false,
        originalPrice: '',
        discountPercentage: 0,
        brand: 'Test Brand',
      );

      blocTest<ProductDetailCubit, ProductDetailState>(
        'emits [ProductDetailLoading, ProductDetailLoaded] when product is found',
        build: () {
          when(mockRepository.getById(productId))
              .thenAnswer((_) async => testProduct);
          return cubit;
        },
        act: (cubit) => cubit.loadProduct(productId),
        expect: () => [
          const ProductDetailLoading(),
          ProductDetailLoaded(
            product: testProduct,
            selectedVolumeIndex: 0,
            quantity: 1,
          ),
        ],
        verify: (_) {
          verify(mockRepository.getById(productId)).called(1);
        },
      );

      blocTest<ProductDetailCubit, ProductDetailState>(
        'emits [ProductDetailLoading, ProductDetailError] when product is not found',
        build: () {
          when(mockRepository.getById(productId)).thenAnswer((_) async => null);
          return cubit;
        },
        act: (cubit) => cubit.loadProduct(productId),
        expect: () => [
          const ProductDetailLoading(),
          const ProductDetailError('Product not found'),
        ],
        verify: (_) {
          verify(mockRepository.getById(productId)).called(1);
        },
      );

      blocTest<ProductDetailCubit, ProductDetailState>(
        'emits [ProductDetailLoading, ProductDetailError] when repository throws exception',
        build: () {
          when(mockRepository.getById(productId))
              .thenThrow(Exception('Network error'));
          return cubit;
        },
        act: (cubit) => cubit.loadProduct(productId),
        expect: () => [
          const ProductDetailLoading(),
          const ProductDetailError(
              'Failed to load product: Exception: Network error'),
        ],
        verify: (_) {
          verify(mockRepository.getById(productId)).called(1);
        },
      );
    });

    group('ProductDetailVolumeChanged', () {
      final testProduct = ProductEntity(
        id: 'test-id',
        name: 'Test Product',
        subtitle: 'Test Subtitle',
        price: '100,000 VNĐ',
        imageUrl: 'test-image.jpg',
        volumes: ['500 ML', '330 ML', '250 ML'],
        volumePrices: {
          '500 ML': 100000,
          '330 ML': 80000,
          '250 ML': 60000,
        },
        rating: 4.5,
        reviewCount: 100,
        description: 'Test description',
        category: 'test-category',
        origin: 'Test Origin',
        ingredients: ['ingredient1', 'ingredient2'],
        nutritionInfo: {'protein': '10g'},
        inStock: true,
        stockQuantity: 50,
        isFeatured: false,
        isOnSale: false,
        originalPrice: '',
        discountPercentage: 0,
        brand: 'Test Brand',
      );

      blocTest<ProductDetailCubit, ProductDetailState>(
        'changes selected volume index when valid index is provided',
        build: () {
          when(mockRepository.getById(any))
              .thenAnswer((_) async => testProduct);
          return cubit;
        },
        seed: () => ProductDetailLoaded(
          product: testProduct,
          selectedVolumeIndex: 0,
          quantity: 1,
        ),
        act: (cubit) => cubit.changeVolume(1),
        expect: () => [
          ProductDetailLoaded(
            product: testProduct,
            selectedVolumeIndex: 1,
            quantity: 1,
          ),
        ],
      );

      blocTest<ProductDetailCubit, ProductDetailState>(
        'does not change volume when invalid index is provided',
        build: () {
          when(mockRepository.getById(any))
              .thenAnswer((_) async => testProduct);
          return cubit;
        },
        seed: () => ProductDetailLoaded(
          product: testProduct,
          selectedVolumeIndex: 0,
          quantity: 1,
        ),
        act: (cubit) => cubit.changeVolume(5), // Invalid index
        expect: () => [],
      );
    });

    group('ProductDetailQuantityIncremented', () {
      final testProduct = ProductEntity(
        id: 'test-id',
        name: 'Test Product',
        subtitle: 'Test Subtitle',
        price: '100,000 VNĐ',
        imageUrl: 'test-image.jpg',
        volumes: ['500 ML', '330 ML', '250 ML'],
        volumePrices: {
          '500 ML': 100000,
          '330 ML': 80000,
          '250 ML': 60000,
        },
        rating: 4.5,
        reviewCount: 100,
        description: 'Test description',
        category: 'test-category',
        origin: 'Test Origin',
        ingredients: ['ingredient1', 'ingredient2'],
        nutritionInfo: {'protein': '10g'},
        inStock: true,
        stockQuantity: 50,
        isFeatured: false,
        isOnSale: false,
        originalPrice: '',
        discountPercentage: 0,
        brand: 'Test Brand',
      );

      blocTest<ProductDetailCubit, ProductDetailState>(
        'increments quantity by 1',
        build: () {
          when(mockRepository.getById(any))
              .thenAnswer((_) async => testProduct);
          return cubit;
        },
        seed: () => ProductDetailLoaded(
          product: testProduct,
          selectedVolumeIndex: 0,
          quantity: 1,
        ),
        act: (cubit) => cubit.incrementQuantity(),
        expect: () => [
          ProductDetailLoaded(
            product: testProduct,
            selectedVolumeIndex: 0,
            quantity: 2,
          ),
        ],
      );
    });

    group('ProductDetailQuantityDecremented', () {
      final testProduct = ProductEntity(
        id: 'test-id',
        name: 'Test Product',
        subtitle: 'Test Subtitle',
        price: '100,000 VNĐ',
        imageUrl: 'test-image.jpg',
        volumes: ['500 ML', '330 ML', '250 ML'],
        volumePrices: {
          '500 ML': 100000,
          '330 ML': 80000,
          '250 ML': 60000,
        },
        rating: 4.5,
        reviewCount: 100,
        description: 'Test description',
        category: 'test-category',
        origin: 'Test Origin',
        ingredients: ['ingredient1', 'ingredient2'],
        nutritionInfo: {'protein': '10g'},
        inStock: true,
        stockQuantity: 50,
        isFeatured: false,
        isOnSale: false,
        originalPrice: '',
        discountPercentage: 0,
        brand: 'Test Brand',
      );

      blocTest<ProductDetailCubit, ProductDetailState>(
        'decrements quantity by 1 but not below 1',
        build: () {
          when(mockRepository.getById(any))
              .thenAnswer((_) async => testProduct);
          return cubit;
        },
        seed: () => ProductDetailLoaded(
          product: testProduct,
          selectedVolumeIndex: 0,
          quantity: 2,
        ),
        act: (cubit) => cubit.decrementQuantity(),
        expect: () => [
          ProductDetailLoaded(
            product: testProduct,
            selectedVolumeIndex: 0,
            quantity: 1,
          ),
        ],
      );

      blocTest<ProductDetailCubit, ProductDetailState>(
        'does not decrement quantity below 1',
        build: () {
          when(mockRepository.getById(any))
              .thenAnswer((_) async => testProduct);
          return cubit;
        },
        seed: () => ProductDetailLoaded(
          product: testProduct,
          selectedVolumeIndex: 0,
          quantity: 1,
        ),
        act: (cubit) => cubit.decrementQuantity(),
        expect: () => [],
      );
    });

    group('ProductDetailQuantitySet', () {
      final testProduct = ProductEntity(
        id: 'test-id',
        name: 'Test Product',
        subtitle: 'Test Subtitle',
        price: '100,000 VNĐ',
        imageUrl: 'test-image.jpg',
        volumes: ['500 ML', '330 ML', '250 ML'],
        volumePrices: {
          '500 ML': 100000,
          '330 ML': 80000,
          '250 ML': 60000,
        },
        rating: 4.5,
        reviewCount: 100,
        description: 'Test description',
        category: 'test-category',
        origin: 'Test Origin',
        ingredients: ['ingredient1', 'ingredient2'],
        nutritionInfo: {'protein': '10g'},
        inStock: true,
        stockQuantity: 50,
        isFeatured: false,
        isOnSale: false,
        originalPrice: '',
        discountPercentage: 0,
        brand: 'Test Brand',
      );

      blocTest<ProductDetailCubit, ProductDetailState>(
        'sets quantity to specified value',
        build: () {
          when(mockRepository.getById(any))
              .thenAnswer((_) async => testProduct);
          return cubit;
        },
        seed: () => ProductDetailLoaded(
          product: testProduct,
          selectedVolumeIndex: 0,
          quantity: 1,
        ),
        act: (cubit) => cubit.setQuantity(5),
        expect: () => [
          ProductDetailLoaded(
            product: testProduct,
            selectedVolumeIndex: 0,
            quantity: 5,
          ),
        ],
      );

      blocTest<ProductDetailCubit, ProductDetailState>(
        'clamps quantity to minimum 1',
        build: () {
          when(mockRepository.getById(any))
              .thenAnswer((_) async => testProduct);
          return cubit;
        },
        seed: () => ProductDetailLoaded(
          product: testProduct,
          selectedVolumeIndex: 0,
          quantity: 1,
        ),
        act: (cubit) => cubit.setQuantity(0),
        expect: () => [
          ProductDetailLoaded(
            product: testProduct,
            selectedVolumeIndex: 0,
            quantity: 1,
          ),
        ],
      );

      blocTest<ProductDetailCubit, ProductDetailState>(
        'clamps quantity to maximum 999',
        build: () {
          when(mockRepository.getById(any))
              .thenAnswer((_) async => testProduct);
          return cubit;
        },
        seed: () => ProductDetailLoaded(
          product: testProduct,
          selectedVolumeIndex: 0,
          quantity: 1,
        ),
        act: (cubit) => cubit.setQuantity(1000),
        expect: () => [
          ProductDetailLoaded(
            product: testProduct,
            selectedVolumeIndex: 0,
            quantity: 999,
          ),
        ],
      );
    });
  });

  group('ProductDetailLoaded pricing calculations', () {
    final testProduct = ProductEntity(
      id: 'test-id',
      name: 'Test Product',
      subtitle: 'Test Subtitle',
      price: '100,000 VNĐ',
      imageUrl: 'test-image.jpg',
      volumes: ['500 ML', '330 ML', '250 ML'],
      volumePrices: {
        '500 ML': 100000,
        '330 ML': 80000,
        '250 ML': 60000,
      },
      rating: 4.5,
      reviewCount: 100,
      description: 'Test description',
      category: 'test-category',
      origin: 'Test Origin',
      ingredients: ['ingredient1', 'ingredient2'],
      nutritionInfo: {'protein': '10g'},
      inStock: true,
      stockQuantity: 50,
      isFeatured: false,
      isOnSale: false,
      originalPrice: '',
      discountPercentage: 0,
      brand: 'Test Brand',
    );

    test('calculates correct selected volume', () {
      final state = ProductDetailLoaded(
        product: testProduct,
        selectedVolumeIndex: 1,
        quantity: 2,
      );

      expect(state.selectedVolume, equals('330 ML'));
    });

    test('calculates correct unit price for selected volume', () {
      final state = ProductDetailLoaded(
        product: testProduct,
        selectedVolumeIndex: 1,
        quantity: 2,
      );

      expect(state.unitPrice, equals(80000));
    });

    test('calculates correct total price', () {
      final state = ProductDetailLoaded(
        product: testProduct,
        selectedVolumeIndex: 1,
        quantity: 2,
      );

      expect(state.totalPrice, equals(160000));
    });

    test('formats total price correctly', () {
      final state = ProductDetailLoaded(
        product: testProduct,
        selectedVolumeIndex: 1,
        quantity: 2,
      );

      expect(state.formattedTotalPrice, equals('160,000'));
    });
  });
}
