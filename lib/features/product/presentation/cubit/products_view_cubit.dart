import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class ProductsViewState extends Equatable {
  const ProductsViewState({
    this.isGridView = true,
    this.selectedCategory,
    this.selectedBrand,
  });

  final bool isGridView;
  final String? selectedCategory;
  final String? selectedBrand;

  ProductsViewState copyWith({
    bool? isGridView,
    String? selectedCategory,
    String? selectedBrand,
  }) {
    return ProductsViewState(
      isGridView: isGridView ?? this.isGridView,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedBrand: selectedBrand ?? this.selectedBrand,
    );
  }

  @override
  List<Object?> get props => [isGridView, selectedCategory, selectedBrand];
}

class ProductsViewCubit extends Cubit<ProductsViewState> {
  ProductsViewCubit() : super(const ProductsViewState());

  void toggleView() => emit(state.copyWith(isGridView: !state.isGridView));

  void updateCategoryFilter(String? category) =>
      emit(state.copyWith(selectedCategory: category));

  void updateBrandFilter(String? brand) =>
      emit(state.copyWith(selectedBrand: brand));
}
