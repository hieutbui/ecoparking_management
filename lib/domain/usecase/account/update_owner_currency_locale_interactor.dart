import 'package:dartz/dartz.dart';
import 'package:ecoparking_management/data/models/parking_owner.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/repository/account_repository.dart';
import 'package:ecoparking_management/domain/state/account/update_owner_currency_locale_state.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';

class UpdateOwnerCurrencyLocaleInteractor with InteractorLoggy {
  final AccountRepository _repository = getIt.get<AccountRepository>();

  Stream<Either<Failure, Success>> execute({
    required String ownerId,
    required String currencyLocale,
  }) async* {
    try {
      yield const Right(UpdateOwnerCurrencyLocaleLoading());

      final result = await _repository.updateOwnerCurrencyLocale(
        ownerId: ownerId,
        currencyLocale: currencyLocale,
      );

      if (result.isEmpty) {
        yield const Left(UpdateOwnerCurrencyLocaleEmpty());
      }

      yield Right(
        UpdateOwnerCurrencyLocaleSuccess(
          owner: ParkingOwner.fromJson(result),
        ),
      );
    } catch (e) {
      loggy.error(e);
      yield Left(UpdateOwnerCurrencyLocaleFailure(exception: e));
    }
  }
}
