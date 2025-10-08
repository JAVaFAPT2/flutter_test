import 'package:equatable/equatable.dart';

/// Domain entity for user profile
class UserProfile extends Equatable {
  const UserProfile({
    required this.id,
    required this.fullName,
    required this.phone,
    this.email,
    this.avatarUrl,
    this.address,
    this.dateOfBirth,
    this.createdAt,
  });

  final String id;
  final String fullName;
  final String phone;
  final String? email;
  final String? avatarUrl;
  final String? address;
  final DateTime? dateOfBirth;
  final DateTime? createdAt;

  UserProfile copyWith({
    String? id,
    String? fullName,
    String? phone,
    String? email,
    String? avatarUrl,
    String? address,
    DateTime? dateOfBirth,
    DateTime? createdAt,
  }) {
    return UserProfile(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      address: address ?? this.address,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        fullName,
        phone,
        email,
        avatarUrl,
        address,
        dateOfBirth,
        createdAt,
      ];
}

