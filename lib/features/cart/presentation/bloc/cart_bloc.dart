import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../src/domain/entities/product.dart' as domain;

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<CartItemAdded>(_onItemAdded);
    on<CartItemRemoved>(_onItemRemoved);
    on<CartItemQuantityUpdated>(_onItemQuantityUpdated);
    on<CartCleared>(_onCleared);
  }

  void _onItemAdded(CartItemAdded event, Emitter<CartState> emit) {
    final index = state.items.indexWhere((i) => i.product.id == event.product.id);
    if (index >= 0) {
      final updated = List<CartItem>.from(state.items);
      updated[index] = updated[index].copyWith(
        quantity: updated[index].quantity + event.quantity,
      );
      emit(state.copyWith(items: updated));
    } else {
      emit(state.copyWith(items: [
        ...state.items,
        CartItem(product: event.product, quantity: event.quantity),
      ]));
    }
  }

  void _onItemRemoved(CartItemRemoved event, Emitter<CartState> emit) {
    emit(state.copyWith(
      items: state.items.where((i) => i.product.id != event.productId).toList(),
    ));
  }

  void _onItemQuantityUpdated(
    CartItemQuantityUpdated event,
    Emitter<CartState> emit,
  ) {
    if (event.quantity <= 0) {
      add(CartItemRemoved(productId: event.productId));
      return;
    }
    final updated = state.items.map((i) {
      if (i.product.id == event.productId) {
        return i.copyWith(quantity: event.quantity);
      }
      return i;
    }).toList();
    emit(state.copyWith(items: updated));
  }

  void _onCleared(CartCleared event, Emitter<CartState> emit) {
    emit(const CartState());
  }
}

