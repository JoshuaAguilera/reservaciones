import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/providers/dahsboard_provider.dart';
import 'package:generador_formato/providers/habitacion_provider.dart';
import 'package:generador_formato/providers/tarifario_provider.dart';
import 'package:generador_formato/providers/usuario_provider.dart';
import 'package:generador_formato/services/image_service.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/utils/helpers/desktop_colors.dart';
import 'package:generador_formato/services/auth_service.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/utils/shared_preferences/preferences.dart';
import 'package:generador_formato/views/home_view.dart';
import 'package:generador_formato/widgets/text_styles.dart';

import '../database/database.dart';
import '../models/imagen_model.dart';
import '../providers/cotizacion_provider.dart';
import '../ui/show_snackbar.dart';

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
    Color colorTextField = brightness == Brightness.light
        ? Colors.black54
        : const Color.fromARGB(255, 188, 188, 188);
    Color colorLabel = brightness == Brightness.light
        ? Colors.black54
        : DesktopColors.prussianBlue;

    return Stack(
      children: [
        Container(
          height: screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                brightness == Brightness.light
                    ? Colors.white
                    : DesktopColors.grisSemiPalido,
                brightness == Brightness.light
                    ? DesktopColors.cerulean
                    : DesktopColors.grisPalido
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth > 500
                    ? screenWidth > 700
                        ? 0
                        : 55
                    : 20),
            child: Center(
              child: SizedBox(
                width: 700,
                height: screenWidth > 350 ? 450 : 390,
                child: Card(
                  color: brightness == Brightness.light
                      ? const Color.fromARGB(255, 242, 242, 242)
                      : DesktopColors.cardColor,
                  elevation: 6,
                  child: Row(
                    mainAxisAlignment: (screenWidth > 700)
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth > 500 ? 36.0 : 12,
                            vertical: screenHeight > 500 ? 25 : 25),
                        child: Form(
                          key: _formKeyLogin,
                          child: Column(
                            crossAxisAlignment: (screenWidth > 700)
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 250,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      child: Image(
                                        image: AssetImage(
                                            "assets/image/${brightness == Brightness.light ? "logo_login_light" : "logo_login_dark"}.png"),
                                        width: 280,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 15,
                                      right: 0,
                                      child: TextStyles.standardText(
                                        text: "Versión 1.0.3",
                                        size: 11,
                                        color: colorText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextStyles.titleText(
                                text: "Iniciar sesión",
                                color: colorText,
                                size: screenWidth > 350 ? 18 : 15,
                              ),
                              const SizedBox(height: 10),
                              Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 180,
                                  maxWidth: screenWidth > 350 ? 270 : 200,
                                  minHeight: 70.0,
                                  maxHeight: 100.0,
                                ),
                                child: TextFormField(
                                  enabled: !isLoading,
                                  onFieldSubmitted: (value) async {
                                    await submitData(brightness);
                                  },
                                  controller: userNameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Ingrese usuario';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 9),
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.1),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Utility.darken(
                                            colorTextField, -0.05),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: colorTextField),
                                    ),
                                    labelText: "Usuario",
                                    labelStyle: TextStyles.styleStandar(
                                      color: colorLabel,
                                    ),
                                    floatingLabelStyle: TextStyles.styleStandar(
                                      color: isLoading
                                          ? colorTextField
                                          : Colors.blueAccent,
                                      size: 13,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontFamily: "poppins_regular",
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              Container(
                                height: 45,
                                margin: const EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 180,
                                  maxWidth: screenWidth > 350 ? 270 : 200,
                                  minHeight: 70.0,
                                  maxHeight: 100.0,
                                ),
                                child: TextFormField(
                                  enabled: !isLoading,
                                  onFieldSubmitted: (value) async {
                                    await submitData(brightness);
                                  },
                                  controller: passwordController,
                                  obscureText: passwordVisible,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Ingrese contraseña';
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(
                                    fontFamily: "poppins_regular",
                                    fontSize: 13,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 9),
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.1),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Utility.darken(
                                            colorTextField, -0.05),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: colorTextField),
                                    ),
                                    labelStyle: TextStyles.styleStandar(
                                      color: colorLabel,
                                    ),
                                    floatingLabelStyle: TextStyles.styleStandar(
                                      color: isLoading
                                          ? colorTextField
                                          : Colors.blueAccent,
                                      size: 13,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        passwordVisible
                                            ? CupertinoIcons.eye_solid
                                            : CupertinoIcons.eye_slash_fill,
                                        color: colorText,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          passwordVisible = !passwordVisible;
                                        });
                                      },
                                    ),
                                    labelText: "Contraseña",
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                  width: 120,
                                  height: screenWidth > 350 ? 40 : 35,
                                  child: Buttons.commonButton(
                                    isLoading: isLoading,
                                    text: "Ingresar",
                                    color: brightness != Brightness.light
                                        ? isLoading
                                            ? DesktopColors.prussianBlue
                                            : DesktopColors.cerulean
                                        : isLoading
                                            ? DesktopColors.cerulean
                                            : DesktopColors.prussianBlue,
                                    onPressed: () async =>
                                        await submitData(brightness),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      if (screenWidth > 700)
                        // if (screenHeight > 400)
                        Container(
                          width: 350,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(5),
                                  topRight: Radius.circular(5)),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/image/lobby.jpg"),
                              )),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
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
      UsuarioData usuario = await AuthService()
          .savePerfil(userNameController.text, passwordController.text);

      if (usuario.imageId != null) {
        ImagesTableData? imageUser =
            await ImageService().getImageById(usuario.imageId!);

        if (imageUser != null) {
          Preferences.userImageUrl = imageUser.urlImage ?? '';
          ref.watch(imagePerfilProvider.notifier).update(
                (ref) => Imagen(
                  code: int.parse(imageUser.code ?? '0'),
                  urlImagen: imageUser.urlImage,
                  usuarioId: usuario.id,
                  id: imageUser.id,
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
