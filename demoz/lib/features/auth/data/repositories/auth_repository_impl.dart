import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.localDataSource});

  @override
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
  }) async {
    try {
      final user = await localDataSource.register(
        email: email,
        password: password,
        companyName: companyName,
        companyAddress: companyAddress,
        phoneNumber: phoneNumber,
        tinNumber: tinNumber,
        numberOfEmployees: numberOfEmployees,
        companyBank: companyBank,
        bankAccountNumber: bankAccountNumber,
      );
      return Right(user);
    } on CacheFailure catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await localDataSource.login(
        email: email,
        password: password,
      );
      return Right(user);
    } on CacheFailure catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.logout();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final user = await localDataSource.getCurrentUser();
      if (user == null) {
        return Left(CacheFailure('No user logged in'));
      }
      return Right(user);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateUser(User user) async {
    try {
      final userModel = UserModel.fromEntity(user, password: ''); // Password won't be updated here
      await localDataSource.updateUser(userModel);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      final isLoggedIn = await localDataSource.isLoggedIn();
      return Right(isLoggedIn);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
