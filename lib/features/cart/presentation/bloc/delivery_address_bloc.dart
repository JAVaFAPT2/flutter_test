import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'delivery_address_event.dart';
part 'delivery_address_state.dart';

class DeliveryAddressBloc
    extends Bloc<DeliveryAddressEvent, DeliveryAddressState> {
  DeliveryAddressBloc() : super(const DeliveryAddressState()) {
    on<LoadCurrentLocation>(_onLoadCurrentLocation);
    on<UpdateLocation>(_onUpdateLocation);
    on<SelectLocationOnMap>(_onSelectLocationOnMap);
  }

  void _onLoadCurrentLocation(
    LoadCurrentLocation event,
    Emitter<DeliveryAddressState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    // Simulate loading current location
    await Future.delayed(const Duration(seconds: 1));

    emit(state.copyWith(
      isLoading: false,
      currentAddress: '123 Đường Nguyễn Huệ, Quận 1, TP.HCM',
    ));
  }

  void _onUpdateLocation(
    UpdateLocation event,
    Emitter<DeliveryAddressState> emit,
  ) {
    emit(state.copyWith(
      currentAddress: event.newAddress,
      lastUpdated: DateTime.now(),
    ));
  }

  void _onSelectLocationOnMap(
    SelectLocationOnMap event,
    Emitter<DeliveryAddressState> emit,
  ) {
    // Simulate address change when tapping on map
    const newAddress = '456 Đường Lê Lợi, Quận 3, TP.HCM';

    emit(state.copyWith(
      currentAddress: newAddress,
      lastUpdated: DateTime.now(),
    ));
  }
}
