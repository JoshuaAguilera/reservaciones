import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/database/init_database.dart';
import 'package:generador_formato/views/home_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:generador_formato/views/login_view.dart';
import 'package:window_manager/window_manager.dart';
import 'package:generador_formato/utils/helpers/custom_scroll_behavior.dart';

Future<void> main() async {
  //Compatibily Windows scale
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  if (Platform.isWindows) {
    WindowManager.instance.setMinimumSize(const Size(320, 420));
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
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      darkTheme: ThemeData(
          //Se indica que el tema tiene un brillo oscuro
          brightness: Brightness.dark,
          useMaterial3: false),
      routes: {
        'home': (_) => HomeView(),
        'login': (_) => const LoginView(),
      },
      initialRoute: 'login',
    );
  }
}
