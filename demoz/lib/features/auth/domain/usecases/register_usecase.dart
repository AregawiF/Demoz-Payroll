import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase implements UseCase<User, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(RegisterParams params) async {
    return await repository.register(
      email: params.email,
      password: params.password,
      companyName: params.companyName,
      companyAddress: params.companyAddress,
      phoneNumber: params.phoneNumber,
      tinNumber: params.tinNumber,
      numberOfEmployees: params.numberOfEmployees,
      companyBank: params.companyBank,
      bankAccountNumber: params.bankAccountNumber,
    );
  }
}

class RegisterParams extends Equatable {
  final String email;
  final String password;
  final String companyName;
  final String companyAddress;
  final String phoneNumber;
  final String tinNumber;
  final int numberOfEmployees;
  final String companyBank;
  final String bankAccountNumber;

  const RegisterParams({
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
  List<Object?> get props => [
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
