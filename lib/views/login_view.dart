import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database.dart';
import '../models/imagen_model.dart';
import '../view-models/providers/cotizacion_provider.dart';
import '../view-models/providers/dahsboard_provider.dart';
import '../view-models/providers/habitacion_provider.dart';
import '../view-models/providers/tarifario_provider.dart';
import '../view-models/providers/usuario_provider.dart';
import '../res/helpers/constants.dart';
import '../res/helpers/desktop_colors.dart';
import '../res/helpers/utility.dart';
import '../res/ui/buttons.dart';
import '../res/ui/show_snackbar.dart';
import '../res/ui/text_styles.dart';
import '../view-models/services/auth_service.dart';
import '../view-models/services/image_service.dart';
import '../utils/shared_preferences/preferences.dart';
import '../utils/widgets/form_widgets.dart';
import 'home_view.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKeyLogin = GlobalKey<FormState>();
  bool passwordVisible = false;
  bool isLoading = false;

  @override
  void initState() {
    passwordVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Color colorText = brightness == Brightness.light
        ? DesktopColors.prussianBlue
        : Colors.white;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              brightness == Brightness.light
                  ? Colors.white
                  : Utility.darken(DesktopColors.canvasColor, 0.15),
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
                Center(
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: screenWidth > 350 ? 450 : 390,
                      maxWidth: screenWidth < 700 ? 450 : 700,
                    ),
                    child: Card(
                      elevation: 6,
                      shape: const ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(80)),
                      ),
                      child: Row(
                        mainAxisAlignment: (screenWidth > 700)
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth > 500 ? 36.0 : 12,
                                  vertical: screenHeight > 500 ? 25 : 25),
                              child: Form(
                                key: _formKeyLogin,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: (screenWidth > 700)
                                        ? CrossAxisAlignment.start
                                        : CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    spacing: 20,
                                    children: [
                                      Stack(
                                        children: [
                                          SizedBox(
                                            child: Image(
                                              image: AssetImage(brightness ==
                                                      Brightness.light
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
                                              color: colorText,
                                            ),
                                          ),
                                        ],
                                      ),
                                      TextStyles.mediumText(
                                        text: "Iniciar sesión",
                                        color: colorText,
                                        size: screenWidth > 350 ? 20 : 15,
                                      ),
                                      FormWidgets.textFormField(
                                        name: "Usuario",
                                        enabled: !isLoading,
                                        onFieldSubmitted: (value) async {
                                          await submitData(brightness);
                                        },
                                        controller: userNameController,
                                      ),
                                      FormWidgets.textFormField(
                                        name: "Contraseña",
                                        controller: passwordController,
                                        enabled: !isLoading,
                                        isPassword: true,
                                        onFieldSubmitted: (value) async {
                                          await submitData(brightness);
                                        },
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Buttons.buttonPrimary(
                                          isLoading: isLoading,
                                          text: "  Ingresar  ",
                                          compact: true,
                                          backgroundColor: brightness !=
                                                  Brightness.light
                                              ? isLoading
                                                  ? DesktopColors.prussianBlue
                                                  : DesktopColors.cerulean
                                              : isLoading
                                                  ? DesktopColors.cerulean
                                                  : DesktopColors.prussianBlue,
                                          onPressed: () async =>
                                              await submitData(brightness),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (screenWidth > 700)
                            // if (screenHeight > 400)
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
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future submitData(Brightness brightness) async {
    setState(() => isLoading = true);
    if (_formKeyLogin.currentState!.validate()) {
      if (!await AuthService().foundUserName(userNameController.text)) {
        setState(() => isLoading = false);
        showSnackBar(
          type: "alert",
          context: context,
          title: "Usuario no encontrado",
          message:
              "No se tiene registro del usuario: ${userNameController.text}",
        );
        return;
      }

      if (!await AuthService()
          .loginUser(userNameController.text, passwordController.text)) {
        passwordController.text = "";
        setState(() => isLoading = false);
        showSnackBar(
          type: "danger",
          context: context,
          title: "Usuario y contraseña incorrectos",
          message: "Nombre de usuario o contraseña no válidos",
        );
        return;
      }

      if (!context.mounted) return;
      UsuarioTableData usuario = await AuthService()
          .savePerfil(userNameController.text, passwordController.text);

      if (usuario.imageId != null) {
        ImageTableData? imageUser =
            await ImageService().getImageById(usuario.imageId!);

        if (imageUser != null) {
          Preferences.userImageUrl = imageUser.urlImage ?? '';
          ref.watch(imagePerfilProvider.notifier).update(
                (ref) => Imagen(
                  createdAt: int.parse(imageUser.code ?? '0'),
                  ruta: imageUser.urlImage,
                  nombre: usuario.id,
                  idInt: imageUser.id,
                ),
              );
        } else {
          Preferences.userImageUrl = "";
          ref.watch(imagePerfilProvider.notifier).update((ref) => Imagen());
        }

        setState(() {});
      } else {
        Preferences.userImageUrl = "";
        ref.watch(imagePerfilProvider.notifier).update((ref) => Imagen());
      }

      ref.read(userProvider.notifier).update((state) => usuario);
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

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeView()),
      ).then(
        (value) {
          Future.delayed(Durations.short1, () {
            brightness =
                ThemeModelInheritedNotifier.of(context).theme.brightness;
            setState(() {});
          });
        },
      );

      passwordVisible = true;
      isLoading = false;
      userNameController.text = '';
      passwordController.text = '';
      setState(() {});
    } else {
      setState(() => isLoading = false);
    }
  }
}
