import 'package:equatable/equatable.dart';
import '../../domain/entities/employee.dart';

abstract class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object> get props => [];
}

class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeesLoaded extends EmployeeState {
  final List<Employee> employees;
  final Map<String, dynamic>? stats;

  const EmployeesLoaded(this.employees, {this.stats});

  @override
  List<Object> get props => [employees, if (stats != null) stats!];
}

class EmployeeOperationSuccess extends EmployeeState {
  final String message;

  const EmployeeOperationSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class EmployeeStatsLoaded extends EmployeeState {
  final Map<String, dynamic> stats;

  const EmployeeStatsLoaded(this.stats);

  @override
  List<Object> get props => [stats];
}

class EmployeeError extends EmployeeState {
  final String message;

  const EmployeeError(this.message);

  @override
  List<Object> get props => [message];
}
