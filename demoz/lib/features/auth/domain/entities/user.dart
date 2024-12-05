import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String companyName;
  final String companyAddress;
  final String phoneNumber;
  final String tinNumber;
  final int numberOfEmployees;
  final String companyBank;
  final String bankAccountNumber;
  final String role;
  final DateTime createdAt;
  final bool isActive;

  const User({
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
  });

  @override
  List<Object> get props => [
    id,
    email,
    companyName,
    companyAddress,
    phoneNumber,
    tinNumber,
    numberOfEmployees,
    companyBank,
    bankAccountNumber,
    role,
    createdAt,
    isActive,
  ];
}
