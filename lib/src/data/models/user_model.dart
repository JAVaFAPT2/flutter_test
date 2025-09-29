import '../../domain/entities/user.dart';

/// Data model for User entity
class UserModel {
  const UserModel({
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

  /// Create from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      phone: json['phone'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String?,
      address: json['address'] as String?,
      avatar: json['avatar'] as String?,
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'] as String)
          : null,
      gender: json['gender'] as String?,
      isVerified: json['isVerified'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'fullName': fullName,
      'email': email,
      'address': address,
      'avatar': avatar,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'gender': gender,
      'isVerified': isVerified,
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  /// Convert to domain entity
  User toEntity() {
    return User(
      id: id,
      phone: phone,
      fullName: fullName,
      email: email,
      address: address,
      avatar: avatar,
      dateOfBirth: dateOfBirth,
      gender: gender,
      isVerified: isVerified,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create from domain entity
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      phone: user.phone,
      fullName: user.fullName,
      email: user.email,
      address: user.address,
      avatar: user.avatar,
      dateOfBirth: user.dateOfBirth,
      gender: user.gender,
      isVerified: user.isVerified,
      isActive: user.isActive,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    );
  }
}
