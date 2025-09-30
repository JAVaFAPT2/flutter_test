import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class ProductDetailState extends Equatable {
  const ProductDetailState({
    this.selectedImageIndex = 0,
    this.quantity = 1,
    this.isFavorite = false,
  });

  final int selectedImageIndex;
  final int quantity;
  final bool isFavorite;

  ProductDetailState copyWith({int? selectedImageIndex, int? quantity, bool? isFavorite}) {
    return ProductDetailState(
      selectedImageIndex: selectedImageIndex ?? this.selectedImageIndex,
      quantity: quantity ?? this.quantity,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [selectedImageIndex, quantity, isFavorite];
}

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit() : super(const ProductDetailState());

  void selectImage(int index) => emit(state.copyWith(selectedImageIndex: index));
  void toggleFavorite() => emit(state.copyWith(isFavorite: !state.isFavorite));
  void incrementQuantity(int max) {
    if (state.quantity < max) emit(state.copyWith(quantity: state.quantity + 1));
  }
  void decrementQuantity() {
    if (state.quantity > 1) emit(state.copyWith(quantity: state.quantity - 1));
  }
}

