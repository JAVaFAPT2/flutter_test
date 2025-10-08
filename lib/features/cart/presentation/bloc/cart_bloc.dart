import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:vietnamese_fish_sauce_app/features/product/domain/entities/product_entity.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/domain/entities/cart.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/domain/entities/cart_item.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/domain/usecases/add_item_to_cart.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/domain/usecases/remove_item_from_cart.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/domain/usecases/update_item_quantity.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/domain/usecases/clear_cart.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/domain/usecases/toggle_cart_edit_mode.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/domain/usecases/toggle_item_selection.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/domain/usecases/toggle_select_all.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/domain/usecases/delete_selected_items.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/domain/usecases/get_cart.dart';

part 'cart_event.dart';
part 'cart_state.dart';

/// CartBloc - Thin orchestration layer
/// Delegates all business logic to use cases
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({
    required AddItemToCart addItemToCart,
    required RemoveItemFromCart removeItemFromCart,
    required UpdateItemQuantity updateItemQuantity,
    required ClearCart clearCart,
    required ToggleCartEditMode toggleCartEditMode,
    required ToggleItemSelection toggleItemSelection,
    required ToggleSelectAll toggleSelectAll,
    required DeleteSelectedItems deleteSelectedItems,
    required GetCart getCart,
  })  : _addItemToCart = addItemToCart,
        _removeItemFromCart = removeItemFromCart,
        _updateItemQuantity = updateItemQuantity,
        _clearCart = clearCart,
        _toggleCartEditMode = toggleCartEditMode,
        _toggleItemSelection = toggleItemSelection,
        _toggleSelectAll = toggleSelectAll,
        _deleteSelectedItems = deleteSelectedItems,
        _getCart = getCart,
        super(const CartState()) {
    on<CartLoadRequested>(_onLoadRequested);
    on<CartItemAdded>(_onItemAdded);
    on<CartItemRemoved>(_onItemRemoved);
    on<CartItemQuantityUpdated>(_onItemQuantityUpdated);
    on<CartCleared>(_onCleared);
    on<CartEditModeToggled>(_onEditModeToggled);
    on<CartItemSelectionToggled>(_onItemSelectionToggled);
    on<CartSelectAllToggled>(_onSelectAllToggled);
    on<CartDeleteSelectedRequested>(_onDeleteSelectedRequested);
  }

  final AddItemToCart _addItemToCart;
  final RemoveItemFromCart _removeItemFromCart;
  final UpdateItemQuantity _updateItemQuantity;
  final ClearCart _clearCart;
  final ToggleCartEditMode _toggleCartEditMode;
  final ToggleItemSelection _toggleItemSelection;
  final ToggleSelectAll _toggleSelectAll;
  final DeleteSelectedItems _deleteSelectedItems;
  final GetCart _getCart;

  Future<void> _onLoadRequested(
    CartLoadRequested event,
    Emitter<CartState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final cart = await _getCart();
      emit(CartState(cart: cart, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load cart: ${e.toString()}',
      ));
    }
  }

  Future<void> _onItemAdded(
    CartItemAdded event,
    Emitter<CartState> emit,
  ) async {
    try {
      final updatedCart = await _addItemToCart(
        AddItemToCartParams(
          product: event.product,
          quantity: event.quantity,
          volume: event.volume,
          unitPrice: event.unitPrice,
        ),
      );
      emit(state.copyWith(cart: updatedCart));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Failed to add item: ${e.toString()}',
      ));
    }
  }

  Future<void> _onItemRemoved(
    CartItemRemoved event,
    Emitter<CartState> emit,
  ) async {
    try {
      final updatedCart = await _removeItemFromCart(
        RemoveItemFromCartParams(
          productId: event.productId,
          volume: event.volume,
        ),
      );
      emit(state.copyWith(cart: updatedCart));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Failed to remove item: ${e.toString()}',
      ));
    }
  }

  Future<void> _onItemQuantityUpdated(
    CartItemQuantityUpdated event,
    Emitter<CartState> emit,
  ) async {
    try {
      if (event.quantity <= 0) {
        // Remove item if quantity is 0 or less
        add(CartItemRemoved(
          productId: event.productId,
          volume: event.volume,
        ));
        return;
      }

      final updatedCart = await _updateItemQuantity(
        UpdateItemQuantityParams(
          productId: event.productId,
          newQuantity: event.quantity,
          volume: event.volume,
        ),
      );
      emit(state.copyWith(cart: updatedCart));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Failed to update quantity: ${e.toString()}',
      ));
    }
  }

  Future<void> _onCleared(
    CartCleared event,
    Emitter<CartState> emit,
  ) async {
    try {
      final emptyCart = await _clearCart();
      emit(CartState(cart: emptyCart));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Failed to clear cart: ${e.toString()}',
      ));
    }
  }

  Future<void> _onEditModeToggled(
    CartEditModeToggled event,
    Emitter<CartState> emit,
  ) async {
    try {
      final updatedCart = await _toggleCartEditMode(event.isEditing);
      emit(state.copyWith(cart: updatedCart));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Failed to toggle edit mode: ${e.toString()}',
      ));
    }
  }

  Future<void> _onItemSelectionToggled(
    CartItemSelectionToggled event,
    Emitter<CartState> emit,
  ) async {
    try {
      final updatedCart = await _toggleItemSelection(
        ToggleItemSelectionParams(
          productId: event.productId,
          isSelected: event.isSelected,
          volume: event.volume,
        ),
      );
      emit(state.copyWith(cart: updatedCart));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Failed to toggle selection: ${e.toString()}',
      ));
    }
  }

  Future<void> _onSelectAllToggled(
    CartSelectAllToggled event,
    Emitter<CartState> emit,
  ) async {
    try {
      final updatedCart = await _toggleSelectAll(event.isSelected);
      emit(state.copyWith(cart: updatedCart));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Failed to toggle select all: ${e.toString()}',
      ));
    }
  }

  Future<void> _onDeleteSelectedRequested(
    CartDeleteSelectedRequested event,
    Emitter<CartState> emit,
  ) async {
    try {
      final updatedCart = await _deleteSelectedItems();
      emit(state.copyWith(cart: updatedCart));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Failed to delete items: ${e.toString()}',
      ));
    }
  }
}
