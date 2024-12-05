import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../features/employee/data/datasources/employee_local_datasource.dart';
import '../../features/employee/data/models/employee_model.dart';
import '../../features/employee/data/repositories/employee_repository_impl.dart';
import '../../features/employee/domain/repositories/employee_repository.dart';
import '../../features/employee/domain/usecases/add_employee.dart';
import '../../features/employee/domain/usecases/delete_employee.dart';
import '../../features/employee/domain/usecases/get_employees.dart';
import '../../features/employee/domain/usecases/get_employee_stats.dart';
import '../../features/employee/domain/usecases/import_employees.dart';
import '../../features/employee/domain/usecases/update_employee.dart';
import '../../features/employee/presentation/bloc/employee_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Initialize Hive
  await Hive.initFlutter();
  
  // Register Hive Adapters
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(EmployeeModelAdapter());
  }
  
  // Open Hive Boxes
  final employeeBox = await Hive.openBox<EmployeeModel>('employees');

  // BLoC
  sl.registerFactory(
    () => EmployeeBloc(
      getEmployees: sl(),
      addEmployee: sl(),
      updateEmployee: sl(),
      deleteEmployee: sl(),
      getEmployeeStats: sl(),
      importEmployees: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetEmployees(sl()));
  sl.registerLazySingleton(() => AddEmployee(sl()));
  sl.registerLazySingleton(() => UpdateEmployee(sl()));
  sl.registerLazySingleton(() => DeleteEmployee(sl()));
  sl.registerLazySingleton(() => GetEmployeeStats(sl()));
  sl.registerLazySingleton(() => ImportEmployees(sl()));

  // Repository
  sl.registerLazySingleton<EmployeeRepository>(
    () => EmployeeRepositoryImpl(
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<EmployeeLocalDataSource>(
    () => EmployeeLocalDataSourceImpl(
      employeeBox: employeeBox,
    ),
  );
}
