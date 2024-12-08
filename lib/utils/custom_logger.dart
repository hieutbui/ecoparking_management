import 'package:loggy/loggy.dart';

mixin ControllerLoggy implements LoggyType {
  @override
  Loggy<ControllerLoggy> get loggy =>
      Loggy<ControllerLoggy>('Controller Loggy - $runtimeType');
}

mixin GetItLoggy implements LoggyType {
  @override
  Loggy<GetItLoggy> get loggy =>
      Loggy<GetItLoggy>('GetIt Loggy - $runtimeType');
}

mixin InteractorLoggy implements LoggyType {
  @override
  Loggy<InteractorLoggy> get loggy =>
      Loggy<InteractorLoggy>('Interactor Loggy - $runtimeType');
}

mixin ServiceLoggy implements LoggyType {
  @override
  Loggy<ServiceLoggy> get loggy =>
      Loggy<ServiceLoggy>('Service Loggy - $runtimeType');
}
