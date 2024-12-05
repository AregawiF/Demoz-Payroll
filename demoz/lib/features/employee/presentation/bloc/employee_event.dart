import 'package:equatable/equatable.dart';
import '../../domain/entities/employee.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object> get props => [];
}

class GetEmployeesEvent extends EmployeeEvent {}

class AddEmployeeEvent extends EmployeeEvent {
  final Employee employee;

  const AddEmployeeEvent(this.employee);

  @override
  List<Object> get props => [employee];
}

class UpdateEmployeeEvent extends EmployeeEvent {
  final Employee employee;

  const UpdateEmployeeEvent(this.employee);

  @override
  List<Object> get props => [employee];
}

class DeleteEmployeeEvent extends EmployeeEvent {
  final String employeeId;

  const DeleteEmployeeEvent(this.employeeId);

  @override
  List<Object> get props => [employeeId];
}

class ImportEmployeesEvent extends EmployeeEvent {
  final List<Employee> employees;

  const ImportEmployeesEvent(this.employees);

  @override
  List<Object> get props => [employees];
}

class GetEmployeeStatsEvent extends EmployeeEvent {}
