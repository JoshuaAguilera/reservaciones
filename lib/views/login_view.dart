import 'package:flutter/material.dart';
import 'package:generador_formato/constants/web_colors.dart';
import 'package:generador_formato/views/home_view.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  void initState() {
    _passwordVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: MyColors.appBarColor,
      //   elevation: 2,
      //   title: Row(children: [
      //     Image(image: AssetImage("assets/image/white_logo.png"), width: 150)
      //   ],),
      // ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, WebColors.cerulean],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth > 700 ? 0 : 75),
          child: Center(
            child: SizedBox(
              width: 700,
              height: 450,
              child: Card(
                elevation: 6,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: (screenWidth > 700)
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 36.0, vertical: 60),
                      child: Form(
                        key: _formKeyLogin,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: (screenWidth > 700)
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.center,
                          children: [
                            const Image(
                              image: AssetImage("assets/image/logo_lobby.png"),
                              width: 220,
                            ),
                            Text(
                              "Iniciar sesión",
                              style: GoogleFonts.poppins(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 270,
                                maxWidth: 270,
                                minHeight: 25.0,
                                maxHeight: 100.0,
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Ingrese usuario';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Usuario"),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 270,
                                maxWidth: 270,
                                minHeight: 25.0,
                                maxHeight: 100.0,
                              ),
                              child: TextFormField(
                                obscureText: _passwordVisible,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Ingrese contraseña';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: WebColors.azulCielo,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                    labelText: "Contraseña"),
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKeyLogin.currentState!.validate()) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                               HomeView()),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: WebColors.prussianBlue),
                                child: Text(
                                  "Ingresar",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    if (screenWidth > 700)
                      if (screenHeight > 400)
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
    );
  }
}
