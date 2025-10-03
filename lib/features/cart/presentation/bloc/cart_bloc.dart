import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:vietnamese_fish_sauce_app/src/domain/entities/product.dart'
    as domain;

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
    final variantKey = event.volume != null
        ? '${event.product.id}_${event.volume}'
        : event.product.id;

    final index = state.items.indexWhere((i) => i.variantKey == variantKey);

    if (index >= 0) {
      final updated = List<CartItem>.from(state.items);
      updated[index] = updated[index].copyWith(
        quantity: updated[index].quantity + event.quantity,
      );
      emit(state.copyWith(items: updated));
    } else {
      emit(state.copyWith(items: [
        ...state.items,
        CartItem(
          product: event.product,
          quantity: event.quantity,
          volume: event.volume,
          unitPrice: event.unitPrice,
          addedAt: DateTime.now(),
        ),
      ]));
    }
  }

  void _onItemRemoved(CartItemRemoved event, Emitter<CartState> emit) {
    final variantKey = event.volume != null
        ? '${event.productId}_${event.volume}'
        : event.productId;

    emit(state.copyWith(
      items: state.items.where((i) => i.variantKey != variantKey).toList(),
    ));
  }

  void _onItemQuantityUpdated(
    CartItemQuantityUpdated event,
    Emitter<CartState> emit,
  ) {
    if (event.quantity <= 0) {
      add(CartItemRemoved(
        productId: event.productId,
        volume: event.volume,
      ));
      return;
    }

    final variantKey = event.volume != null
        ? '${event.productId}_${event.volume}'
        : event.productId;

    final updated = state.items.map((i) {
      if (i.variantKey == variantKey) {
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
