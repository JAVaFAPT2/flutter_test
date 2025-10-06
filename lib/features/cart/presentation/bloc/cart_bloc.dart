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
    on<CartEditModeToggled>(_onEditModeToggled);
    on<CartItemSelectionToggled>(_onItemSelectionToggled);
    on<CartSelectAllToggled>(_onSelectAllToggled);
    on<CartDeleteSelectedRequested>(_onDeleteSelectedRequested);
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
      final newItems = [
        ...state.items,
        CartItem(
          product: event.product,
          quantity: event.quantity,
          volume: event.volume,
          unitPrice: event.unitPrice,
          addedAt: DateTime.now(),
        ),
      ];
      emit(state.copyWith(items: newItems));
    }
  }

  void _onItemRemoved(CartItemRemoved event, Emitter<CartState> emit) {
    final variantKey = event.volume != null
        ? '${event.productId}_${event.volume}'
        : event.productId;

    // Remove from selection if present
    final updatedSelection = Set<String>.from(state.selectedVariantKeys);
    updatedSelection.remove(variantKey);

    emit(state.copyWith(
      items: state.items.where((i) => i.variantKey != variantKey).toList(),
      selectedVariantKeys: updatedSelection,
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

  void _onEditModeToggled(CartEditModeToggled event, Emitter<CartState> emit) {
    emit(state.copyWith(isEditing: event.isEditing));
  }

  void _onItemSelectionToggled(
      CartItemSelectionToggled event, Emitter<CartState> emit) {
    final variantKey = event.volume != null
        ? '${event.productId}_${event.volume}'
        : event.productId;

    final updatedSelection = Set<String>.from(state.selectedVariantKeys);
    if (event.isSelected) {
      updatedSelection.add(variantKey);
    } else {
      updatedSelection.remove(variantKey);
    }

    emit(state.copyWith(selectedVariantKeys: updatedSelection));
  }

  void _onSelectAllToggled(
      CartSelectAllToggled event, Emitter<CartState> emit) {
    final allVariantKeys = state.items.map((i) => i.variantKey).toSet();
    emit(state.copyWith(
      selectedVariantKeys: event.isSelected ? allVariantKeys : <String>{},
    ));
  }

  void _onDeleteSelectedRequested(
      CartDeleteSelectedRequested event, Emitter<CartState> emit) {
    final remainingItems = state.items
        .where((i) => !state.selectedVariantKeys.contains(i.variantKey))
        .toList();

    emit(state.copyWith(
      items: remainingItems,
      selectedVariantKeys: <String>{},
    ));
  }
}
