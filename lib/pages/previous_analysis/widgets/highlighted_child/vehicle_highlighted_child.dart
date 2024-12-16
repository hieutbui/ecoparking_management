import 'package:ecoparking_management/pages/previous_analysis/previous_analysis.dart';
import 'package:flutter/material.dart';

class VehicleHighlightedChild extends StatelessWidget {
  final PreviousAnalysisController controller;

  const VehicleHighlightedChild({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.totalVehicleCount,
      builder: (context, total, child) {
        return Text(
          controller.getFormattedNumber(
            total,
            controller.getCurrencyLocale(),
          ),
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        );
      },
    );
  }
}
