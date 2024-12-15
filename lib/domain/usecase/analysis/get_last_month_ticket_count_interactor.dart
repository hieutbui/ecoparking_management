import 'package:dartz/dartz.dart';
import 'package:ecoparking_management/data/models/analysis_data.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/analysis_repository.dart';
import 'package:ecoparking_management/domain/state/analysis/get_last_month_ticket_count_state.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';

class GetLastMonthTicketCountInteractor with InteractorLoggy {
  final AnalysisRepository _repository = getIt.get<AnalysisRepository>();

  Stream<Either<Failure, Success>> execute({required String parkingId}) async* {
    try {
      yield const Right(GetLastMonthTicketCountLoading());

      final result =
          await _repository.getLastMonthTicketCount(parkingId: parkingId);

      if (result.isEmpty) {
        yield const Right(GetLastMonthTicketCountEmpty());
      }

      final data = result.map((e) => AnalysisData.fromJson(e)).toList();

      yield Right(
        GetLastMonthTicketCountSuccess(data: data),
      );
    } catch (e) {
      yield Left(GetLastMonthTicketCountFailure(exception: e));
    }
  }
}
