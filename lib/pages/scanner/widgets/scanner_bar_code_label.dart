import 'dart:convert';
import 'package:ecoparking_management/data/models/qr_data.dart';
import 'package:ecoparking_management/domain/state/ticket/scan_ticket_state.dart';
import 'package:ecoparking_management/pages/scanner/scanner.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:flutter/material.dart';

class ScannerBarCodeLabel extends StatelessWidget with ViewLoggy {
  final ScannerController controller;

  const ScannerBarCodeLabel({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: controller.mobileScannerController.barcodes,
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

        final rawValue = scannedBarCodes.first.rawValue;

        if (rawValue == null) {
          loggy.error('Raw value is null');
          return Text(
            'Invalid ticket',
            overflow: TextOverflow.fade,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Colors.white,
                ),
          );
        }

        final json = jsonDecode(rawValue);

        final QrData qrData = QrData.fromJson(json);

        final now = DateTime.now();
        final qrTime = DateTime.fromMillisecondsSinceEpoch(qrData.timestamp);

        if (now.difference(qrTime).inSeconds > 60) {
          return Text(
            'Ticket expired. Please go back and navigate to ticket details',
            overflow: TextOverflow.fade,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Colors.white,
                ),
          );
        }

        controller.scanTicket(qrData);

        return ValueListenableBuilder(
          valueListenable: controller.scanTicketState,
          builder: (context, state, child) {
            if (state is ScanTicketFailure || state is ScanTicketEmpty) {
              return Text(
                'Cannot update ticket',
                overflow: TextOverflow.fade,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.white,
                    ),
              );
            }

            if (state is ScanTicketLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is ScanTicketSuccess) {
              final entryTime = state.ticketInfo.entryTime;
              final exitTime = state.ticketInfo.exitTime;

              if (entryTime == null && exitTime == null) {
                return Text(
                  'Cannot update ticket',
                  overflow: TextOverflow.fade,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.white,
                      ),
                );
              }

              return Text(
                'Ticket ID: ${state.ticketInfo.id}',
                overflow: TextOverflow.fade,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.white,
                    ),
              );
            }

            return child!;
          },
          child: const SizedBox.shrink(),
        );
      },
    );
  }
}
