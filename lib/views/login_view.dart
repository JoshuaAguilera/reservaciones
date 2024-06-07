import 'package:flutter/material.dart';
import 'package:generador_formato/Utility/my_colors.dart';
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
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: MyColors.appBarColor,
      //   elevation: 2,
      //   title: Row(children: [
      //     Image(image: AssetImage("assets/image/white_logo.png"), width: 150)
      //   ],),
      // ),
      body: Container(
        width: screenWidth,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, MyColors.cerulean],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 700,
              height: 450,
              child: Card(
                elevation: 6,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 36.0, vertical: 56),
                      child: Form(
                        key: _formKeyLogin,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Image(
                              image: AssetImage("assets/image/logo_lobby.png"),
                              width: 200,
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
                                        color: MyColors.azulCielo,
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
                              height: 35,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKeyLogin.currentState!.validate()) {}
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: MyColors.prussianBlue),
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
                    Container(
                      width: 350,
                      height: 450,
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
            )
          ],
        ),
      ),
    );
  }
}
