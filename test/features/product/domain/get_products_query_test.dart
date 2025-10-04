import 'package:flutter_test/flutter_test.dart';

import 'package:vietnamese_fish_sauce_app/core/fake/fake_firestore.dart';
import 'package:vietnamese_fish_sauce_app/features/product/data/repositories/product_repository_impl.dart'
    as feature_repo;
import 'package:vietnamese_fish_sauce_app/features/product/domain/usecases/get_products_query.dart';

void main() {
  group('GetProductsQuery', () {
    test('returns paginated items and supports sorting', () async {
      final fake = FakeFirestore.instance;
      await fake.seedProducts([
        {
          'id': 'p1',
          'name': 'A',
          'price': '100000',
          'imageUrl': 'assets/figma_exports/product_xtm_500ml.png',
          'volumes': ['500 ML'],
          'volumePrices': {'500 ML': 100000},
        },
        {
          'id': 'p2',
          'name': 'B',
          'price': '200000',
          'imageUrl': 'assets/figma_exports/product_xtm_500ml.png',
          'volumes': ['500 ML'],
          'volumePrices': {'500 ML': 200000},
        }
      ]);

      final repo = feature_repo.ProductRepositoryImpl(fake);
      final usecase = GetProductsQuery(repo);

      final page1 = await usecase(page: 1, limit: 1, sortBy: 'price_desc');
      expect(page1.length, 1);
      expect(page1.first.id, 'p2');

      final page2 = await usecase(page: 2, limit: 1, sortBy: 'price_desc');
      expect(page2.length, 1);
      expect(page2.first.id, 'p1');
    });
  });
}

