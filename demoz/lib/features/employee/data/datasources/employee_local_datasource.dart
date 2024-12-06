import 'package:hive/hive.dart';
import '../../../../core/error/failures.dart';
import '../models/employee_model.dart';
import 'package:uuid/uuid.dart'; 

abstract class EmployeeLocalDataSource {
  Future<List<EmployeeModel>> getEmployees();
  Future<void> cacheEmployees(List<EmployeeModel> employees);
  Future<void> addEmployee(EmployeeModel employee);
  Future<void> updateEmployee(EmployeeModel employee);
  Future<void> deleteEmployee(String id);
}

class EmployeeLocalDataSourceImpl implements EmployeeLocalDataSource {
  final Box<EmployeeModel> employeeBox;
  static const String EMPLOYEE_BOX_NAME = 'employees';

  EmployeeLocalDataSourceImpl({required this.employeeBox});

  @override
  Future<List<EmployeeModel>> getEmployees() async {
    try {
      if (employeeBox.isEmpty) {
        await _addDummyData();
      }
      return employeeBox.values.toList();
    } catch (e) {
      throw CacheFailure('Failed to get employees from local storage');
    }
  }

  @override
  Future<void> cacheEmployees(List<EmployeeModel> employees) async {
    try {
      await employeeBox.clear();
      for (var employee in employees) {
        await employeeBox.put(employee.id, employee);
      }
    } catch (e) {
      throw CacheFailure('Failed to cache employees');
    }
  }

  @override
  Future<void> addEmployee(EmployeeModel employee) async {
    try {
      await employeeBox.put(employee.id, employee);
    } catch (e) {
      throw CacheFailure('Failed to add employee');
    }
  }

  @override
  Future<void> updateEmployee(EmployeeModel employee) async {
    try {
      await employeeBox.put(employee.id, employee);
    } catch (e) {
      throw CacheFailure('Failed to update employee');
    }
  }

  @override
  Future<void> deleteEmployee(String id) async {
    try {
      await employeeBox.delete(id);
    } catch (e) {
      throw CacheFailure('Failed to delete employee');
    }
  }

  Future<void> _addDummyData() async {
    var uuid = const Uuid();

    final dummyEmployees = [
      EmployeeModel(
        id: uuid.v4(), 
        name: 'John Doe',
        email: 'john@example.com',
        salary: 5000,
        incomeTax: 500,
        pensionTax: 250,
        gender: 'male',
        joiningDate: DateTime(2023, 1, 15),
        isActive: true,
        grossPay: 5000,
        taxableEarnings: 4500, 
      ),
      EmployeeModel(
        id: uuid.v4(), 
        name: 'Almaz Smith',
        email: 'almaz@example.com',
        salary: 6000,
        incomeTax: 600,
        pensionTax: 300,
        gender: 'female',
        joiningDate: DateTime(2023, 3, 1),
        isActive: true,
        grossPay: 6000, 
        taxableEarnings: 5400,
      ),
    ];

    for (var employee in dummyEmployees) {
      await employeeBox.put(employee.id, employee);
    }
  }
}
