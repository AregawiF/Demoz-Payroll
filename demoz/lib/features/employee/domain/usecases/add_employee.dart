import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/employee.dart';
import '../repositories/employee_repository.dart';

class AddEmployee implements UseCase<Employee, AddEmployeeParams> {
  final EmployeeRepository repository;

  AddEmployee(this.repository);

  @override
  Future<Either<Failure, Employee>> call(AddEmployeeParams params) async {
    return await repository.addEmployee(params.employee);
  }
}

class AddEmployeeParams extends Equatable {
  final Employee employee;

  const AddEmployeeParams({required this.employee});

  @override
  List<Object> get props => [employee];
}
