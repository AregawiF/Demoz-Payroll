import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/employee_repository.dart';

class DeleteEmployee implements UseCase<void, DeleteEmployeeParams> {
  final EmployeeRepository repository;

  DeleteEmployee(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteEmployeeParams params) async {
    return await repository.deleteEmployee(params.id);
  }
}

class DeleteEmployeeParams extends Equatable {
  final String id;

  const DeleteEmployeeParams({required this.id});

  @override
  List<Object> get props => [id];
}
