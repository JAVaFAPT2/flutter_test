import 'package:equatable/equatable.dart';

/// User entity representing an application user
class User extends Equatable {
  const User({
    required this.id,
    required this.phone,
    required this.fullName,
    this.email,
    this.address,
    this.avatar,
    this.dateOfBirth,
    this.gender,
    this.isVerified = false,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String phone;
  final String fullName;
  final String? email;
  final String? address;
  final String? avatar;
  final DateTime? dateOfBirth;
  final String? gender;
  final bool isVerified;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  /// Check if user has complete profile
  bool get hasCompleteProfile => fullName.isNotEmpty;

  /// Check if user has verified contact methods
  bool get isContactVerified => isVerified;

  /// Get display name (full name or phone number)
  String get displayName => fullName;

  /// Create a copy of this user with updated fields
  User copyWith({
    String? id,
    String? phone,
    String? fullName,
    String? email,
    String? address,
    String? avatar,
    DateTime? dateOfBirth,
    String? gender,
    bool? isVerified,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      address: address ?? this.address,
      avatar: avatar ?? this.avatar,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      isVerified: isVerified ?? this.isVerified,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        phone,
        fullName,
        email,
        address,
        avatar,
        dateOfBirth,
        gender,
        isVerified,
        isActive,
        createdAt,
        updatedAt,
      ];
}