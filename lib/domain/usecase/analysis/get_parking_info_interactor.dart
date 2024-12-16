import 'package:dartz/dartz.dart';
import 'package:ecoparking_management/data/models/parking_info.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/analysis_repository.dart';
import 'package:ecoparking_management/domain/state/analysis/get_parking_info_state.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';

class GetParkingInfoInteractor with InteractorLoggy {
  final AnalysisRepository _repository = getIt.get<AnalysisRepository>();

  Stream<Either<Failure, Success>> execute({
    required String parkingId,
  }) async* {
    try {
      yield const Right(GetParkingInfoLoading());

      final result = await _repository.getParkingInfo(parkingId: parkingId);

      if (result.isEmpty) {
        yield const Left(GetParkingInfoEmpty());
        return;
      }

      yield Right(
        GetParkingInfoSuccess(parkingInfo: ParkingInfo.fromJson(result)),
      );
    } catch (e) {
      yield Left(GetParkingInfoFailure(exception: e));
    }
  }
}
