import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerBarCodeLabel extends StatelessWidget {
  final Stream<BarcodeCapture> barcodes;

  const ScannerBarCodeLabel({
    super.key,
    required this.barcodes,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: barcodes,
      builder: (context, snapshot) {
        final scannedBarCodes = snapshot.data?.barcodes ?? [];

        if (scannedBarCodes.isEmpty) {
          return Text(
            'Scan something',
            overflow: TextOverflow.fade,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Colors.white,
                ),
          );
        }

        return Text(
          scannedBarCodes.first.displayValue ?? 'No display value',
          overflow: TextOverflow.fade,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Colors.white,
              ),
        );
      },
    );
  }
}
