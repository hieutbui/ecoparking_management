import 'package:ecoparking_management/config/app_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationUtils {
  static void navigateTo({
    required BuildContext context,
    required AppPaths path,
    Object? extra,
  }) {
    GoRouter.of(context).go(path.navigationPath, extra: extra);
  }

  static void replaceTo({
    required BuildContext context,
    required AppPaths path,
    Object? params,
  }) {
    GoRouter.of(context).replace(path.navigationPath, extra: params);
  }

  static void goBack(BuildContext context) {
    if (GoRouter.of(context).canPop()) {
      GoRouter.of(context).pop();
    } else {
      GoRouter.of(context).go(AppPaths.liveOverview.path);
    }
  }
}
