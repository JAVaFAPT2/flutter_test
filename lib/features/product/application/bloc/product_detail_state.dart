part of 'product_detail_bloc.dart';

class ProductDetailState extends Equatable {
  const ProductDetailState({
    this.isLoading = false,
    this.product,
    this.selectedVolumeIndex = 0,
    this.quantity = 1,
    this.errorMessage,
  });

  final bool isLoading;
  final ProductEntity? product;
  final int selectedVolumeIndex;
  final int quantity;
  final String? errorMessage;

  String get selectedVolume => product == null || product!.volumes.isEmpty
      ? ''
      : product!.volumes[selectedVolumeIndex];

  int get unitPrice =>
      product == null ? 0 : product!.getPriceForVolume(selectedVolume);

  int get totalPrice =>
      product == null ? 0 : product!.getTotalPrice(selectedVolume, quantity);

  ProductDetailState copyWith({
    bool? isLoading,
    ProductEntity? product,
    int? selectedVolumeIndex,
    int? quantity,
    String? errorMessage,
  }) {
    return ProductDetailState(
      isLoading: isLoading ?? this.isLoading,
      product: product ?? this.product,
      selectedVolumeIndex: selectedVolumeIndex ?? this.selectedVolumeIndex,
      quantity: quantity ?? this.quantity,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        product,
        selectedVolumeIndex,
        quantity,
        errorMessage,
      ];
}

