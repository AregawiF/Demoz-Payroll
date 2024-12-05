import 'package:hive/hive.dart';
import '../../domain/entities/user.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel extends User {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String companyName;

  @HiveField(3)
  final String companyAddress;

  @HiveField(4)
  final String phoneNumber;

  @HiveField(5)
  final String tinNumber;

  @HiveField(6)
  final int numberOfEmployees;

  @HiveField(7)
  final String companyBank;

  @HiveField(8)
  final String bankAccountNumber;

  @HiveField(9)
  final String role;

  @HiveField(10)
  final DateTime createdAt;

  @HiveField(11)
  final bool isActive;

  @HiveField(12)
  final String password; // Hashed password for local storage

  const UserModel({
    required this.id,
    required this.email,
    required this.companyName,
    required this.companyAddress,
    required this.phoneNumber,
    required this.tinNumber,
    required this.numberOfEmployees,
    required this.companyBank,
    required this.bankAccountNumber,
    required this.role,
    required this.createdAt,
    required this.isActive,
    required this.password,
  }) : super(
    id: id,
    email: email,
    companyName: companyName,
    companyAddress: companyAddress,
    phoneNumber: phoneNumber,
    tinNumber: tinNumber,
    numberOfEmployees: numberOfEmployees,
    companyBank: companyBank,
    bankAccountNumber: bankAccountNumber,
    role: role,
    createdAt: createdAt,
    isActive: isActive,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      companyName: json['companyName'],
      companyAddress: json['companyAddress'],
      phoneNumber: json['phoneNumber'],
      tinNumber: json['tinNumber'],
      numberOfEmployees: json['numberOfEmployees'],
      companyBank: json['companyBank'],
      bankAccountNumber: json['bankAccountNumber'],
      role: json['role'],
      createdAt: DateTime.parse(json['createdAt']),
      isActive: json['isActive'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'companyName': companyName,
      'companyAddress': companyAddress,
      'phoneNumber': phoneNumber,
      'tinNumber': tinNumber,
      'numberOfEmployees': numberOfEmployees,
      'companyBank': companyBank,
      'bankAccountNumber': bankAccountNumber,
      'role': role,
      'createdAt': createdAt.toIso8601String(),
      'isActive': isActive,
      'password': password,
    };
  }

  factory UserModel.fromEntity(User user, {required String password}) {
    return UserModel(
      id: user.id,
      email: user.email,
      companyName: user.companyName,
      companyAddress: user.companyAddress,
      phoneNumber: user.phoneNumber,
      tinNumber: user.tinNumber,
      numberOfEmployees: user.numberOfEmployees,
      companyBank: user.companyBank,
      bankAccountNumber: user.bankAccountNumber,
      role: user.role,
      createdAt: user.createdAt,
      isActive: user.isActive,
      password: password,
    );
  }
}
