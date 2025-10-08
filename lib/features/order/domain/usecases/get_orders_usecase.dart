import 'package:vietnamese_fish_sauce_app/features/order/domain/entities/order.dart'
    as domain;
import 'package:vietnamese_fish_sauce_app/features/order/domain/repositories/order_repository.dart';

class GetOrdersUseCase {
  GetOrdersUseCase(this._repo);
  final OrderRepository _repo;

  Future<List<domain.Order>> call({String? userId, String? status}) {
    return _repo.getOrders(userId: userId, status: status);
  }
}
