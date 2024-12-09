import 'package:ecoparking_management/pages/live_overview/live_overview.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:flutter/material.dart';

class LiveOverviewView extends StatelessWidget with ViewLoggy {
  final LiveOverviewController controller;

  const LiveOverviewView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Live Overview',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
