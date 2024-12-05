import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/employee.dart';

abstract class EmployeeRepository {
  Future<Either<Failure, List<Employee>>> getEmployees();
  Future<Either<Failure, Employee>> addEmployee(Employee employee);
  Future<Either<Failure, void>> updateEmployee(Employee employee);
  Future<Either<Failure, void>> deleteEmployee(String id);
  Future<Either<Failure, List<Employee>>> importEmployees(List<Employee> employees);
  Future<Either<Failure, Map<String, dynamic>>> getEmployeeStats();
}
