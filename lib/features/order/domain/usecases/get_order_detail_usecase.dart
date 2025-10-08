import 'package:vietnamese_fish_sauce_app/features/order/domain/entities/order.dart'
    as domain;
import 'package:vietnamese_fish_sauce_app/features/order/domain/repositories/order_repository.dart';

class GetOrderDetailUseCase {
  GetOrderDetailUseCase(this._repo);
  final OrderRepository _repo;

  Future<domain.Order?> call(String id) {
    return _repo.getOrderDetail(id);
  }
}
