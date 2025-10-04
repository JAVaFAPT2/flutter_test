import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vietnamese_fish_sauce_app/core/fake/fake_firestore.dart';
import 'package:vietnamese_fish_sauce_app/features/product/application/bloc/product_detail_bloc.dart';
import 'package:vietnamese_fish_sauce_app/features/product/data/repositories/product_repository_impl.dart'
    as feature_repo;
import 'package:vietnamese_fish_sauce_app/features/product/domain/usecases/get_product_detail_query.dart';

void main() {
  group('ProductDetailBloc', () {
    blocTest<ProductDetailBloc, ProductDetailState>(
      'emits loading then loaded for existing product',
      build: () {
        final fake = FakeFirestore.instance;
        fake.seedProducts([
          {
            'id': 'p1',
            'name': 'Test',
            'price': '100000',
            'imageUrl': 'assets/figma_exports/product_xtm_500ml.png',
            'volumes': ['500 ML'],
            'volumePrices': {'500 ML': 100000},
          }
        ]);
        final repo = feature_repo.ProductRepositoryImpl(fake);
        final getDetail = GetProductDetailQuery(repo);
        return ProductDetailBloc(getDetail: getDetail);
      },
      act: (bloc) => bloc.add(const ProductDetailLoadRequested('p1')),
      expect: () => [
        isA<ProductDetailState>().having((s) => s.isLoading, 'loading', true),
        isA<ProductDetailState>()
            .having((s) => s.isLoading, 'loading', false)
            .having((s) => s.product?.id, 'id', 'p1'),
      ],
    );

    blocTest<ProductDetailBloc, ProductDetailState>(
      'emits error for missing product',
      build: () {
        final fake = FakeFirestore.instance;
        final repo = feature_repo.ProductRepositoryImpl(fake);
        final getDetail = GetProductDetailQuery(repo);
        return ProductDetailBloc(getDetail: getDetail);
      },
      act: (bloc) => bloc.add(const ProductDetailLoadRequested('missing')),
      expect: () => [
        isA<ProductDetailState>().having((s) => s.isLoading, 'loading', true),
        isA<ProductDetailState>()
            .having((s) => s.errorMessage != null, 'error', true),
      ],
    );
  });
}

