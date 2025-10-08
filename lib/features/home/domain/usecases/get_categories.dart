import '../entities/category.dart';
import '../repositories/home_repository.dart';

/// Use case for getting categories
class GetCategories {
  const GetCategories(this._repository);

  final HomeRepository _repository;

  Future<List<Category>> call() async {
    final categories = await _repository.getCategories();

    // Business logic: Sort by order
    categories.sort((a, b) => a.order.compareTo(b.order));

    return categories;
  }
}

