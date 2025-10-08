import 'package:vietnamese_fish_sauce_app/core/domain/entities/user.dart';
import 'package:vietnamese_fish_sauce_app/core/domain/repositories/auth_repository.dart';
import 'package:vietnamese_fish_sauce_app/core/domain/value_objects/result.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';

/// Implementation of auth repository
/// Coordinates between remote and local data sources
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  @override
  Future<Result<User>> login({
    required String phone,
    required String password,
  }) async {
    try {
      final userModel = await _remoteDataSource.login(
        phone: phone,
        password: password,
      );

      // Save token and session
      await _localDataSource.saveToken('token_${userModel.id}');
      await _localDataSource.saveUserSession(userModel);

      return Success(userModel.toEntity());
    } catch (e) {
      return Failure(e.toString());
    }
  }

  @override
  Future<Result<User>> register({
    required String phone,
    required String password,
    required String fullName,
    String? email,
  }) async {
    try {
      final userModel = await _remoteDataSource.register(
        phone: phone,
        password: password,
        fullName: fullName,
        email: email,
      );

      // Save token and session
      await _localDataSource.saveToken('token_${userModel.id}');
      await _localDataSource.saveUserSession(userModel);

      return Success(userModel.toEntity());
    } catch (e) {
      return Failure(e.toString());
    }
  }

  @override
  Future<Result<void>> requestOtp({required String phone}) async {
    try {
      await _remoteDataSource.requestOtp(phone: phone);
      return const Success(null);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  @override
  Future<Result<User>> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    try {
      final userModel = await _remoteDataSource.verifyOtp(
        phone: phone,
        otp: otp,
      );

      // Save token and session
      await _localDataSource.saveToken('token_${userModel.id}');
      await _localDataSource.saveUserSession(userModel);

      return Success(userModel.toEntity());
    } catch (e) {
      return Failure(e.toString());
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    final userModel = await _localDataSource.getUserSession();
    return userModel?.toEntity();
  }

  @override
  Future<void> logout() async {
    await _localDataSource.removeToken();
    await _localDataSource.removeUserSession();
  }

  @override
  Future<bool> isAuthenticated() async {
    return await _localDataSource.hasToken();
  }
}

