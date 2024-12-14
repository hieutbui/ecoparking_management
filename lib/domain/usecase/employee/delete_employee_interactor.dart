import 'package:dartz/dartz.dart';
import 'package:ecoparking_management/data/models/parking_employee.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/employee_repository.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/domain/state/employee/delete_employee_state.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';

class DeleteEmployeeInteractor with InteractorLoggy {
  final EmployeeRepository _repository = getIt.get<EmployeeRepository>();

  Stream<Either<Failure, Success>> execute({
    required List<String> employeeId,
  }) async* {
    try {
      yield const Right(DeleteEmployeeLoading());

      final List<Map<String, dynamic>> result =
          await _repository.deleteEmployee(
        employeeId: employeeId,
      );

      if (result.isEmpty) {
        yield const Left(DeleteEmployeeEmpty());

        return;
      }

      final deletedEmployee =
          result.map((e) => ParkingEmployee.fromJson(e)).toList();

      yield Right(DeleteEmployeeSuccess(
        employee: deletedEmployee,
      ));
    } catch (e) {
      yield Left(DeleteEmployeeFailure(exception: e));
    }
  }
}
