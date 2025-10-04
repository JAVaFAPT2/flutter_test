import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vietnamese_fish_sauce_app/core/fake/fake_firestore.dart';
import 'package:vietnamese_fish_sauce_app/features/product/application/bloc/product_list_bloc.dart';
import 'package:vietnamese_fish_sauce_app/features/product/data/repositories/product_repository_impl.dart'
    as feature_repo;
import 'package:vietnamese_fish_sauce_app/features/product/domain/usecases/get_products_query.dart';

void main() {
  group('ProductListBloc', () {
    blocTest<ProductListBloc, ProductListState>(
      'loads page 1 then page 2 on load more',
      build: () {
        final fake = FakeFirestore.instance;
        fake.seedProducts(List.generate(
            3,
            (i) => {
                  'id': 'p${i + 1}',
                  'name': 'P${i + 1}',
                  'price': '${(i + 1) * 1000}',
                  'imageUrl': 'assets/figma_exports/product_xtm_500ml.png',
                  'volumes': ['500 ML'],
                  'volumePrices': {'500 ML': (i + 1) * 1000},
                }));
        final repo = feature_repo.ProductRepositoryImpl(fake);
        final getProducts = GetProductsQuery(repo);
        return ProductListBloc(getProducts: getProducts);
      },
      act: (bloc) async {
        bloc.add(const ProductListLoadRequested(page: 1, limit: 2));
        await Future<void>.delayed(const Duration(milliseconds: 10));
        bloc.add(const ProductListLoadMoreRequested(limit: 2));
      },
      expect: () => [
        isA<ProductListState>().having((s) => s.isLoading, 'loading', true),
        isA<ProductListState>()
            .having((s) => s.products.length, 'len', 2)
            .having((s) => s.currentPage, 'page', 1)
            .having((s) => s.isLoading, 'loading', false),
        isA<ProductListState>().having((s) => s.isLoading, 'loading', true),
        isA<ProductListState>()
            .having((s) => s.products.length, 'len', 3)
            .having((s) => s.currentPage, 'page', 2)
            .having((s) => s.isLoading, 'loading', false),
      ],
    );
  });
}

