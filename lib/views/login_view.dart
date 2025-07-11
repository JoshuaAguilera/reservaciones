import 'dart:async';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tuple/tuple.dart';

import '../models/estatus_snackbar_model.dart';
import '../res/helpers/colors_helpers.dart';
import '../res/helpers/functions_ui.dart';
import '../res/ui/themes.dart';
import '../utils/shared_preferences/settings.dart';
import '../view-models/providers/auth_provider.dart';
import '../view-models/providers/cotizacion_provider.dart';
import '../view-models/providers/dahsboard_provider.dart';
import '../view-models/providers/habitacion_provider.dart';
import '../view-models/providers/tarifario_provider.dart';
import '../view-models/providers/ui_provider.dart';
import '../view-models/providers/usuario_provider.dart';
import '../res/helpers/constants.dart';
import '../res/helpers/desktop_colors.dart';
import '../res/ui/buttons.dart';
import '../res/ui/text_styles.dart';
import '../view-models/services/auth_service.dart';
import '../utils/widgets/form_widgets.dart';
import 'home_view.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  bool isLoading = true;
  bool startflow = false;
  bool activeModeDark = false;
  bool modificMode = false;

  @override
  void initState() {
    validCredentials();
    super.initState();
  }

  Future validCredentials() async {
    bool isLogged = await AuthService().searchToken();
    Future.delayed(
      const Duration(seconds: 3),
      () async {
        if (isLogged) {
          if (!mounted) return;
          await ref.read(getUserProvider.future);
          if (!mounted) return;
          Navigator.pushReplacementNamed(context, 'home');
        } else {
          isLoading = false;
          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;

    if (!startflow) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Tuple2<bool, String>?;

      if (args?.item2 != null) {
        Future.delayed(
          Durations.short4,
          () {
            ref.read(snackbarServiceProvider).showCustomSnackBar(
                  message: args?.item2 ?? '',
                  duration: const Duration(seconds: 3),
                  type: (args?.item1 ?? false)
                      ? TypeSnackbar.danger
                      : TypeSnackbar.success,
                  withIcon: true,
                );
          },
        );
      }
      startflow = true;
    }

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              brightness == Brightness.light
                  ? Colors.white
                  : ColorsHelpers.darken(DesktopColors.canvasColor, 0.15),
              brightness == Brightness.light
                  ? DesktopColors.cerulean
                  : DesktopColors.canvasColor,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                ThemeSwitcher(
                  clipper: const ThemeSwitcherCircleClipper(),
                  builder: (cont) {
                    return Positioned(
                      top: 5,
                      left: 5,
                      child: AbsorbPointer(
                        absorbing: modificMode,
                        child: GestureDetector(
                          onTapDown: (details) {
                            modificMode = true;
                            setState(() {});
                            ThemeSwitcher.of(cont).changeTheme(
                              theme: brightness == Brightness.light
                                  ? Themes().darkMode()
                                  : Themes().lightMode(),
                              offset: details.localPosition,
                              isReversed:
                                  brightness == Brightness.dark ? true : false,
                            );
                            Settings.modeDark = !Settings.modeDark;
                            setState(() {});

                            Future.delayed(const Duration(milliseconds: 400),
                                () {
                              modificMode = false;
                              setState(() {});
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: brightness == Brightness.light
                                    ? DesktopColors.prussianBlue
                                    : Colors.white,
                                width: 1.5,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                            ),
                            padding: const EdgeInsets.all(3),
                            child: Icon(
                              !Settings.modeDark
                                  ? Iconsax.moon_bold
                                  : Icons.sunny,
                              color: brightness == Brightness.light
                                  ? DesktopColors.prussianBlue
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Column(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              width: 350,
                              child: Image(
                                image: AssetImage(brightness == Brightness.light
                                    ? "assets/image/alternative_logo.png"
                                    : "assets/image/large_logo.png"),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 0,
                              child: TextStyles.standardText(
                                text: "Versión $version",
                                size: 11,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (isLoading)
                      Center(
                        child: LoadingAnimationWidget.discreteCircle(
                          color: DesktopColors.primary4,
                          secondRingColor: DesktopColors.primary5,
                          thirdRingColor: DesktopColors.primary1,
                          size: 40,
                        ),
                      ),
                    if (!isLoading) const _LoginForm(),
                    const SizedBox(height: 50),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _LoginForm extends ConsumerStatefulWidget {
  const _LoginForm();

  @override
  ConsumerState<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<_LoginForm> {
  final _formKeyLogin = GlobalKey<FormState>();
  bool passwordVisible = false;
  bool isLoading = false;

  int _currentIndex = 0;
  Timer? _timer;
  final List<String> imagePaths = [
    'assets/image/amanecer_login.png',
    'assets/image/dia_login.png',
    'assets/image/atardecer_login.png',
    'assets/image/noche_login.png',
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 7), (timer) {
      _currentIndex = (_currentIndex + 1) % imagePaths.length;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final saveName = ref.watch(saveNameProvider);
    final _username = ref.watch(usernameProvider);
    final _password = ref.watch(passwordProvider);
    final sizeScreen = MediaQuery.of(context).size;

    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: sizeScreen.width > 350 ? 450 : 390,
          maxWidth: sizeScreen.width < 700 ? 450 : 700,
        ),
        child: Card(
          elevation: 6,
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(80)),
          ),
          child: Row(
            mainAxisAlignment: (sizeScreen.width > 700)
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: sizeScreen.width > 500 ? 36.0 : 12,
                      vertical: sizeScreen.height > 500 ? 25 : 25),
                  child: Form(
                    key: _formKeyLogin,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: (sizeScreen.width > 700)
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        spacing: 20,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextStyles.mediumText(
                                text: "Iniciar sesión",
                                size: sizeScreen.width > 350 ? 22 : 18,
                              ),
                              const Divider(),
                            ],
                          ),
                          FormWidgets.textFormField(
                            name: "Usuario",
                            enabled: !isLoading,
                            onFieldSubmitted: (p0) async => await _logingUser(),
                            controller: _username,
                          ),
                          FormWidgets.textFormField(
                            name: "Contraseña",
                            controller: _password,
                            enabled: !isLoading,
                            isPassword: true,
                            onFieldSubmitted: (value) async {
                              await _logingUser();
                            },
                          ),
                          Column(
                            spacing: 10,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FormWidgets.inputCheckBox(
                                context,
                                title: "Recordar usuario",
                                value: saveName,
                                enable: !isLoading,
                                compact: true,
                                onChanged: (p0) {
                                  ref
                                      .read(saveNameProvider.notifier)
                                      .update((state) => p0!);
                                },
                              ),
                              SizedBox(
                                width: 150,
                                child: Buttons.buttonPrimary(
                                  isLoading: isLoading,
                                  text: "Ingresar",
                                  compact: true,
                                  onPressed: () async {
                                    await _logingUser();
                                  },
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  if (isLoading) return;
                                  // ref
                                  //     .watch(showForgotPassProvider.notifier)
                                  //     .update((state) => true);
                                },
                                child: TextStyles.standardText(
                                  text: "¿Haz olvidado tu contraseña?",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (sizeScreen.width > 700)
                Container(
                  width: 350,
                  height: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(34),
                      topRight: Radius.circular(34),
                    ),
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 800),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: Image.asset(
                      imagePaths[_currentIndex],
                      key: ValueKey(imagePaths[
                          _currentIndex]), // Importante para el cambio
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _logingUser() async {
    if (!_formKeyLogin.currentState!.validate()) return;
    applyUnfocus();
    setState(() => isLoading = true);

    ref.invalidate(authProvider);
    bool response = await ref.watch(authProvider.future);

    if (response) {
      isLoading = false;
      setState(() {});
      return;
    }

    isLoading = false;
    setState(() {});

    // ref.read(userProvider.notifier).update((state) => usuario);
    ref
        .read(changeHistoryProvider.notifier)
        .update((state) => UniqueKey().hashCode);
    ref.read(changeProvider.notifier).update((state) => UniqueKey().hashCode);
    ref
        .read(detectChangeRoomProvider.notifier)
        .update((state) => UniqueKey().hashCode);
    ref
        .read(detectChangeProvider.notifier)
        .update((state) => UniqueKey().hashCode);
    ref
        .read(changeTarifasProvider.notifier)
        .update((state) => UniqueKey().hashCode);
    ref
        .read(changeTarifasListProvider.notifier)
        .update((state) => UniqueKey().hashCode);
    ref
        .read(changeTariffPolicyProvider.notifier)
        .update((state) => UniqueKey().hashCode);
    ref
        .read(changeUsersProvider.notifier)
        .update((state) => UniqueKey().hashCode);

    ref
        .read(changeTarifasBaseProvider.notifier)
        .update((state) => UniqueKey().hashCode);

    await ref.read(getUserProvider.future);

    if (!mounted) return;
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeView()),
    ).then(
      (value) {
        Future.delayed(
          Durations.short1,
          () {
            if (!mounted) return;
            setState(() {});
          },
        );
      },
    );

    passwordVisible = true;
    isLoading = false;
    setState(() {});

    setState(() => isLoading = false);
  }
}
