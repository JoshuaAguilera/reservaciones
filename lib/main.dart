import 'dart:io';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:generador_formato/models/estructura_documento.dart';
import 'package:window_manager/window_manager.dart';

import 'database/init_database.dart';
import 'models/permiso_model.dart';
import 'res/helpers/custom_scroll_behavior.dart';
import 'res/ui/themes.dart';
import 'utils/shared_preferences/preferences.dart';
import 'utils/shared_preferences/settings.dart';
import 'views/home_view.dart';
import 'views/login_view.dart';

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
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isPlatformDark =
        WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    final initTheme =
        Settings.modeDark ? Themes().darkMode() : Themes().lightMode();

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
      },
    );
  }
}
