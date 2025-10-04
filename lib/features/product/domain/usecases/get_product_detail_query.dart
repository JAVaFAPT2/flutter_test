import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

/// Query use case to load a product by id
class GetProductDetailQuery {
  const GetProductDetailQuery(this._repo);
  final ProductRepository _repo;

  Future<ProductEntity?> call(String id) => _repo.getById(id);
}

