part of 'delivery_address_bloc.dart';

class DeliveryAddressState extends Equatable {
  const DeliveryAddressState({
    this.currentAddress = '',
    this.isLoading = false,
    this.lastUpdated,
  });

  final String currentAddress;
  final bool isLoading;
  final DateTime? lastUpdated;

  DeliveryAddressState copyWith({
    String? currentAddress,
    bool? isLoading,
    DateTime? lastUpdated,
  }) {
    return DeliveryAddressState(
      currentAddress: currentAddress ?? this.currentAddress,
      isLoading: isLoading ?? this.isLoading,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  List<Object?> get props => [currentAddress, isLoading, lastUpdated];
}
