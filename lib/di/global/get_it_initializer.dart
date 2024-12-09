import 'package:ecoparking_management/utils/custom_logger.dart';
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
    loggy.info('_bindingDataSource(): Setup successfully');
  }

  void _bindingDataSourceImpl() {
    loggy.info('_bindingDataSourceImpl(): Setup successfully');
  }

  void _bindingRepository() {
    loggy.info('_bindingRepository(): Setup successfully');
  }

  void _bindingInteractor() {
    loggy.info('_bindingInteractor(): Setup successfully');
  }

  void _bindingServices() {
    loggy.info('_bindingServices(): Setup successfully');
  }

  void _bindingController() {
    loggy.info('_bindingController(): Setup successfully');
  }
}
