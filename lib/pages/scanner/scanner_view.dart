import 'package:ecoparking_management/config/app_paths.dart';
import 'package:ecoparking_management/pages/scanner/scanner.dart';
import 'package:ecoparking_management/pages/scanner/widgets/scanner_bar_code_label.dart';
import 'package:ecoparking_management/pages/scanner/widgets/scanner_error.dart';
import 'package:ecoparking_management/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerView extends StatelessWidget {
  final ScannerController controller;

  const ScannerView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppPaths.scanner.label,
      body: Stack(
        children: <Widget>[
          MobileScanner(
            controller: controller.mobileScannerController,
            fit: BoxFit.contain,
            errorBuilder: (context, error, child) =>
                ScannerError(exception: error, controller: controller),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 100,
              color: Colors.black.withOpacity(0.4),
              child: Center(
                child: ScannerBarCodeLabel(
                  controller: controller,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
