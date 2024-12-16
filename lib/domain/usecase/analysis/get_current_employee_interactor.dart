import 'package:dartz/dartz.dart';
import 'package:ecoparking_management/data/models/employee_nested_info.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/analysis_repository.dart';
import 'package:ecoparking_management/domain/state/analysis/get_current_employee_state.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';

class GetCurrentEmployeeInteractor with InteractorLoggy {
  final AnalysisRepository _repository = getIt.get<AnalysisRepository>();

  Stream<Either<Failure, Success>> execute({
    required String parkingId,
  }) async* {
    try {
      yield const Right(GetCurrentEmployeeLoading());

      final result = await _repository.getCurrentEmployee(
        parkingId: parkingId,
      );

      if (result.isEmpty) {
        yield const Right(GetCurrentEmployeeEmpty());
      } else {
        final employees =
            result.map((e) => EmployeeNestedInfo.fromJson(e)).toList();

        yield Right(GetCurrentEmployeeSuccess(employees: employees));
      }
    } catch (e) {
      yield Left(GetCurrentEmployeeFailure(exception: e));
    }
  }
}
