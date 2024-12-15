import 'package:dartz/dartz.dart';
import 'package:ecoparking_management/data/models/analysis_data.dart';
import 'package:ecoparking_management/data/models/export_data_status.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/analysis_repository.dart';
import 'package:ecoparking_management/domain/state/analysis/export_data_state.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';

class ExportDataInteractor with InteractorLoggy {
  final AnalysisRepository _repository = getIt.get<AnalysisRepository>();

  Stream<Either<Failure, Success>> execute({
    required List<String> listTitles,
    required List<AnalysisData> listDatas,
  }) async* {
    try {
      yield const Right(ExportDataLoading());

      final Map<String, dynamic> result = await _repository.exportData(
        listTitles: listTitles,
        listDatas: listDatas,
      );

      if (result.isEmpty) {
        yield const Left(ExportDataFailure(exception: 'Empty result'));

        return;
      }

      final status = ExportDataStatus.fromJson(result);

      if (status.status == ExportDataStatusEnum.success) {
        yield Right(ExportDataSuccess(status: status));
      } else {
        yield const Left(ExportDataFailure(exception: 'Failed to export'));
      }
    } catch (e) {
      yield Left(ExportDataFailure(exception: e));
    }
  }
}
