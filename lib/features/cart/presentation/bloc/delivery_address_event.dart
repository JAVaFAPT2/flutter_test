part of 'delivery_address_bloc.dart';

abstract class DeliveryAddressEvent extends Equatable {
  const DeliveryAddressEvent();

  @override
  List<Object?> get props => [];
}

class LoadCurrentLocation extends DeliveryAddressEvent {
  const LoadCurrentLocation();
}

class UpdateLocation extends DeliveryAddressEvent {
  const UpdateLocation(this.newAddress);

  final String newAddress;

  @override
  List<Object?> get props => [newAddress];
}

class SelectLocationOnMap extends DeliveryAddressEvent {
  const SelectLocationOnMap();
}
