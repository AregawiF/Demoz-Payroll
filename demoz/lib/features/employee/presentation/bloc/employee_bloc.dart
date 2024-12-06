import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/add_employee.dart';
import '../../domain/usecases/delete_employee.dart';
import '../../domain/usecases/get_employees.dart';
import '../../domain/usecases/get_employee_stats.dart';
import '../../domain/usecases/import_employees.dart';
import '../../domain/usecases/update_employee.dart';
import 'employee_event.dart';
import 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final GetEmployees getEmployees;
  final AddEmployee addEmployee;
  final UpdateEmployee updateEmployee;
  final DeleteEmployee deleteEmployee;
  final GetEmployeeStats getEmployeeStats;
  final ImportEmployees importEmployees;

  EmployeeBloc({
    required this.getEmployees,
    required this.addEmployee,
    required this.updateEmployee,
    required this.deleteEmployee,
    required this.getEmployeeStats,
    required this.importEmployees,
  }) : super(EmployeeInitial()) {
    on<GetEmployeesEvent>(_onGetEmployees);
    on<AddEmployeeEvent>(_onAddEmployee);
    on<UpdateEmployeeEvent>(_onUpdateEmployee);
    on<DeleteEmployeeEvent>(_onDeleteEmployee);
    on<GetEmployeeStatsEvent>(_onGetEmployeeStats);
    on<ImportEmployeesEvent>(_onImportEmployees);

    // Trigger initial load
    add(GetEmployeeStatsEvent());

    // Log every event
    on<EmployeeEvent>((event, emit) {
      print('Event: ${event.runtimeType}');
    });
  }

  @override
  void onTransition(Transition<EmployeeEvent, EmployeeState> transition) {
    print('Transition: ${transition.currentState} -> ${transition.nextState}');
    super.onTransition(transition);
  }

  Future<void> _onGetEmployees(
    GetEmployeesEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(EmployeeLoading());
    final result = await getEmployees(NoParams());
    result.fold(
      (failure) => emit(EmployeeError(failure.message)),
      (employees) => emit(EmployeesLoaded(employees)),
    );
  }

  Future<void> _onAddEmployee(
    AddEmployeeEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(EmployeeLoading());
    final result = await addEmployee(AddEmployeeParams(employee: event.employee));
    result.fold(
      (failure) => emit(EmployeeError(failure.message)),
      (_) {
        emit(const EmployeeOperationSuccess('Employee added successfully'));
        add(GetEmployeesEvent());
        add(GetEmployeeStatsEvent());

      },
    );
  }

  Future<void> _onUpdateEmployee(
    UpdateEmployeeEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(EmployeeLoading());
    final result = await updateEmployee(UpdateEmployeeParams(employee: event.employee));
    result.fold(
      (failure) => emit(EmployeeError(failure.message)),
      (_) {
        emit(const EmployeeOperationSuccess('Employee updated successfully'));
        add(GetEmployeesEvent());
      },
    );
  }

  Future<void> _onDeleteEmployee(
    DeleteEmployeeEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(EmployeeLoading());
    final result = await deleteEmployee(DeleteEmployeeParams(id: event.employeeId));
    result.fold(
      (failure) => emit(EmployeeError(failure.message)),
      (_) {
        emit(const EmployeeOperationSuccess('Employee deleted successfully'));
        add(GetEmployeesEvent());
      },
    );
  }

  Future<void> _onGetEmployeeStats(
    GetEmployeeStatsEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    // Prevent re-entering if already loading
    if (state is EmployeesLoaded) return;

    emit(EmployeeLoading());
    
    // First, get employee stats
    final statsResult = await getEmployeeStats(NoParams());
    
    // Then, get employees
    final employeesResult = await getEmployees(NoParams());
    
    // Combine results
    return statsResult.fold(
      (failure) => emit(EmployeeError(failure.message)),
      (stats) => employeesResult.fold(
        (failure) => emit(EmployeeError(failure.message)),
        (employees) => emit(EmployeesLoaded(employees, stats: stats))
      )
    );
  }

  Future<void> _onImportEmployees(
    ImportEmployeesEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(EmployeeLoading());
    final result = await importEmployees(ImportEmployeesParams(employees: event.employees));
    result.fold(
      (failure) => emit(EmployeeError(failure.message)),
      (_) {
        emit(const EmployeeOperationSuccess('Employees imported successfully'));
        add(GetEmployeesEvent());
      },
    );
  }
}
