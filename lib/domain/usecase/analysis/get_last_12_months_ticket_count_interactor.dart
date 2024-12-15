import 'package:dartz/dartz.dart';
import 'package:ecoparking_management/data/models/analysis_data.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/analysis_repository.dart';
import 'package:ecoparking_management/domain/state/analysis/get_last_12_months_ticket_count_state.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';

class GetLast12MonthsTicketCountInteractor with InteractorLoggy {
  final AnalysisRepository _repository = getIt.get<AnalysisRepository>();

  Stream<Either<Failure, Success>> execute({required String parkingId}) async* {
    try {
      yield const Right(GetLast12MonthsTicketCountLoading());

      final result =
          await _repository.getLast12MonthsTicketCount(parkingId: parkingId);

      if (result.isEmpty) {
        yield const Right(GetLast12MonthsTicketCountEmpty());
      }

      final data = result.map((e) => AnalysisData.fromJson(e)).toList();

      yield Right(
        GetLast12MonthsTicketCountSuccess(data: data),
      );
    } catch (e) {
      yield Left(GetLast12MonthsTicketCountFailure(exception: e));
    }
  }
}
