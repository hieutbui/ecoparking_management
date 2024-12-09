import 'package:ecoparking_management/pages/previous_analysis/previous_analysis_view.dart';
import 'package:flutter/material.dart';

class PreviousAnalysis extends StatefulWidget {
  const PreviousAnalysis({super.key});

  @override
  PreviousAnalysisController createState() => PreviousAnalysisController();
}

class PreviousAnalysisController extends State<PreviousAnalysis> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PreviousAnalysisView(controller: this);
}
