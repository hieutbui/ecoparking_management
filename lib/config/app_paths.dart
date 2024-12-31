import 'package:flutter/material.dart';

enum AppPaths {
  employee,
  liveOverview,
  previousAnalysis,
  profile,
  exceptionScreen,
  login,
  scanner;

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
      case AppPaths.scanner:
        return '/scanner';
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
      case AppPaths.scanner:
        return '/scanner';
      default:
        return '/exception-screen';
    }
  }

  String get label {
    switch (this) {
      case AppPaths.employee:
        return 'Nhân viên';
      case AppPaths.liveOverview:
        return 'Hiện tại';
      case AppPaths.previousAnalysis:
        return 'Thống kê';
      case AppPaths.profile:
        return 'Hồ sơ';
      case AppPaths.exceptionScreen:
        return 'Lỗi';
      case AppPaths.login:
        return 'Đăng nhập';
      case AppPaths.scanner:
        return 'Quét mã';
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
      case AppPaths.scanner:
        return Icons.qr_code_rounded;
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
