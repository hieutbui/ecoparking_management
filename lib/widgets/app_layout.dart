import 'package:ecoparking_management/config/app_paths.dart';
import 'package:ecoparking_management/config/app_routes.dart';
import 'package:ecoparking_management/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';

class AppLayout extends StatelessWidget {
  final Widget child;

  const AppLayout({
    super.key,
    required this.child,
  });

  static const Key _primaryNavigationMediumKey = Key('Primary Navigation');
  static const Key _primaryNavigationMediumLargeKey =
      Key('Primary Navigation MediumLarge');
  static const Key _primaryNavigationLargeKey = Key('Primary Navigation Large');
  static const Key _primaryNavigationExtraLargeKey =
      Key('Primary Navigation ExtraLarge');
  static const Key _bodyStandardKey = Key('Body Standard');
  static const Key _bottomNavigationSmallKey = Key('Bottom Navigation Small');

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      primaryNavigation: _primaryNavigation,
      body: _body,
      bottomNavigation: _bottomNavigation,
    );
  }

  SlotLayout get _primaryNavigation => SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.medium: SlotLayout.from(
            key: _primaryNavigationMediumKey,
            inAnimation: AdaptiveScaffold.leftOutIn,
            builder: (mediumNavContext) =>
                AdaptiveScaffold.standardNavigationRail(
              selectedIndex: _calculateSelectedIndex(mediumNavContext),
              onDestinationSelected: (index) => _onNavDestinationSelected(
                mediumNavContext,
                index,
              ),
              destinations: AppRoutes.railDestinations(mediumNavContext),
              backgroundColor: Theme.of(mediumNavContext)
                  .navigationRailTheme
                  .backgroundColor,
              selectedIconTheme: Theme.of(mediumNavContext)
                  .navigationRailTheme
                  .selectedIconTheme,
              unselectedIconTheme: Theme.of(mediumNavContext)
                  .navigationRailTheme
                  .unselectedIconTheme,
              selectedLabelTextStyle: Theme.of(mediumNavContext)
                  .navigationRailTheme
                  .selectedLabelTextStyle,
              unSelectedLabelTextStyle: Theme.of(mediumNavContext)
                  .navigationRailTheme
                  .unselectedLabelTextStyle,
            ),
          ),
          Breakpoints.mediumLarge: SlotLayout.from(
            key: _primaryNavigationMediumLargeKey,
            inAnimation: AdaptiveScaffold.leftOutIn,
            builder: (mediumLargeNavContext) =>
                AdaptiveScaffold.standardNavigationRail(
              selectedIndex: _calculateSelectedIndex(mediumLargeNavContext),
              onDestinationSelected: (index) => _onNavDestinationSelected(
                mediumLargeNavContext,
                index,
              ),
              extended: true,
              destinations: AppRoutes.railDestinations(mediumLargeNavContext),
              backgroundColor: Theme.of(mediumLargeNavContext)
                  .navigationRailTheme
                  .backgroundColor,
              selectedIconTheme: Theme.of(mediumLargeNavContext)
                  .navigationRailTheme
                  .selectedIconTheme,
              unselectedIconTheme: Theme.of(mediumLargeNavContext)
                  .navigationRailTheme
                  .unselectedIconTheme,
              selectedLabelTextStyle: Theme.of(mediumLargeNavContext)
                  .navigationRailTheme
                  .selectedLabelTextStyle,
              unSelectedLabelTextStyle: Theme.of(mediumLargeNavContext)
                  .navigationRailTheme
                  .unselectedLabelTextStyle,
            ),
          ),
          Breakpoints.large: SlotLayout.from(
            key: _primaryNavigationLargeKey,
            inAnimation: AdaptiveScaffold.leftOutIn,
            builder: (largeNavContext) =>
                AdaptiveScaffold.standardNavigationRail(
              selectedIndex: _calculateSelectedIndex(largeNavContext),
              onDestinationSelected: (index) => _onNavDestinationSelected(
                largeNavContext,
                index,
              ),
              extended: true,
              destinations: AppRoutes.railDestinations(largeNavContext),
              backgroundColor:
                  Theme.of(largeNavContext).navigationRailTheme.backgroundColor,
              selectedIconTheme: Theme.of(largeNavContext)
                  .navigationRailTheme
                  .selectedIconTheme,
              unselectedIconTheme: Theme.of(largeNavContext)
                  .navigationRailTheme
                  .unselectedIconTheme,
              selectedLabelTextStyle: Theme.of(largeNavContext)
                  .navigationRailTheme
                  .selectedLabelTextStyle,
              unSelectedLabelTextStyle: Theme.of(largeNavContext)
                  .navigationRailTheme
                  .unselectedLabelTextStyle,
            ),
          ),
          Breakpoints.extraLarge: SlotLayout.from(
            key: _primaryNavigationExtraLargeKey,
            inAnimation: AdaptiveScaffold.leftOutIn,
            outAnimation: AdaptiveScaffold.fadeOut,
            builder: (extraLargeNavContext) =>
                AdaptiveScaffold.standardNavigationRail(
              selectedIndex: _calculateSelectedIndex(extraLargeNavContext),
              onDestinationSelected: (index) => _onNavDestinationSelected(
                extraLargeNavContext,
                index,
              ),
              extended: true,
              destinations: AppRoutes.railDestinations(extraLargeNavContext),
              backgroundColor: Theme.of(extraLargeNavContext)
                  .navigationRailTheme
                  .backgroundColor,
              selectedIconTheme: Theme.of(extraLargeNavContext)
                  .navigationRailTheme
                  .selectedIconTheme,
              unselectedIconTheme: Theme.of(extraLargeNavContext)
                  .navigationRailTheme
                  .unselectedIconTheme,
              selectedLabelTextStyle: Theme.of(extraLargeNavContext)
                  .navigationRailTheme
                  .selectedLabelTextStyle,
              unSelectedLabelTextStyle: Theme.of(extraLargeNavContext)
                  .navigationRailTheme
                  .unselectedLabelTextStyle,
            ),
          ),
        },
      );

  SlotLayout get _body => SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.standard: SlotLayout.from(
            key: _bodyStandardKey,
            builder: (context) => child,
          ),
        },
      );

  SlotLayout get _bottomNavigation => SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.small: SlotLayout.from(
            key: _bottomNavigationSmallKey,
            inAnimation: AdaptiveScaffold.bottomToTop,
            outAnimation: AdaptiveScaffold.topToBottom,
            builder: (context) => AdaptiveScaffold.standardBottomNavigationBar(
              destinations: AppRoutes.navDestinations(context),
              currentIndex: _calculateSelectedIndex(context),
              onDestinationSelected: (index) => _onNavDestinationSelected(
                context,
                index,
              ),
            ),
          ),
        },
      );

  int _calculateSelectedIndex(BuildContext context) {
    final GoRouter router = GoRouter.of(context);

    final String location = router.routerDelegate.currentConfiguration.uri.path;

    final int? index = AppRoutes.navBarPathToIndex[location];

    return index ?? 0;
  }

  void _onNavDestinationSelected(BuildContext context, int index) {
    final AppPaths? path = AppRoutes.navBarIndexToPath[index];

    NavigationUtils.navigateTo(
      context: context,
      path: path ?? AppPaths.liveOverview,
    );
  }
}
