import 'package:vietnamese_fish_sauce_app/core/domain/entities/user.dart';

/// Data model for user with JSON serialization
class UserModel {
  const UserModel({
    required this.id,
    required this.phone,
    required this.fullName,
    this.email,
    this.createdAt,
  });

  /// Convert from domain entity
  factory UserModel.fromEntity(User entity) {
    return UserModel(
      id: entity.id,
      phone: entity.phone,
      fullName: entity.fullName,
      email: entity.email,
      createdAt: entity.createdAt,
    );
  }

  /// Convert from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      phone: json['phone'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
    );
  }

  final String id;
  final String phone;
  final String fullName;
  final String? email;
  final DateTime? createdAt;

  /// Convert to domain entity
  User toEntity() {
    return User(
      id: id,
      phone: phone,
      fullName: fullName,
      email: email,
      createdAt: createdAt,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'fullName': fullName,
      'email': email,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
