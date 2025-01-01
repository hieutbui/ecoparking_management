import 'package:dartz/dartz.dart';
import 'package:ecoparking_management/data/models/employee_attendance.dart';
import 'package:ecoparking_management/data/models/save_attendance_to_xlsx_status.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/employee_repository.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/domain/state/employee/save_attendance_to_xlsx_state.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';

class SaveAttendanceToXlsxInteractor with InteractorLoggy {
  final EmployeeRepository _repository = getIt.get<EmployeeRepository>();

  Stream<Either<Failure, Success>> execute({
    required List<EmployeeAttendance> attendances,
  }) async* {
    try {
      yield const Right(SaveAttendanceToXlsxLoading());

      final Map<String, dynamic> result =
          await _repository.saveAttendanceToXlsx(
        attendances: attendances,
      );

      if (result.isEmpty) {
        yield const Left(
            SaveAttendanceToXlsxFailure(exception: 'Empty result'));

        return;
      }

      final status = SaveAttendanceToXlsxStatus.fromJson(result);

      if (status.status == SaveAttendanceToXlsxStatusEnum.success) {
        yield Right(SaveAttendanceToXlsxSuccess(status: status));
      } else {
        yield const Left(
          SaveAttendanceToXlsxFailure(exception: 'Failed to save'),
        );
      }
    } catch (e) {
      yield Left(SaveAttendanceToXlsxFailure(exception: e));
    }
  }
}
