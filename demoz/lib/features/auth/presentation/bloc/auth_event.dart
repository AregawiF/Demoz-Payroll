part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class RegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String companyName;
  final String companyAddress;
  final String phoneNumber;
  final String tinNumber;
  final int numberOfEmployees;
  final String companyBank;
  final String bankAccountNumber;

  const RegisterRequested({
    required this.email,
    required this.password,
    required this.companyName,
    required this.companyAddress,
    required this.phoneNumber,
    required this.tinNumber,
    required this.numberOfEmployees,
    required this.companyBank,
    required this.bankAccountNumber,
  });

  @override
  List<Object> get props => [
    email,
    password,
    companyName,
    companyAddress,
    phoneNumber,
    tinNumber,
    numberOfEmployees,
    companyBank,
    bankAccountNumber,
  ];
}

class LogoutRequested extends AuthEvent {}

class CheckAuthStatus extends AuthEvent {}
