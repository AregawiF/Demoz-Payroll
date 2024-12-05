import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/employee.dart';
import '../../domain/repositories/employee_repository.dart';
import '../datasources/employee_local_datasource.dart';
import '../models/employee_model.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeLocalDataSource localDataSource;

  EmployeeRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Employee>>> getEmployees() async {
    try {
      final employees = await localDataSource.getEmployees();
      return Right(employees);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Employee>> addEmployee(Employee employee) async {
    try {
      final employeeModel = EmployeeModel.fromEntity(employee);
      await localDataSource.addEmployee(employeeModel);
      return Right(employee);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateEmployee(Employee employee) async {
    try {
      final employeeModel = EmployeeModel.fromEntity(employee);
      await localDataSource.updateEmployee(employeeModel);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteEmployee(String id) async {
    try {
      await localDataSource.deleteEmployee(id);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Employee>>> importEmployees(List<Employee> employees) async {
    try {
      final employeeModels = employees.map((e) => EmployeeModel.fromEntity(e)).toList();
      await localDataSource.cacheEmployees(employeeModels);
      return Right(employees);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getEmployeeStats() async {
    try {
      final employees = await localDataSource.getEmployees();
      return Right(_calculateEmployeeStats(employees));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  Map<String, dynamic> _calculateEmployeeStats(List<EmployeeModel> employees) {
    int maleCount = 0;
    int femaleCount = 0;
    double totalSalary = 0;
    double totalIncomeTax = 0;
    double totalPensionTax = 0;

    for (var employee in employees) {
      if (employee.gender.toLowerCase() == 'male') {
        maleCount++;
      } else if (employee.gender.toLowerCase() == 'female') {
        femaleCount++;
      }

      totalSalary += employee.salary;
      totalIncomeTax += employee.incomeTax;
      totalPensionTax += employee.pensionTax;
    }

    return {
      'totalEmployees': employees.length,
      'maleCount': maleCount,
      'femaleCount': femaleCount,
      'totalSalary': totalSalary,
      'totalIncomeTax': totalIncomeTax,
      'totalPensionTax': totalPensionTax,
      'activeEmployees': employees.where((e) => e.isActive).length,
    };
  }
}
