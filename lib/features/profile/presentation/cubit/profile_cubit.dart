import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit for managing profile page UI state
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());

  void toggleEditMode() {
    emit(state.copyWith(isEditing: !state.isEditing));
  }

  void startLoading() {
    emit(state.copyWith(isLoading: true));
  }

  void stopLoading() {
    emit(state.copyWith(isLoading: false));
  }

  void updateName(String name) {
    emit(state.copyWith(name: name));
  }

  void updateEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void updatePhone(String phone) {
    emit(state.copyWith(phone: phone));
  }

  void updateAddress(String address) {
    emit(state.copyWith(address: address));
  }
}

/// State for profile page UI
class ProfileState {
  const ProfileState({
    this.isEditing = false,
    this.isLoading = false,
    this.name = '',
    this.email = '',
    this.phone = '',
    this.address = '',
  });

  final bool isEditing;
  final bool isLoading;
  final String name;
  final String email;
  final String phone;
  final String address;

  ProfileState copyWith({
    bool? isEditing,
    bool? isLoading,
    String? name,
    String? email,
    String? phone,
    String? address,
  }) {
    return ProfileState(
      isEditing: isEditing ?? this.isEditing,
      isLoading: isLoading ?? this.isLoading,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }
}