import 'package:ecoparking_management/pages/previous_analysis/previous_analysis.dart';
import 'package:flutter/material.dart';

class RevenueHighlightedChild extends StatelessWidget {
  final PreviousAnalysisController controller;

  const RevenueHighlightedChild({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.totalRevenue,
      builder: (context, total, child) {
        return Text(
          controller.getFormattedCurrency(
            total,
            controller.dummyLocale,
          ),
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        );
      },
    );
  }
}
