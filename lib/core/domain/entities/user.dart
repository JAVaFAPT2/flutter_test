import 'package:equatable/equatable.dart';

/// Core domain entity for user
/// Shared across features that need user information
class User extends Equatable {
  const User({
    required this.id,
    required this.phone,
    required this.fullName,
    this.email,
    this.address,
    this.createdAt,
  });

  final String id;
  final String phone;
  final String fullName;
  final String? email;
  final String? address;
  final DateTime? createdAt;

  User copyWith({
    String? id,
    String? phone,
    String? fullName,
    String? email,
    String? address,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, phone, fullName, email, address, createdAt];

  @override
  String toString() {
    return 'User(id: $id, phone: $phone, fullName: $fullName, email: $email, address: $address)';
  }
}
