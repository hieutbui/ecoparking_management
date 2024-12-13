import 'package:ecoparking_management/data/datasource/account_datasource.dart';
import 'package:ecoparking_management/data/datasource_impl/account_datasource_impl.dart';
import 'package:ecoparking_management/data/repository/account_repository_impl.dart';
import 'package:ecoparking_management/domain/repository/account_repository.dart';
import 'package:ecoparking_management/domain/services/profile_service.dart';
import 'package:ecoparking_management/domain/usecase/account/get_employee_info_interactor.dart';
import 'package:ecoparking_management/domain/usecase/account/get_owner_info_interactor.dart';
import 'package:ecoparking_management/domain/usecase/account/get_user_profile_interactor.dart';
import 'package:ecoparking_management/domain/usecase/account/sign_in_interactor.dart';
import 'package:ecoparking_management/domain/usecase/account/sign_out_interactor.dart';
import 'package:ecoparking_management/domain/usecase/account/update_employee_currency_locale_interactor.dart';
import 'package:ecoparking_management/domain/usecase/account/update_owner_currency_locale_interactor.dart';
import 'package:ecoparking_management/domain/usecase/account/update_user_profile_interactor.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:ecoparking_management/utils/responsive.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class GetItInitializer with GetItLoggy {
  static final GetItInitializer _singleton = GetItInitializer._internal();

  factory GetItInitializer() {
    return _singleton;
  }

  GetItInitializer._internal();

  void setup() {
    _bindingGlobal();
    _bindingAPI();
    _bindingDataSource();
    _bindingDataSourceImpl();
    _bindingRepository();
    _bindingInteractor();
    _bindingServices();
    _bindingController();
    loggy.info('setUp(): Setup successfully');
  }

  void _bindingGlobal() {
    getIt.registerSingleton(ResponsiveUtils());
    loggy.info('_bindingGlobal(): Setup successfully');
  }

  void _bindingAPI() {
    loggy.info('_bindingAPI(): Setup successfully');
  }

  void _bindingDataSource() {
    getIt.registerFactory<AccountDataSource>(
      () => AccountDataSourceImpl(),
    );
    loggy.info('_bindingDataSource(): Setup successfully');
  }

  void _bindingDataSourceImpl() {
    getIt.registerFactory<AccountDataSourceImpl>(
      () => AccountDataSourceImpl(),
    );
    loggy.info('_bindingDataSourceImpl(): Setup successfully');
  }

  void _bindingRepository() {
    getIt.registerLazySingleton<AccountRepository>(
      () => AccountRepositoryImpl(),
    );
    loggy.info('_bindingRepository(): Setup successfully');
  }

  void _bindingInteractor() {
    getIt.registerLazySingleton<SignInInteractor>(
      () => SignInInteractor(),
    );
    getIt.registerLazySingleton<GetUserProfileInteractor>(
      () => GetUserProfileInteractor(),
    );
    getIt.registerLazySingleton<UpdateUserProfileInteractor>(
      () => UpdateUserProfileInteractor(),
    );
    getIt.registerLazySingleton<SignOutInteractor>(
      () => SignOutInteractor(),
    );
    getIt.registerLazySingleton<GetEmployeeInfoInteractor>(
      () => GetEmployeeInfoInteractor(),
    );
    getIt.registerLazySingleton<GetOwnerInfoInteractor>(
      () => GetOwnerInfoInteractor(),
    );
    getIt.registerLazySingleton<UpdateEmployeeCurrencyLocaleInteractor>(
      () => UpdateEmployeeCurrencyLocaleInteractor(),
    );
    getIt.registerLazySingleton<UpdateOwnerCurrencyLocaleInteractor>(
      () => UpdateOwnerCurrencyLocaleInteractor(),
    );
    loggy.info('_bindingInteractor(): Setup successfully');
  }

  void _bindingServices() {
    getIt.registerSingleton<ProfileService>(ProfileService());

    loggy.info('_bindingServices(): Setup successfully');
  }

  void _bindingController() {
    loggy.info('_bindingController(): Setup successfully');
  }
}
