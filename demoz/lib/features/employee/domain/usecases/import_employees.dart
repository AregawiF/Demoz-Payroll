import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/employee.dart';
import '../repositories/employee_repository.dart';

class ImportEmployees implements UseCase<List<Employee>, ImportEmployeesParams> {
  final EmployeeRepository repository;

  ImportEmployees(this.repository);

  @override
  Future<Either<Failure, List<Employee>>> call(ImportEmployeesParams params) async {
    return await repository.importEmployees(params.employees);
  }
}

class ImportEmployeesParams extends Equatable {
  final List<Employee> employees;

  const ImportEmployeesParams({required this.employees});

  @override
  List<Object> get props => [employees];
}
