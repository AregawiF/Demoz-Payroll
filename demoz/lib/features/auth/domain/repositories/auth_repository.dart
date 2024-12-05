import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> register({
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

  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, User>> getCurrentUser();

  Future<Either<Failure, void>> updateUser(User user);

  Future<Either<Failure, bool>> isLoggedIn();
}
