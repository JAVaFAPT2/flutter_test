import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_order_tracking_usecase.dart';
import 'order_tracking_event.dart';
import 'order_tracking_state.dart';

class OrderTrackingBloc extends Bloc<OrderTrackingEvent, OrderTrackingState> {
  OrderTrackingBloc({required GetOrderTrackingUseCase getOrderTracking})
      : _getOrderTracking = getOrderTracking,
        super(const OrderTrackingState()) {
    on<LoadOrderTracking>(_onLoadOrderTracking);
  }

  final GetOrderTrackingUseCase _getOrderTracking;

  Future<void> _onLoadOrderTracking(
    LoadOrderTracking event,
    Emitter<OrderTrackingState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final tracking = await _getOrderTracking(event.orderId);
      if (tracking != null) {
        emit(state.copyWith(
          isLoading: false,
          orderTracking: tracking,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Order tracking not found',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }
}
