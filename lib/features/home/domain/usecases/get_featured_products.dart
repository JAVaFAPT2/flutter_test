import 'package:vietnamese_fish_sauce_app/features/product/domain/entities/product_entity.dart';
import '../repositories/home_repository.dart';

/// Use case for getting featured products
class GetFeaturedProducts {
  const GetFeaturedProducts(this._repository);

  final HomeRepository _repository;

  Future<List<ProductEntity>> call({int limit = 10}) async {
    return await _repository.getFeaturedProducts(limit: limit);
  }
}

