import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:hive/hive.dart';
import '../../../../core/error/failures.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel> register({
    required String email,
    required String password,
    required String companyName,
    required String companyAddress,
    required String phoneNumber,
    required String tinNumber,
    required int numberOfEmployees,
    required String companyBank,
    required String bankAccountNumber,
  });

  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<UserModel?> getCurrentUser();

  Future<void> updateUser(UserModel user);

  Future<bool> isLoggedIn();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box<UserModel> userBox;
  final Box<String> sessionBox;
  static const String USER_BOX_NAME = 'users';
  static const String SESSION_BOX_NAME = 'session';
  static const String CURRENT_USER_KEY = 'current_user_id';

  AuthLocalDataSourceImpl({
    required this.userBox,
    required this.sessionBox,
  });

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Future<UserModel> register({
    required String email,
    required String password,
    required String companyName,
    required String companyAddress,
    required String phoneNumber,
    required String tinNumber,
    required int numberOfEmployees,
    required String companyBank,
    required String bankAccountNumber,
  }) async {
    // Check if email already exists
    final existingUser = userBox.values.any((user) => user.email == email);
    if (existingUser) {
      throw CacheFailure('Email already registered');
    }

    final user = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      companyName: companyName,
      companyAddress: companyAddress,
      phoneNumber: phoneNumber,
      tinNumber: tinNumber,
      numberOfEmployees: numberOfEmployees,
      companyBank: companyBank,
      bankAccountNumber: bankAccountNumber,
      role: 'admin', // Default role for now
      createdAt: DateTime.now(),
      isActive: true,
      password: _hashPassword(password),
    );

    await userBox.put(user.id, user);
    await sessionBox.put(CURRENT_USER_KEY, user.id);

    return user;
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final hashedPassword = _hashPassword(password);
    
    final user = userBox.values.firstWhere(
      (user) => user.email == email && user.password == hashedPassword,
      orElse: () => throw CacheFailure('Invalid email or password'),
    );

    await sessionBox.put(CURRENT_USER_KEY, user.id);
    return user;
  }

  @override
  Future<void> logout() async {
    await sessionBox.delete(CURRENT_USER_KEY);
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final currentUserId = sessionBox.get(CURRENT_USER_KEY);
    if (currentUserId == null) return null;
    
    return userBox.get(currentUserId);
  }

  @override
  Future<void> updateUser(UserModel user) async {
    await userBox.put(user.id, user);
  }

  @override
  Future<bool> isLoggedIn() async {
    final currentUserId = sessionBox.get(CURRENT_USER_KEY);
    return currentUserId != null;
  }
}
