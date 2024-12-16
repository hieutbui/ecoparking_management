import 'package:dartz/dartz.dart';
import 'package:ecoparking_management/data/models/ticket_info.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/analysis_repository.dart';
import 'package:ecoparking_management/domain/state/analysis/get_ticket_state.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';

class GetTicketInteractor with InteractorLoggy {
  final AnalysisRepository _analysisRepository =
      getIt.get<AnalysisRepository>();

  Stream<Either<Failure, Success>> execute({
    required String parkingId,
  }) async* {
    try {
      yield const Right(GetTicketLoading());

      final result = await _analysisRepository.getTicket(parkingId: parkingId);

      if (result.isEmpty) {
        yield const Right(GetTicketEmpty());
      } else {
        final tickets = result.map((e) => TicketInfo.fromJson(e)).toList();
        yield Right(GetTicketSuccess(tickets: tickets));
      }
    } catch (e) {
      yield Left(GetTicketFailure(exception: e));
    }
  }
}
