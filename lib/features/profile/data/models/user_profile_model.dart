import 'package:vietnamese_fish_sauce_app/features/profile/domain/entities/user_profile.dart';

/// Data model for user profile with JSON serialization
class UserProfileModel {
  const UserProfileModel({
    required this.id,
    required this.fullName,
    required this.phone,
    this.email,
    this.avatarUrl,
    this.address,
    this.dateOfBirth,
    this.createdAt,
  });

  /// Convert from domain entity
  factory UserProfileModel.fromEntity(UserProfile entity) {
    return UserProfileModel(
      id: entity.id,
      fullName: entity.fullName,
      phone: entity.phone,
      email: entity.email,
      avatarUrl: entity.avatarUrl,
      address: entity.address,
      dateOfBirth: entity.dateOfBirth,
      createdAt: entity.createdAt,
    );
  }

  /// Convert from JSON
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      address: json['address'] as String?,
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'] as String)
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
    );
  }

  final String id;
  final String fullName;
  final String phone;
  final String? email;
  final String? avatarUrl;
  final String? address;
  final DateTime? dateOfBirth;
  final DateTime? createdAt;

  /// Convert to domain entity
  UserProfile toEntity() {
    return UserProfile(
      id: id,
      fullName: fullName,
      phone: phone,
      email: email,
      avatarUrl: avatarUrl,
      address: address,
      dateOfBirth: dateOfBirth,
      createdAt: createdAt,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'phone': phone,
      'email': email,
      'avatarUrl': avatarUrl,
      'address': address,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
