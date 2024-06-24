import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/views/home_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:generador_formato/views/login_view.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generador de formatos de pago',
      debugShowCheckedModeBanner: false,
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
      // darkTheme: ThemeData(
      //     //Se indica que el tema tiene un brillo oscuro
      //     brightness: Brightness.dark,
      //     useMaterial3: false),
      routes: {
        'home': (_) => HomeView(),
        'login': (_) => const LoginView(),
      },
      initialRoute: 'home',
    );
  }
}
