import 'dart:async';
import 'package:ecoparking_management/pages/scanner/scanner_view.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  ScannerController createState() => ScannerController();
}

class ScannerController extends State<Scanner>
    with ControllerLoggy, WidgetsBindingObserver {
  final MobileScannerController mobileScannerController =
      MobileScannerController();

  StreamSubscription<Object>? _scannerSubscription;

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
    super.dispose();
    await mobileScannerController.dispose();
  }

  void _disposeSubscriptions() {
    _scannerSubscription?.cancel();
    _scannerSubscription = null;
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

  void _handleScanner(BarcodeCapture scanned) {
    loggy.info('Scanned: $scanned');
  }

  @override
  Widget build(BuildContext context) => ScannerView(controller: this);
}
