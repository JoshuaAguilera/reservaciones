import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

import '../models/estatus_snackbar_model.dart';
import '../res/helpers/colors_helpers.dart';
import '../res/helpers/functions_ui.dart';
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
  const LoginView({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  bool isLoading = false;
  bool startflow = false;

  @override
  void initState() {
    validCredentials();
    super.initState();
  }

  Future validCredentials() async {
    bool isLogged = await AuthService().searchToken();
    if (isLogged) {
      if (!mounted) return;
      await ref.read(getUserProvider.future);
      Navigator.pushReplacementNamed(context, 'main');
    } else {
      isLoading = false;
      setState(() {});
    }
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
                Positioned(
                  top: 10,
                  child: Stack(
                    children: [
                      SizedBox(
                        child: Image(
                          image: AssetImage(brightness == Brightness.light
                              ? "assets/image/large_black_logo.png"
                              : "assets/image/large_logo.png"),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: TextStyles.standardText(
                          text: "Versión $version",
                          size: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const _LoginForm(),
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
  final _username = TextEditingController();
  final _password = TextEditingController();
  bool passwordVisible = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final saveName = ref.watch(saveNameProvider);
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;
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
                          TextStyles.mediumText(
                            text: "Iniciar sesión",
                            size: sizeScreen.width > 350 ? 20 : 15,
                          ),
                          FormWidgets.textFormField(
                            name: "Usuario",
                            enabled: !isLoading,
                            onFieldSubmitted: (p0) async =>
                                await _logingUser(brightness),
                            controller: _username,
                          ),
                          FormWidgets.textFormField(
                            name: "Contraseña",
                            controller: _password,
                            enabled: !isLoading,
                            isPassword: true,
                            onFieldSubmitted: (value) async {
                              await _logingUser(brightness);
                            },
                          ),
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
                          Align(
                            alignment: Alignment.centerRight,
                            child: Buttons.buttonPrimary(
                              isLoading: isLoading,
                              text: "  Ingresar  ",
                              compact: true,
                              backgroundColor: brightness != Brightness.light
                                  ? isLoading
                                      ? DesktopColors.prussianBlue
                                      : DesktopColors.cerulean
                                  : isLoading
                                      ? DesktopColors.cerulean
                                      : DesktopColors.prussianBlue,
                              onPressed: () async =>
                                  await _logingUser(brightness),
                            ),
                          ),
                          // TextButton(
                          //   onPressed: isLoading
                          //       ? null
                          //       : () {
                          //           ref
                          //               .watch(showForgotPassProvider.notifier)
                          //               .update((state) => true);
                          //         },
                          //   child: TextStyles.standardText(
                          //     text: "¿Haz olvidado tu contraseña?",
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (sizeScreen.width > 700)
                Container(
                  width: 350,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(34),
                      topRight: Radius.circular(34),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/image/lobby.jpg"),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _logingUser(Brightness brightness) async {
    if (!_formKeyLogin.currentState!.validate()) {}
    applyUnfocus();
    setState(() => isLoading = true);

    ref.read(usernameProvider.notifier).update((state) => _username.text);
    ref.read(passwordProvider.notifier).update((state) => _password.text);
    final saveName = ref.watch(saveNameProvider);

    bool response = await ref.read(authProvider.future);

    if (response) {
      isLoading = false;
      setState(() {});
      return;
    }

    if (saveName) Settings.savename = _username.text;
    ref.read(usernameProvider.notifier).update((state) => "");
    ref.read(passwordProvider.notifier).update((state) => "");

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
        Future.delayed(Durations.short1, () {
          if (!mounted) return;
          brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;
          setState(() {});
        });
      },
    );

    passwordVisible = true;
    isLoading = false;
    _username.text = '';
    _password.text = '';
    setState(() {});

    setState(() => isLoading = false);
  }
}
