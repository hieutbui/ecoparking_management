import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  Size get mediaQuerySize => MediaQuery.sizeOf(this);

  double get height => mediaQuerySize.height;

  double get width => mediaQuerySize.width;

  EdgeInsets get mediaQueryPadding => MediaQuery.paddingOf(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  EdgeInsets get mediaQueryViewPadding => MediaQuery.viewPaddingOf(this);

  EdgeInsets get mediaQueryViewInsets => MediaQuery.viewInsetsOf(this);

  Orientation get orientation => MediaQuery.orientationOf(this);

  bool get isLandscape => orientation == Orientation.landscape;

  bool get isPortrait => orientation == Orientation.portrait;

  double get devicePixelRatio => MediaQuery.devicePixelRatioOf(this);

  double get mediaQueryShortestSide => mediaQuerySize.shortestSide;
}
