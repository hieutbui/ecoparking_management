import 'package:ecoparking_management/pages/previous_analysis/previous_analysis.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:flutter/material.dart';

class PreviousAnalysisView extends StatelessWidget with ViewLoggy {
  final PreviousAnalysisController controller;

  const PreviousAnalysisView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Previous Analysis',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
