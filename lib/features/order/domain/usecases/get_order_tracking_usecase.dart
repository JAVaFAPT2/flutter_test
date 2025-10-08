import '../entities/order_tracking.dart';
import '../repositories/order_repository.dart';

class GetOrderTrackingUseCase {
  GetOrderTrackingUseCase(this._repository);

  final OrderRepository _repository;

  Future<OrderTracking?> call(String orderId) {
    return _repository.getOrderTracking(orderId);
  }
}
