import 'package:ecoparking_management/pages/live_overview/live_overview_view.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LiveOverview extends StatefulWidget {
  const LiveOverview({super.key});

  @override
  LiveOverviewController createState() => LiveOverviewController();
}

class LiveOverviewController extends State<LiveOverview> with ControllerLoggy {
  final format = NumberFormat.simpleCurrency(locale: 'vi_VN');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LiveOverviewView(controller: this);
}
