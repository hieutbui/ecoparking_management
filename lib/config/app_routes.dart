import 'dart:async';
import 'package:ecoparking_management/config/app_paths.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/services/profile_service.dart';
import 'package:ecoparking_management/pages/employee_management/employee_management.dart';
import 'package:ecoparking_management/pages/exception_screen/exception_screen.dart';
import 'package:ecoparking_management/pages/live_overview/live_overview.dart';
import 'package:ecoparking_management/pages/login/login.dart';
import 'package:ecoparking_management/pages/previous_analysis/previous_analysis.dart';
import 'package:ecoparking_management/pages/profile/profile.dart';
import 'package:ecoparking_management/utils/responsive.dart';
import 'package:ecoparking_management/widgets/app_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static final routeChangeNotifier = RouteChangeNotifier();
  static final _responsive = getIt.get<ResponsiveUtils>();
  static final _profileService = getIt.get<ProfileService>();

  static GoRouter get router => GoRouter(
        initialLocation: AppPaths.login.path,
        debugLogDiagnostics: true,
        navigatorKey: _rootNavigatorKey,
        refreshListenable: routeChangeNotifier,
        routes: <RouteBase>[
          ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: _routerBuilder,
            redirect: _routerRedirect,
            routes: _listRoutes,
          ),
        ],
        onException: _onRouteException,
      );

  static GlobalKey<NavigatorState> get _rootNavigatorKey =>
      GlobalKey<NavigatorState>(debugLabel: 'Root Navigator');
  static GlobalKey<NavigatorState> get _shellNavigatorKey =>
      GlobalKey<NavigatorState>(debugLabel: 'Shell Navigator');

  static List<RouteBase> get _listRoutes => <RouteBase>[
        GoRoute(
          path: AppPaths.login.path,
          pageBuilder: (context, state) => _defaultPageBuilder(
            context,
            const Login(),
            name: AppPaths.login.name,
          ),
          redirect: (context, state) => _profileService.isAuthenticated
              ? AppPaths.liveOverview.path
              : null,
        ),
        GoRoute(
          path: AppPaths.liveOverview.path,
          pageBuilder: (context, state) => _defaultPageBuilder(
            context,
            const LiveOverview(),
            name: AppPaths.liveOverview.name,
          ),
        ),
        GoRoute(
          path: AppPaths.previousAnalysis.path,
          pageBuilder: (context, state) => _defaultPageBuilder(
            context,
            const PreviousAnalysis(),
            name: AppPaths.previousAnalysis.name,
          ),
        ),
        GoRoute(
          path: AppPaths.employee.path,
          pageBuilder: (context, state) => _defaultPageBuilder(
            context,
            const EmployeeManagement(),
            name: AppPaths.employee.name,
          ),
        ),
        GoRoute(
          path: AppPaths.profile.path,
          pageBuilder: (context, state) => _defaultPageBuilder(
            context,
            const Profile(),
            name: AppPaths.profile.name,
          ),
        ),
        GoRoute(
          path: AppPaths.exceptionScreen.path,
          pageBuilder: (context, state) => _defaultPageBuilder(
            context,
            const ExceptionScreen(),
            name: AppPaths.exceptionScreen.name,
          ),
        ),
      ];

  static List<String> get _listFullScreenPages => [
        AppPaths.login.path,
      ];

  static List<String> get _listScreenRequiredLogin => [
        AppPaths.liveOverview.path,
        AppPaths.previousAnalysis.path,
        AppPaths.employee.path,
        AppPaths.profile.path,
      ];

  static Map<String, int> get navBarPathToIndex => {
        AppPaths.liveOverview.path: 0,
        AppPaths.previousAnalysis.path: 1,
        AppPaths.employee.path: 2,
        AppPaths.profile.path: 3,
      };
  static Map<int, AppPaths> get navBarIndexToPath => {
        0: AppPaths.liveOverview,
        1: AppPaths.previousAnalysis,
        2: AppPaths.employee,
        3: AppPaths.profile,
      };

  static Page _defaultPageBuilder(
    BuildContext context,
    Widget child, {
    String? name,
  }) =>
      CustomTransitionPage(
        name: name,
        child: child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            !_responsive.isMobile(context)
                ? FadeTransition(
                    opacity: animation,
                    child: child,
                  )
                : CupertinoPageTransition(
                    primaryRouteAnimation: animation,
                    secondaryRouteAnimation: secondaryAnimation,
                    linearTransition: false,
                    child: child,
                  ),
      );

  static Widget _routerBuilder(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    final currentPath = state.uri.path.trim();

    final isFullScreen = _listFullScreenPages.any(
      (path) => path.trim() == currentPath,
    );

    if (isFullScreen) {
      return child;
    }

    return AppLayout(child: child);
  }

  static FutureOr<String?> _routerRedirect(
    BuildContext context,
    GoRouterState state,
  ) {
    final currentPath = state.uri.path.trim();

    final isRequiredLogin = _listScreenRequiredLogin.any(
      (path) => path.trim() == currentPath,
    );

    if (isRequiredLogin) {
      if (!_profileService.isAuthenticated) {
        return AppPaths.login.path;
      }
    }

    return null;
  }

  static void _onRouteException(
    BuildContext context,
    GoRouterState state,
    GoRouter router,
  ) {
    router.go(AppPaths.exceptionScreen.path);
  }

  static List<NavigationDestination> navDestinations(BuildContext context) =>
      <NavigationDestination>[
        NavigationDestination(
          icon: _renderNavIcon(
            AppPaths.liveOverview,
            false,
          ),
          selectedIcon: _renderNavIcon(
            AppPaths.liveOverview,
            true,
          ),
          label: AppPaths.liveOverview.label,
        ),
        NavigationDestination(
          icon: _renderNavIcon(
            AppPaths.previousAnalysis,
            false,
          ),
          selectedIcon: _renderNavIcon(
            AppPaths.previousAnalysis,
            true,
          ),
          label: AppPaths.previousAnalysis.label,
        ),
        NavigationDestination(
          icon: _renderNavIcon(
            AppPaths.employee,
            false,
          ),
          selectedIcon: _renderNavIcon(
            AppPaths.employee,
            true,
          ),
          label: AppPaths.employee.label,
        ),
        NavigationDestination(
          icon: _renderNavIcon(
            AppPaths.profile,
            false,
          ),
          selectedIcon: _renderNavIcon(
            AppPaths.profile,
            true,
          ),
          label: AppPaths.profile.label,
        ),
      ];

  static Widget _renderNavIcon(
    AppPaths path,
    bool isSelected,
  ) {
    const selectedColor = Colors.white;
    const unselectedColor = Color(0xFF9197B3);

    return Icon(
      isSelected ? path.selectedIcon : path.unselectedIcon,
      color: isSelected ? selectedColor : unselectedColor,
    );
  }

  static List<NavigationRailDestination> railDestinations(
    BuildContext context,
  ) =>
      navDestinations(context)
          .map((destination) => AdaptiveScaffold.toRailDestination(destination))
          .toList();
}

class RouteChangeNotifier extends ChangeNotifier {
  void notify() {
    notifyListeners();
  }
}
