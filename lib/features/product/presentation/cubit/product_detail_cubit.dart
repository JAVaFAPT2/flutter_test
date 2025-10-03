import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';

/// Events for ProductDetailCubit
abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object?> get props => [];
}

class ProductDetailLoadRequested extends ProductDetailEvent {
  const ProductDetailLoadRequested(this.productId);

  final String productId;

  @override
  List<Object?> get props => [productId];
}

class ProductDetailVolumeChanged extends ProductDetailEvent {
  const ProductDetailVolumeChanged(this.volumeIndex);

  final int volumeIndex;

  @override
  List<Object?> get props => [volumeIndex];
}

class ProductDetailQuantityIncremented extends ProductDetailEvent {
  const ProductDetailQuantityIncremented();
}

class ProductDetailQuantityDecremented extends ProductDetailEvent {
  const ProductDetailQuantityDecremented();
}

class ProductDetailQuantitySet extends ProductDetailEvent {
  const ProductDetailQuantitySet(this.quantity);

  final int quantity;

  @override
  List<Object?> get props => [quantity];
}

/// States for ProductDetailCubit
abstract class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object?> get props => [];
}

class ProductDetailInitial extends ProductDetailState {
  const ProductDetailInitial();
}

class ProductDetailLoading extends ProductDetailState {
  const ProductDetailLoading();
}

class ProductDetailLoaded extends ProductDetailState {
  const ProductDetailLoaded({
    required this.product,
    required this.selectedVolumeIndex,
    required this.quantity,
  });

  final ProductEntity product;
  final int selectedVolumeIndex;
  final int quantity;

  String get selectedVolume =>
      product.volumes.isNotEmpty ? product.volumes[selectedVolumeIndex] : '';

  int get unitPrice => product.getPriceForVolume(selectedVolume);

  int get totalPrice => product.getTotalPrice(selectedVolume, quantity);

  String get formattedTotalPrice =>
      product.getFormattedTotalPrice(selectedVolume, quantity);

  @override
  List<Object?> get props => [product, selectedVolumeIndex, quantity];
}

class ProductDetailError extends ProductDetailState {
  const ProductDetailError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

/// Cubit for managing product detail state
class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit(this._repository) : super(const ProductDetailInitial());

  final ProductRepository _repository;

  Future<void> loadProduct(String productId) async {
    emit(const ProductDetailLoading());

    try {
      final product = await _repository.getById(productId);
      if (product == null) {
        emit(const ProductDetailError('Product not found'));
        return;
      }

      emit(ProductDetailLoaded(
        product: product,
        selectedVolumeIndex: 0,
        quantity: 1,
      ));
    } catch (e) {
      emit(ProductDetailError('Failed to load product: $e'));
    }
  }

  void changeVolume(int volumeIndex) {
    final currentState = state;
    if (currentState is ProductDetailLoaded) {
      if (volumeIndex >= 0 &&
          volumeIndex < currentState.product.volumes.length) {
        emit(currentState.copyWith(selectedVolumeIndex: volumeIndex));
      }
    }
  }

  void incrementQuantity() {
    final currentState = state;
    if (currentState is ProductDetailLoaded) {
      final newQuantity = currentState.quantity + 1;
      emit(currentState.copyWith(quantity: newQuantity));
    }
  }

  void decrementQuantity() {
    final currentState = state;
    if (currentState is ProductDetailLoaded) {
      final newQuantity = (currentState.quantity - 1).clamp(1, 999);
      emit(currentState.copyWith(quantity: newQuantity));
    }
  }

  void setQuantity(int quantity) {
    final currentState = state;
    if (currentState is ProductDetailLoaded) {
      final clampedQuantity = quantity.clamp(1, 999);
      emit(currentState.copyWith(quantity: clampedQuantity));
    }
  }
}

/// Extension to add copyWith method to ProductDetailLoaded
extension ProductDetailLoadedCopyWith on ProductDetailLoaded {
  ProductDetailLoaded copyWith({
    ProductEntity? product,
    int? selectedVolumeIndex,
    int? quantity,
  }) {
    return ProductDetailLoaded(
      product: product ?? this.product,
      selectedVolumeIndex: selectedVolumeIndex ?? this.selectedVolumeIndex,
      quantity: quantity ?? this.quantity,
    );
  }
}
