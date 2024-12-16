import 'package:ecoparking_management/pages/scanner/scanner.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerError extends StatelessWidget {
  final MobileScannerException exception;
  final ScannerController controller;

  const ScannerError({
    super.key,
    required this.exception,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Icon(
                Icons.error_outline_rounded,
                color: Colors.white,
              ),
            ),
            Text(
              controller.getErrorMessage(exception),
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.white,
                  ),
            ),
            Text(
              exception.errorDetails?.message ?? '',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
