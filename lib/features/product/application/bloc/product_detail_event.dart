part of 'product_detail_bloc.dart';

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

