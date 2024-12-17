import 'dart:async';
import 'package:dartz/dartz.dart' hide State;
import 'package:ecoparking_management/config/app_paths.dart';
import 'package:ecoparking_management/data/models/qr_data.dart';
import 'package:ecoparking_management/data/models/user_profile.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/services/profile_service.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/domain/state/ticket/scan_ticket_state.dart';
import 'package:ecoparking_management/domain/usecase/ticket/scan_ticket_interactor.dart';
import 'package:ecoparking_management/pages/scanner/scanner_view.dart';
import 'package:ecoparking_management/utils/dialog_utils.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:ecoparking_management/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  ScannerController createState() => ScannerController();
}

class ScannerController extends State<Scanner>
    with ControllerLoggy, WidgetsBindingObserver {
  final ProfileService _profileService = getIt.get<ProfileService>();

  final ScanTicketInteractor _scanTicketInteractor =
      getIt.get<ScanTicketInteractor>();

  final ValueNotifier<ScanTicketState> scanTicketState =
      ValueNotifier(const ScanTicketInitial());

  final MobileScannerController mobileScannerController =
      MobileScannerController();

  StreamSubscription<Object>? _scannerSubscription;
  StreamSubscription<Either<Failure, Success>>? _scanTicketSubscription;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!mobileScannerController.value.hasCameraPermission) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        _startScanner();
      case AppLifecycleState.inactive:
        unawaited(_scannerSubscription?.cancel());
        _scannerSubscription = null;
        unawaited(mobileScannerController.stop());
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startScanner();
  }

  @override
  void dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    _disposeSubscriptions();
    _disposeNotifiers();
    super.dispose();
    await mobileScannerController.dispose();
  }

  void _disposeNotifiers() {
    scanTicketState.dispose();
  }

  void _disposeSubscriptions() {
    _scannerSubscription?.cancel();
    _scanTicketSubscription?.cancel();
    _scannerSubscription = null;
    _scanTicketSubscription = null;
  }

  void _startScanner() {
    _scannerSubscription = mobileScannerController.barcodes.listen(
      _handleScanner,
    );
    unawaited(mobileScannerController.start());
  }

  String getErrorMessage(MobileScannerException exception) {
    switch (exception.errorCode) {
      case MobileScannerErrorCode.controllerUninitialized:
        return 'Controller not ready.';
      case MobileScannerErrorCode.permissionDenied:
        return 'Permission denied';
      case MobileScannerErrorCode.unsupported:
        return 'Scanning is unsupported on this device';
      default:
        return 'Generic Error';
    }
  }

  void _handleScanner(BarcodeCapture scanned) async {
    loggy.info('Scanned: $scanned');
  }

  Future<String?> _getParkingId() async {
    final profile = _profileService.userProfile;

    if (profile == null || !_profileService.isAuthenticated) {
      await _showRequiredLogin();

      return null;
    }

    if (profile.accountType == AccountType.employee) {
      final parkingEmployee = _profileService.parkingEmployee;

      if (parkingEmployee == null) {
        await _showRequiredLogin();

        return null;
      } else {
        return parkingEmployee.parkingId;
      }
    } else if (profile.accountType == AccountType.parkingOwner) {
      final parkingOwner = _profileService.parkingOwner;

      if (parkingOwner == null) {
        await _showRequiredLogin();

        return null;
      } else {
        return parkingOwner.parkingId;
      }
    }

    return null;
  }

  Future<void> _showRequiredLogin() async {
    await DialogUtils.showRequiredLogin(context);
    _navigateToLogin();
  }

  void _navigateToLogin() {
    if (mounted) {
      NavigationUtils.navigateTo(
        context: context,
        path: AppPaths.login,
      );
    }
  }

  void scanTicket(QrData ticketData) async {
    final parkingId = await _getParkingId();

    if (parkingId == null) {
      return;
    }

    _scanTicketSubscription = _scanTicketInteractor
        .execute(
          ticketId: ticketData.ticketId,
          timeType: ticketData.timeType,
          parkingId: parkingId,
        )
        .listen(
          (result) => result.fold(
            _handleScanTicketFailure,
            _handleScanTicketSuccess,
          ),
        );
  }

  void _handleScanTicketFailure(Failure failure) {
    if (failure is ScanTicketFailure) {
      loggy.error('Failed to update ticket: ${failure.exception}');
      scanTicketState.value = failure;
    } else if (failure is ScanTicketEmpty) {
      loggy.error('Ticket is empty');
      scanTicketState.value = failure;
    } else {
      loggy.error('Unknown failure: $failure');
      scanTicketState.value = ScanTicketFailure(exception: failure);
    }
  }

  void _handleScanTicketSuccess(Success success) {
    if (success is ScanTicketSuccess) {
      scanTicketState.value = success;
    } else if (success is ScanTicketLoading) {
      scanTicketState.value = success;
    }
  }

  @override
  Widget build(BuildContext context) => ScannerView(controller: this);
}
