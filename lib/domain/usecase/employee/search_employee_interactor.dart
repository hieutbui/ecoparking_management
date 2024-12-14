import 'package:dartz/dartz.dart';
import 'package:ecoparking_management/data/models/employee_nested_info.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/employee_repository.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/domain/state/employee/search_employee_state.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';

class SearchEmployeeInteractor with InteractorLoggy {
  final EmployeeRepository _repository = getIt.get<EmployeeRepository>();

  Stream<Either<Failure, Success>> execute({
    required String parkingId,
    required String searchKey,
  }) async* {
    try {
      yield const Right(SearchEmployeeLoading());

      final List<Map<String, dynamic>?>? result =
          await _repository.searchEmployee(
        parkingId: parkingId,
        searchKey: searchKey,
      );

      if (result == null) {
        yield const Left(SearchEmployeeEmpty());

        return;
      }

      if (result.isEmpty) {
        yield const Left(SearchEmployeeEmpty());

        return;
      }

      List<EmployeeNestedInfo> employees = [];

      for (final item in result) {
        if (item != null) {
          if (item['parking'] == null) {
            continue;
          }
          employees.add(EmployeeNestedInfo.fromJson(item));
        } else {
          yield const Left(SearchEmployeeEmpty());

          return;
        }
      }

      if (employees.isEmpty) {
        yield const Left(SearchEmployeeEmpty());

        return;
      }

      yield Right(SearchEmployeeSuccess(
        employees: employees,
      ));
    } catch (e) {
      yield Left(SearchEmployeeFailure(exception: e));
    }
  }
}
