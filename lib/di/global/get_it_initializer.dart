import 'package:ecoparking_management/data/datasource/account_datasource.dart';
import 'package:ecoparking_management/data/datasource/analysis_datasource.dart';
import 'package:ecoparking_management/data/datasource/employee_datasource.dart';
import 'package:ecoparking_management/data/datasource/ticket_datasource.dart';
import 'package:ecoparking_management/data/datasource_impl/account_datasource_impl.dart';
import 'package:ecoparking_management/data/datasource_impl/analysis_datasource_impl.dart';
import 'package:ecoparking_management/data/datasource_impl/employee_datasource_impl.dart';
import 'package:ecoparking_management/data/datasource_impl/ticket_datasource_impl.dart';
import 'package:ecoparking_management/data/repository/account_repository_impl.dart';
import 'package:ecoparking_management/data/repository/analysis_repository_impl.dart';
import 'package:ecoparking_management/data/repository/employee_repository_impl.dart';
import 'package:ecoparking_management/data/repository/ticket_repository_impl.dart';
import 'package:ecoparking_management/domain/repository/account_repository.dart';
import 'package:ecoparking_management/domain/repository/analysis_repository.dart';
import 'package:ecoparking_management/domain/repository/employee_repository.dart';
import 'package:ecoparking_management/domain/repository/ticket_repository.dart';
import 'package:ecoparking_management/domain/services/profile_service.dart';
import 'package:ecoparking_management/domain/usecase/account/get_employee_info_interactor.dart';
import 'package:ecoparking_management/domain/usecase/account/get_owner_info_interactor.dart';
import 'package:ecoparking_management/domain/usecase/account/get_user_profile_interactor.dart';
import 'package:ecoparking_management/domain/usecase/account/sign_in_interactor.dart';
import 'package:ecoparking_management/domain/usecase/account/sign_out_interactor.dart';
import 'package:ecoparking_management/domain/usecase/account/update_employee_currency_locale_interactor.dart';
import 'package:ecoparking_management/domain/usecase/account/update_owner_currency_locale_interactor.dart';
import 'package:ecoparking_management/domain/usecase/account/update_user_profile_interactor.dart';
import 'package:ecoparking_management/domain/usecase/analysis/export_data_interactor.dart';
import 'package:ecoparking_management/domain/usecase/analysis/get_current_employee_interactor.dart';
import 'package:ecoparking_management/domain/usecase/analysis/get_last_12_months_ticket_count_interactor.dart';
import 'package:ecoparking_management/domain/usecase/analysis/get_last_12_months_total_interactor.dart';
import 'package:ecoparking_management/domain/usecase/analysis/get_last_month_ticket_count_interactor.dart';
import 'package:ecoparking_management/domain/usecase/analysis/get_last_month_total_interactor.dart';
import 'package:ecoparking_management/domain/usecase/analysis/get_last_year_ticket_count_interactor.dart';
import 'package:ecoparking_management/domain/usecase/analysis/get_last_year_total_interactor.dart';
import 'package:ecoparking_management/domain/usecase/analysis/get_parking_info_interactor.dart';
import 'package:ecoparking_management/domain/usecase/analysis/get_ticket_interactor.dart';
import 'package:ecoparking_management/domain/usecase/analysis/get_yesterday_ticket_count_interactor.dart';
import 'package:ecoparking_management/domain/usecase/analysis/get_yesterday_total_interactor.dart';
import 'package:ecoparking_management/domain/usecase/analysis/update_parking_slot_interactor.dart';
import 'package:ecoparking_management/domain/usecase/employee/check_in_interactor.dart';
import 'package:ecoparking_management/domain/usecase/employee/check_out_interactor.dart';
import 'package:ecoparking_management/domain/usecase/employee/create_new_employee_interactor.dart';
import 'package:ecoparking_management/domain/usecase/employee/delete_employee_interactor.dart';
import 'package:ecoparking_management/domain/usecase/employee/get_all_employee_interactor.dart';
import 'package:ecoparking_management/domain/usecase/employee/get_employee_attendance_interactor.dart';
import 'package:ecoparking_management/domain/usecase/employee/get_employee_attendance_status_interactor.dart';
import 'package:ecoparking_management/domain/usecase/employee/save_attendance_to_xlsx_interactor.dart';
import 'package:ecoparking_management/domain/usecase/employee/save_employee_to_xlsx_interactor.dart';
import 'package:ecoparking_management/domain/usecase/employee/search_employee_interactor.dart';
import 'package:ecoparking_management/domain/usecase/employee/update_employee_working_time_interactor.dart';
import 'package:ecoparking_management/domain/usecase/ticket/scan_ticket_interactor.dart';
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
    getIt.registerFactory<EmployeeDataSource>(
      () => EmployeeDataSourceImpl(),
    );
    getIt.registerFactory<AnalysisDataSource>(
      () => AnalysisDataSourceImpl(),
    );
    getIt.registerFactory<TicketDataSource>(
      () => TicketDataSourceImpl(),
    );
    loggy.info('_bindingDataSource(): Setup successfully');
  }

  void _bindingDataSourceImpl() {
    getIt.registerFactory<AccountDataSourceImpl>(
      () => AccountDataSourceImpl(),
    );
    getIt.registerFactory<EmployeeDataSourceImpl>(
      () => EmployeeDataSourceImpl(),
    );
    getIt.registerFactory<AnalysisDataSourceImpl>(
      () => AnalysisDataSourceImpl(),
    );
    getIt.registerFactory<TicketDataSourceImpl>(
      () => TicketDataSourceImpl(),
    );
    loggy.info('_bindingDataSourceImpl(): Setup successfully');
  }

  void _bindingRepository() {
    getIt.registerLazySingleton<AccountRepository>(
      () => AccountRepositoryImpl(),
    );
    getIt.registerLazySingleton<EmployeeRepository>(
      () => EmployeeRepositoryImpl(),
    );
    getIt.registerLazySingleton<AnalysisRepository>(
      () => AnalysisRepositoryImpl(),
    );
    getIt.registerLazySingleton<TicketRepository>(
      () => TicketRepositoryImpl(),
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
    getIt.registerLazySingleton<GetAllEmployeeInteractor>(
      () => GetAllEmployeeInteractor(),
    );
    getIt.registerLazySingleton<UpdateEmployeeWorkingTimeInteractor>(
      () => UpdateEmployeeWorkingTimeInteractor(),
    );
    getIt.registerLazySingleton<CreateNewEmployeeInteractor>(
      () => CreateNewEmployeeInteractor(),
    );
    getIt.registerLazySingleton<DeleteEmployeeInteractor>(
      () => DeleteEmployeeInteractor(),
    );
    getIt.registerLazySingleton<SaveEmployeeToXlsxInteractor>(
      () => SaveEmployeeToXlsxInteractor(),
    );
    getIt.registerLazySingleton<SearchEmployeeInteractor>(
      () => SearchEmployeeInteractor(),
    );
    getIt.registerLazySingleton<GetLast12MonthsTotalInteractor>(
      () => GetLast12MonthsTotalInteractor(),
    );
    getIt.registerLazySingleton<GetYesterdayTotalInteractor>(
      () => GetYesterdayTotalInteractor(),
    );
    getIt.registerLazySingleton<GetLastMonthTotalInteractor>(
      () => GetLastMonthTotalInteractor(),
    );
    getIt.registerLazySingleton<GetLastYearTotalInteractor>(
      () => GetLastYearTotalInteractor(),
    );
    getIt.registerLazySingleton<GetLast12MonthsTicketCountInteractor>(
      () => GetLast12MonthsTicketCountInteractor(),
    );
    getIt.registerLazySingleton<GetYesterdayTicketCountInteractor>(
      () => GetYesterdayTicketCountInteractor(),
    );
    getIt.registerLazySingleton<GetLastMonthTicketCountInteractor>(
      () => GetLastMonthTicketCountInteractor(),
    );
    getIt.registerLazySingleton<GetLastYearTicketCountInteractor>(
      () => GetLastYearTicketCountInteractor(),
    );
    getIt.registerLazySingleton<ExportDataInteractor>(
      () => ExportDataInteractor(),
    );
    getIt.registerLazySingleton<GetParkingInfoInteractor>(
      () => GetParkingInfoInteractor(),
    );
    getIt.registerLazySingleton<GetCurrentEmployeeInteractor>(
      () => GetCurrentEmployeeInteractor(),
    );
    getIt.registerLazySingleton<GetTicketInteractor>(
      () => GetTicketInteractor(),
    );
    getIt.registerLazySingleton<ScanTicketInteractor>(
      () => ScanTicketInteractor(),
    );
    getIt.registerLazySingleton<GetEmployeeAttendanceInteractor>(
      () => GetEmployeeAttendanceInteractor(),
    );
    getIt.registerLazySingleton<CheckInInteractor>(
      () => CheckInInteractor(),
    );
    getIt.registerLazySingleton<CheckOutInteractor>(
      () => CheckOutInteractor(),
    );
    getIt.registerLazySingleton<GetEmployeeAttendanceStatusInteractor>(
      () => GetEmployeeAttendanceStatusInteractor(),
    );
    getIt.registerLazySingleton<SaveAttendanceToXlsxInteractor>(
      () => SaveAttendanceToXlsxInteractor(),
    );
    getIt.registerLazySingleton<UpdateParkingSlotInteractor>(
      () => UpdateParkingSlotInteractor(),
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
