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

import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/models/user_model.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/get_current_user_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Initialize Hive
  await Hive.initFlutter();
  
  // Register Hive Adapters
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(EmployeeModelAdapter());
  }
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(UserModelAdapter());
  }
  
  // Open Hive Boxes
  final employeeBox = await Hive.openBox<EmployeeModel>('employees');
  final userBox = await Hive.openBox<UserModel>('users');
  final sessionBox = await Hive.openBox<String>('session');

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

  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      registerUseCase: sl(),
      logoutUseCase: sl(),
      getCurrentUserUseCase: sl(),
    ),
  );

  // Use cases - Employee
  sl.registerLazySingleton(() => GetEmployees(sl()));
  sl.registerLazySingleton(() => AddEmployee(sl()));
  sl.registerLazySingleton(() => UpdateEmployee(sl()));
  sl.registerLazySingleton(() => DeleteEmployee(sl()));
  sl.registerLazySingleton(() => GetEmployeeStats(sl()));
  sl.registerLazySingleton(() => ImportEmployees(sl()));

  // Use cases - Auth
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));

  // Repository - Employee
  sl.registerLazySingleton<EmployeeRepository>(
    () => EmployeeRepositoryImpl(
      localDataSource: sl(),
    ),
  );

  // Repository - Auth
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      localDataSource: sl(),
    ),
  );

  // Data sources - Employee
  sl.registerLazySingleton<EmployeeLocalDataSource>(
    () => EmployeeLocalDataSourceImpl(
      employeeBox: employeeBox,
    ),
  );

  // Data sources - Auth
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      userBox: userBox,
      sessionBox: sessionBox,
    ),
  );
}
