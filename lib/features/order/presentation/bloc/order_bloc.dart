import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vietnamese_fish_sauce_app/features/order/domain/usecases/get_orders_usecase.dart';
import 'order_event.dart';
import 'order_state.dart';

/// Minimal OrderBloc for Step 1: handles load and filter changes
class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({required GetOrdersUseCase getOrders})
      : _getOrders = getOrders,
        super(const OrderState()) {
    on<OrderLoadRequested>(_onLoadRequested);
    on<OrderFilterChanged>(_onFilterChanged);
    on<OrderSearchQueryChanged>(_onSearchQueryChanged);
  }

  final GetOrdersUseCase _getOrders;

  Future<void> _onLoadRequested(
      OrderLoadRequested event, Emitter<OrderState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final orders = await _getOrders();
      emit(state.copyWith(isLoading: false, orders: orders));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _onFilterChanged(
      OrderFilterChanged event, Emitter<OrderState> emit) async {
    emit(state.copyWith(isLoading: true, activeStatus: event.status));
    try {
      final orders = await _getOrders(status: event.status);
      emit(state.copyWith(isLoading: false, orders: orders));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  void _onSearchQueryChanged(
      OrderSearchQueryChanged event, Emitter<OrderState> emit) {
    emit(state.copyWith(searchQuery: event.query));
  }
}
