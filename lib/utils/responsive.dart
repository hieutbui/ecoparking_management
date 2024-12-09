import 'package:ecoparking_management/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class ResponsiveUtils {
  static const double minDesktopWidth = 1239;
  static const double minTabletWidth = 905;
  static const double minTabletLargeWidth = 900;
  static const double maxMobileWidth = 904;
  static const double heightShortest = 600;

  double getDeviceWidth(BuildContext context) => context.width;
  double getDeviceHeight(BuildContext context) => context.height;

  bool isMobile(BuildContext context) =>
      getDeviceWidth(context) < minTabletWidth;

  bool isTablet(BuildContext context) =>
      getDeviceWidth(context) >= minTabletWidth &&
      getDeviceWidth(context) < minDesktopWidth;

  bool isDesktop(BuildContext context) =>
      getDeviceWidth(context) >= minDesktopWidth;

  bool isTabletLarge(BuildContext context) =>
      getDeviceWidth(context) >= minTabletLargeWidth &&
      getDeviceWidth(context) < minDesktopWidth;

  bool isPortrait(BuildContext context) =>
      context.orientation == Orientation.portrait;

  bool isLandscape(BuildContext context) =>
      context.orientation == Orientation.landscape;

  bool isLandscapeMobile(BuildContext context) =>
      isScreenWithShortestSide(context) && isLandscape(context);

  bool isLandscapeTablet(BuildContext context) {
    return context.mediaQueryShortestSide >= minTabletWidth &&
        context.mediaQueryShortestSide < minDesktopWidth &&
        isLandscape(context);
  }

  bool isPortraitMobile(BuildContext context) =>
      isScreenWithShortestSide(context) && isPortrait(context);

  bool isPortraitTablet(BuildContext context) {
    return context.mediaQueryShortestSide >= minTabletWidth &&
        context.mediaQueryShortestSide < minDesktopWidth &&
        isPortrait(context);
  }

  bool isHeightShortest(BuildContext context) {
    return MediaQuery.sizeOf(context).shortestSide < heightShortest;
  }

  bool isScreenWithShortestSide(BuildContext context) =>
      context.mediaQueryShortestSide < minTabletWidth;
}
