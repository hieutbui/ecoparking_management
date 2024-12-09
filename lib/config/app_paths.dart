import 'package:flutter/material.dart';

enum AppPaths {
  employee,
  liveOverview,
  previousAnalysis,
  profile,
  exceptionScreen,
  login;

  String get path {
    switch (this) {
      case AppPaths.employee:
        return '/employee';
      case AppPaths.liveOverview:
        return '/live-overview';
      case AppPaths.previousAnalysis:
        return '/previous-analysis';
      case AppPaths.profile:
        return '/profile';
      case AppPaths.exceptionScreen:
        return '/exception-screen';
      case AppPaths.login:
        return '/login';
      default:
        return '/exception-screen';
    }
  }

  String get navigationPath {
    switch (this) {
      case AppPaths.employee:
        return '/employee';
      case AppPaths.liveOverview:
        return '/live-overview';
      case AppPaths.previousAnalysis:
        return '/previous-analysis';
      case AppPaths.profile:
        return '/profile';
      case AppPaths.exceptionScreen:
        return '/exception-screen';
      case AppPaths.login:
        return '/login';
      default:
        return '/exception-screen';
    }
  }

  String get label {
    switch (this) {
      case AppPaths.employee:
        return 'Employee';
      case AppPaths.liveOverview:
        return 'Live';
      case AppPaths.previousAnalysis:
        return 'Previous';
      case AppPaths.profile:
        return 'Profile';
      case AppPaths.exceptionScreen:
        return 'Error';
      case AppPaths.login:
        return 'Login';
      default:
        return 'Error';
    }
  }

  IconData get selectedIcon {
    switch (this) {
      case AppPaths.employee:
        return Icons.people_alt_rounded;
      case AppPaths.liveOverview:
        return Icons.pie_chart_rounded;
      case AppPaths.previousAnalysis:
        return Icons.bar_chart_rounded;
      case AppPaths.profile:
        return Icons.person_rounded;
      case AppPaths.exceptionScreen:
        return Icons.error_rounded;
      case AppPaths.login:
        return Icons.login_rounded;
      default:
        return Icons.error_rounded;
    }
  }

  IconData get unselectedIcon {
    switch (this) {
      case AppPaths.employee:
        return Icons.people_alt_outlined;
      case AppPaths.liveOverview:
        return Icons.pie_chart_outline;
      case AppPaths.previousAnalysis:
        return Icons.bar_chart_outlined;
      case AppPaths.profile:
        return Icons.person_outline;
      case AppPaths.exceptionScreen:
        return Icons.error_outline;
      case AppPaths.login:
        return Icons.login_outlined;
      default:
        return Icons.error_outline;
    }
  }
}
