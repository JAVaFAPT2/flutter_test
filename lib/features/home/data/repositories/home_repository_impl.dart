import 'package:vietnamese_fish_sauce_app/features/product/domain/entities/product_entity.dart';
import 'package:vietnamese_fish_sauce_app/features/home/domain/entities/banner.dart';
import 'package:vietnamese_fish_sauce_app/features/home/domain/entities/category.dart';
import 'package:vietnamese_fish_sauce_app/features/home/domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasource.dart';

/// Implementation of home repository
class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this._remoteDataSource);

  final HomeRemoteDataSource _remoteDataSource;

  @override
  Future<List<Banner>> getBanners() async {
    final bannerModels = await _remoteDataSource.getBanners();
    return bannerModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<Category>> getCategories() async {
    final categoryModels = await _remoteDataSource.getCategories();
    return categoryModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<ProductEntity>> getFeaturedProducts({int limit = 10}) async {
    return await _remoteDataSource.getFeaturedProducts(limit: limit);
  }

  @override
  Future<List<ProductEntity>> getSaleProducts({int limit = 10}) async {
    return await _remoteDataSource.getSaleProducts(limit: limit);
  }
}

