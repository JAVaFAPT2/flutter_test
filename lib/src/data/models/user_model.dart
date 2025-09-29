import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String phone,
    required String fullName,
    String? email,
    String? address,
    String? avatar,
    DateTime? dateOfBirth,
    String? gender,
    @Default(false) bool isVerified,
    @Default(true) bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  factory UserModel.fromEntity(User user) => UserModel(
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

extension UserModelX on UserModel {
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
}
