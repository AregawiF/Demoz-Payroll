import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/employee_repository.dart';

class GetEmployeeStats implements UseCase<Map<String, dynamic>, NoParams> {
  final EmployeeRepository repository;

  GetEmployeeStats(this.repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(NoParams params) async {
    return await repository.getEmployeeStats();
  }
}
