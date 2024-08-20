import 'dart:io';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/database/init_database.dart';
import 'package:generador_formato/ui/themes.dart';
import 'package:generador_formato/views/home_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:generador_formato/views/login_view.dart';
import 'package:window_manager/window_manager.dart';
import 'package:generador_formato/utils/helpers/custom_scroll_behavior.dart';

import 'utils/shared_preferences/preferences.dart';

Future<void> main() async {
  //Compatibily Windows scale
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  await windowManager.ensureInitialized();
  if (Platform.isWindows) {
    WindowManager.instance.setMinimumSize(const Size(960, 420));
    //WindowManager.instance.setMaximumSize(const Size(1200, 600));
  }
  //databse
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  InitDatabase.iniciarBD();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isPlatformDark =
        WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    final initTheme =
        Preferences.modeDark ? Themes().darkMode() : Themes().lightMode();

    return ThemeProvider(
        initTheme: initTheme,
        builder: (_, snapshot) {
          return MaterialApp(
            title: 'Generador de formatos de pago',
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
            theme: initTheme,
            routes: {
              'home': (_) => HomeView(),
              'login': (_) => const LoginView(),
            },
            initialRoute: 'login',
          );
        });
  }
}
