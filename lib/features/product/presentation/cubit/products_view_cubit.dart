import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class ProductsViewState extends Equatable {
  const ProductsViewState({this.isGridView = true});
  final bool isGridView;

  ProductsViewState copyWith({bool? isGridView}) {
    return ProductsViewState(isGridView: isGridView ?? this.isGridView);
  }

  @override
  List<Object?> get props => [isGridView];
}

class ProductsViewCubit extends Cubit<ProductsViewState> {
  ProductsViewCubit() : super(const ProductsViewState());

  void toggleView() => emit(state.copyWith(isGridView: !state.isGridView));
}

