import 'package:dartz/dartz.dart';
import 'package:ecoparking_management/data/models/parking_employee.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/employee_repository.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/domain/state/employee/create_new_employee_state.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateNewEmployeeInteractor with InteractorLoggy {
  final EmployeeRepository _repository = getIt.get<EmployeeRepository>();

  Stream<Either<Failure, Success>> execute({
    required ParkingEmployee employee,
    required String email,
    required String password,
    required String fullName,
  }) async* {
    try {
      yield const Right(CreateNewEmployeeLoading());

      final AuthResponse authResponse = await _repository.signUp(
        email: email,
        password: password,
        fullName: fullName,
      );

      final User? user = authResponse.user;

      if (user == null) {
        yield const Left(CreateNewEmployeeEmpty());

        return;
      }

      final ParkingEmployee newEmployee = ParkingEmployee(
        parkingId: employee.parkingId,
        profileId: user.id,
        currencyLocale: employee.currencyLocale,
        workingStartTime: employee.workingStartTime,
        workingEndTime: employee.workingEndTime,
      );

      final Map<String, dynamic> result = await _repository.createEmployee(
        employee: newEmployee,
      );

      if (result.isEmpty) {
        yield const Left(CreateNewEmployeeEmpty());

        return;
      }

      yield Right(CreateNewEmployeeSuccess(
        employee: ParkingEmployee.fromJson(result),
        user: user,
      ));
    } on AuthException catch (e) {
      yield Left(CreateNewEmployeeAuthFailure(exception: e));
    } catch (e) {
      yield Left(CreateNewEmployeeFailure(exception: e));
    }
  }
}
