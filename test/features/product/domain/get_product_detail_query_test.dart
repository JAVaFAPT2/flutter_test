import 'package:flutter_test/flutter_test.dart';

import 'package:vietnamese_fish_sauce_app/core/fake/fake_firestore.dart';
import 'package:vietnamese_fish_sauce_app/features/product/data/repositories/product_repository_impl.dart'
    as feature_repo;
import 'package:vietnamese_fish_sauce_app/features/product/domain/usecases/get_product_detail_query.dart';

void main() {
  group('GetProductDetailQuery', () {
    test('returns product when exists', () async {
      final fake = FakeFirestore.instance;
      await fake.seedProducts([
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
      final usecase = GetProductDetailQuery(repo);

      final result = await usecase('p1');
      expect(result, isNotNull);
      expect(result!.id, 'p1');
      expect(result.name, 'Test');
    });

    test('returns null when not exists', () async {
      final fake = FakeFirestore.instance;
      final repo = feature_repo.ProductRepositoryImpl(fake);
      final usecase = GetProductDetailQuery(repo);

      final result = await usecase('unknown');
      expect(result, isNull);
    });
  });
}

