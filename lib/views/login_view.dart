import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
import 'package:generador_formato/services/auth_service.dart';
import 'package:generador_formato/views/home_view.dart';
import 'package:generador_formato/widgets/text_styles.dart';

import '../ui/show_snackbar.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKeyLogin = GlobalKey<FormState>();
  bool _passwordVisible = false;
  bool isLoading = false;

  @override
  void initState() {
    _passwordVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          height: screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, DesktopColors.cerulean],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter),
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
                  elevation: 6,
                  child: Row(
                    mainAxisAlignment: (screenWidth > 700)
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth > 500 ? 36.0 : 12,
                            vertical: screenHeight > 500 ? 60 : 25),
                        child: Form(
                          key: _formKeyLogin,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: (screenWidth > 700)
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.center,
                            children: [
                              Image(
                                image: const AssetImage(
                                    "assets/image/logo_lobby.png"),
                                width: screenWidth > 350 ? 220 : 170,
                              ),
                              TextStyles.titleText(
                                text: "Iniciar sesión",
                                color: DesktopColors.prussianBlue,
                                size: screenWidth > 350 ? 18 : 15,
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
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
                                  controller: userNameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Ingrese usuario';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Usuario"),
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
                                  color: Colors.white.withOpacity(0.1),
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
                                  controller: passwordController,
                                  obscureText: _passwordVisible,
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
                                      border: const OutlineInputBorder(),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _passwordVisible
                                              ? CupertinoIcons.eye_solid
                                              : CupertinoIcons.eye_slash_fill,
                                          color: DesktopColors.cerulean,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        },
                                      ),
                                      labelText: "Contraseña"),
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                height: screenWidth > 350 ? 40 : 35,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    setState(() => isLoading = true);
                                    if (_formKeyLogin.currentState!
                                        .validate()) {
                                      if (!await AuthService().foundUserName(
                                          userNameController.text)) {
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

                                      if (!await AuthService().loginUser(
                                          userNameController.text,
                                          passwordController.text)) {
                                        setState(() => isLoading = false);
                                        showSnackBar(
                                          type: "danger",
                                          context: context,
                                          title:
                                              "Usuario y contraseña incorrectos",
                                          message:
                                              "Nombre de usuario o contraseña no válidos",
                                        );
                                        return;
                                      }

                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeView()),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: isLoading
                                          ? DesktopColors.cerulean
                                          : DesktopColors.prussianBlue),
                                  child: Row(
                                    mainAxisAlignment: isLoading
                                        ? MainAxisAlignment.spaceAround
                                        : MainAxisAlignment.center,
                                    children: [
                                      if (isLoading)
                                        const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.white),
                                        ),
                                      TextStyles.buttonTextStyle(
                                          text: !isLoading
                                              ? "Ingresar"
                                              : "Espere"),
                                    ],
                                  ),
                                ),
                              )
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
}
