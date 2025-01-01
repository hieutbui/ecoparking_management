import 'package:dartz/dartz.dart';
import 'package:ecoparking_management/data/models/employee_nested_info.dart';
import 'package:ecoparking_management/data/models/save_employee_to_xlsx_status.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/employee_repository.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/domain/state/employee/save_employee_to_xlsx_state.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';

class SaveEmployeeToXlsxInteractor with InteractorLoggy {
  final EmployeeRepository _repository = getIt.get<EmployeeRepository>();

  Stream<Either<Failure, Success>> execute({
    required List<String> listTitles,
    required List<EmployeeNestedInfo> employees,
  }) async* {
    try {
      yield const Right(SaveEmployeeToXlsxLoading());

      final Map<String, dynamic> result = await _repository.saveEmployeeToXlsx(
        listTitles: listTitles,
        employees: employees,
      );

      if (result.isEmpty) {
        yield const Left(SaveEmployeeToXlsxFailure(exception: 'Empty result'));

        return;
      }

      final status = SaveEmployeeToXlsxStatus.fromJson(result);

      if (status.status == SaveEmployeeToXlsxStatusEnum.success) {
        yield Right(SaveEmployeeToXlsxSuccess(status: status));
      } else {
        yield const Left(
          SaveEmployeeToXlsxFailure(exception: 'Failed to save'),
        );
      }
    } catch (e) {
      yield Left(SaveEmployeeToXlsxFailure(exception: e));
    }
  }
}
