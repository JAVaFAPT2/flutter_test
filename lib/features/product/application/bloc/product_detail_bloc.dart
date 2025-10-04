import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/get_product_detail_query.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc({required GetProductDetailQuery getDetail})
      : _getDetail = getDetail,
        super(const ProductDetailState()) {
    on<ProductDetailLoadRequested>(_onLoadRequested);
    on<ProductDetailVolumeChanged>(_onVolumeChanged);
    on<ProductDetailQuantityIncremented>(_onQuantityInc);
    on<ProductDetailQuantityDecremented>(_onQuantityDec);
    on<ProductDetailQuantitySet>(_onQuantitySet);
  }

  final GetProductDetailQuery _getDetail;

  Future<void> _onLoadRequested(
    ProductDetailLoadRequested event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final product = await _getDetail(event.productId);
      if (product == null) {
        emit(state.copyWith(
            isLoading: false, errorMessage: 'Product not found'));
        return;
      }
      emit(state.copyWith(
        isLoading: false,
        product: product,
        selectedVolumeIndex: 0,
        quantity: 1,
      ));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Failed to load product'));
    }
  }

  void _onVolumeChanged(
    ProductDetailVolumeChanged event,
    Emitter<ProductDetailState> emit,
  ) {
    if (state.product == null) {
      return;
    }
    if (event.volumeIndex < 0 ||
        event.volumeIndex >= state.product!.volumes.length) {
      return;
    }
    emit(state.copyWith(selectedVolumeIndex: event.volumeIndex));
  }

  void _onQuantityInc(
    ProductDetailQuantityIncremented event,
    Emitter<ProductDetailState> emit,
  ) {
    emit(state.copyWith(quantity: state.quantity + 1));
  }

  void _onQuantityDec(
    ProductDetailQuantityDecremented event,
    Emitter<ProductDetailState> emit,
  ) {
    final next = state.quantity - 1;
    emit(state.copyWith(quantity: next < 1 ? 1 : next));
  }

  void _onQuantitySet(
    ProductDetailQuantitySet event,
    Emitter<ProductDetailState> emit,
  ) {
    final clamped = event.quantity.clamp(1, 999);
    emit(state.copyWith(quantity: clamped));
  }
}
