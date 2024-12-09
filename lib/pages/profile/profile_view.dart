import 'package:ecoparking_management/pages/profile/profile.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget with ViewLoggy {
  final ProfileController controller;

  const ProfileView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
