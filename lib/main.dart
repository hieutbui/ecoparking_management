import 'package:ecoparking_management/config/app_config.dart';
import 'package:ecoparking_management/config/app_routes.dart';
import 'package:ecoparking_management/config/env_loader.dart';
import 'package:ecoparking_management/config/themes.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/l10n/l10n.dart';
import 'package:ecoparking_management/utils/platform_infos.dart';
import 'package:ecoparking_management/widgets/theme_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:loggy/loggy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GetItInitializer().setup();

  if (PlatformInfos.isRelease) {
    await dotenv.load(mergeWith: EnvLoader.compileTimeEnvironment);
  } else {
    await dotenv.load(fileName: EnvLoader.envFileName);
  }

  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );

  await Supabase.initialize(
    url: EnvLoader.supabaseProjectUrl,
    anonKey: EnvLoader.supabaseAnonKey,
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
    ),
  );

  usePathUrlStrategy();

  runApp(const EcoParkingManagement());
}

class EcoParkingManagement extends StatelessWidget {
  const EcoParkingManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      builder: (context, themeMode, primaryColor) {
        return MaterialApp.router(
          routerConfig: AppRoutes.router,
          title: AppConfig.appTitle,
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: L10n.all,
          locale: const Locale('vi'),
          theme: EcoParkingManagementThemes.buildTheme(context),
        );
      },
    );
  }
}
