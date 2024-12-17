import 'package:dartz/dartz.dart';
import 'package:ecoparking_management/data/models/qr_data.dart';
import 'package:ecoparking_management/data/models/ticket_info.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/ticket_repository.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/domain/state/ticket/scan_ticket_state.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';

class ScanTicketInteractor with InteractorLoggy {
  final TicketRepository _repository = getIt.get<TicketRepository>();

  Stream<Either<Failure, Success>> execute({
    required String ticketId,
    required QrTimeType timeType,
    required String parkingId,
  }) async* {
    try {
      yield const Right(ScanTicketLoading());

      final ticketInfo = await _repository.scanTicket(
        ticketId: ticketId,
        timeType: timeType,
        parkingId: parkingId,
      );

      if (ticketInfo.isEmpty) {
        yield const Left(ScanTicketEmpty());
      }

      yield Right(
        ScanTicketSuccess(ticketInfo: TicketInfo.fromJson(ticketInfo)),
      );
    } catch (e) {
      yield Left(ScanTicketFailure(exception: e));
    }
  }
}
