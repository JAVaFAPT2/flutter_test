import '../entities/banner.dart';
import '../repositories/home_repository.dart';

/// Use case for getting home banners
class GetBanners {
  const GetBanners(this._repository);

  final HomeRepository _repository;

  Future<List<Banner>> call() async {
    final banners = await _repository.getBanners();

    // Business logic: Sort by order
    banners.sort((a, b) => a.order.compareTo(b.order));

    return banners;
  }
}

