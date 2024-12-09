import 'package:ecoparking_management/pages/exception_screen/exception_screen.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:flutter/material.dart';

class ExceptionScreenView extends StatelessWidget with ViewLoggy {
  final ExceptionScreenController controller;

  const ExceptionScreenView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Exception Screen',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
