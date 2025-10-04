import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductsQuery {
  const GetProductsQuery(this._repo);
  final ProductRepository _repo;

  Future<List<ProductEntity>> call({
    String? category,
    String? brand,
    String? search,
    String? sortBy,
    int page = 1,
    int limit = 20,
  }) async {
    // Basic pagination support via offset/limit when using FakeFirestore
    final offset = (page - 1) * limit;
    var items = await _repo.list(
        category: category, brand: brand, limit: limit, offset: offset);

    // Client-side sort for now (Fake source); server-side later
    if (sortBy != null) {
      switch (sortBy) {
        case 'name':
          items.sort((a, b) => a.name.compareTo(b.name));
          break;
        case 'rating':
          items.sort((a, b) => b.rating.compareTo(a.rating));
          break;
        case 'price_asc':
          items.sort((a, b) {
            final ap = a
                .getPriceForVolume(a.volumes.isNotEmpty ? a.volumes.first : '');
            final bp = b
                .getPriceForVolume(b.volumes.isNotEmpty ? b.volumes.first : '');
            return ap.compareTo(bp);
          });
          break;
        case 'price_desc':
          items.sort((a, b) {
            final ap = a
                .getPriceForVolume(a.volumes.isNotEmpty ? a.volumes.first : '');
            final bp = b
                .getPriceForVolume(b.volumes.isNotEmpty ? b.volumes.first : '');
            return bp.compareTo(ap);
          });
          break;
      }
    }

    // Basic search filter
    if (search != null && search.isNotEmpty) {
      final q = search.toLowerCase();
      items = items
          .where((p) =>
              p.name.toLowerCase().contains(q) ||
              p.description.toLowerCase().contains(q) ||
              p.brand.toLowerCase().contains(q))
          .toList();
    }

    return items;
  }
}
