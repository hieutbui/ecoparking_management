import 'dart:io';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/foundation.dart';

abstract class PlatformInfos {
  static bool get isRelease => kReleaseMode;

  static bool get isWeb => kIsWeb;

  static bool get isLinux => !kIsWeb && Platform.isLinux;

  static bool get isWindows => !kIsWeb && Platform.isWindows;

  static bool get isMacOS => !kIsWeb && Platform.isMacOS;

  static bool get isIOS => !kIsWeb && Platform.isIOS;

  static bool get isAndroid => !kIsWeb && Platform.isAndroid;

  static bool get isCupertinoStyle => isIOS || isMacOS;

  static bool get isMobile => isAndroid || isIOS;

  /// For desktops which don't support CachedNetworkImage yet
  static bool get isBetaDesktop => isWindows || isLinux;

  static bool get isDesktop => isLinux || isWindows || isMacOS;

  static bool get usesTouchscreen => !isMobile;

  static bool get platformCanRecord => (isMobile || isMacOS);

  static bool get isMacKeyboardPlatform => isMacOS || isWebInMac;

  static bool get isWebInMac =>
      kIsWeb &&
      html.window.navigator.platform != null &&
      html.window.navigator.platform!.toLowerCase().contains('mac');

  static bool get isFireFoxBrowser =>
      kIsWeb &&
      html.window.navigator.userAgent.toLowerCase().contains('firefox');
}
