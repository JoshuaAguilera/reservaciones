import 'dart:io';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:generador_formato/models/estructura_documento.dart';
import 'package:window_manager/window_manager.dart';

import 'database/init_database.dart';
import 'models/permiso_model.dart';
import 'res/helpers/custom_scroll_behavior.dart';
import 'res/ui/themes.dart';
import 'utils/shared_preferences/preferences.dart';
import 'utils/shared_preferences/settings.dart';
import 'view-models/providers/ui_provider.dart';
import 'views/home_view.dart';
import 'views/login_view.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

Future<void> main() async {
  //Compatibily Windows scale

  WidgetsFlutterBinding.ensureInitialized();
  await EstructuraDocumento().cargarEstructuras();
  await Permission().cargarPermisos();
  await Preferences.init();
  await Settings.init();
  await windowManager.ensureInitialized();
  if (Platform.isWindows) {
    WindowManager.instance.setMinimumSize(const Size(700, 420));
    //WindowManager.instance.setMaximumSize(const Size(1200, 600));
  }
  //databse
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  InitDatabase.iniciarBD();
  runApp(
    ProviderScope(
      child: MyApp(scaffoldMessengerKey: scaffoldMessengerKey),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({
    super.key,
    required GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
  });

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(snackbarServiceProvider).init(scaffoldMessengerKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final isPlatformDark =
    //     WidgetsBinding.instance.window.platformBrightness == Brightness.dark;

    return ScreenUtilInit(
        designSize: const Size(1920, 1080),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          final navService = ref.read(navigationServiceProvider);
          final initTheme =
              Settings.modeDark ? Themes().darkMode() : Themes().lightMode();

          return ThemeProvider(
            initTheme: initTheme,
            builder: (_, snapshot) {
              return MaterialApp(
                title: 'Tarifiko',
                navigatorKey: navService.navigatorKey,
                scaffoldMessengerKey: scaffoldMessengerKey,
                debugShowCheckedModeBanner: false,
                scrollBehavior: CustomScrollBehavior(),
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en'),
                  Locale('es'),
                ],
                theme: snapshot,
                routes: {
                  'home': (_) => HomeView(),
                  'login': (_) => const LoginView(),
                },
                initialRoute: 'login',
              );
            },
          );
        });
  }
}
