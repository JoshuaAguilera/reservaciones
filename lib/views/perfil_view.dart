import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/utils/encrypt/encrypter.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
import 'package:generador_formato/utils/shared_preferences/preferences.dart';
import 'package:generador_formato/widgets/textformfield_custom.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import '../widgets/text_styles.dart';

class PerfilView extends StatefulWidget {
  const PerfilView({super.key, required this.sideController});

  final SidebarXController sideController;
  @override
  State<PerfilView> createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  final TextEditingController dateController =
      TextEditingController(text: DateTime.now().toString().substring(0, 10));
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordMailController = TextEditingController();
  final TextEditingController passwordMailNewController =
      TextEditingController();
  final TextEditingController passwordMailConfirmController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool changeDate = false;
  bool canChangedKey = false;
  bool canChangedKeyMail = false;
  bool cancelChangedKeyMail = false;

  @override
  void initState() {
    super.initState();
    usernameController.text = Preferences.username;
    firstnameController.text = Preferences.firstName;
    lastnameController.text = Preferences.lastName;
    passwordController.text =
        EncrypterTool.decryptData(Preferences.password, null);
    phoneController.text = Preferences.phone.toString().substring(3);
    mailController.text = Preferences.mail;
    passwordMailController.text =
        EncrypterTool.decryptData(Preferences.passwordMail, null);
    if (Preferences.birthDate.isNotEmpty) {
      dateController.text = Preferences.birthDate;
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    mailController.dispose();
    passwordMailController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: screenWidth < 800
          ? null
          : SizedBox(
              height: 35,
              width: 120,
              child: Buttons.commonButton(
                  onPressed: () {
                    updateUser.call();
                  },
                  text: "Guardar"),
            ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextStyles.titlePagText(
                      text: "Perfil", color: Theme.of(context).primaryColor),
                  Row(children: [])
                ],
              ),
              TextStyles.standardText(
                text: "Gestiona y personaliza la información de tu cuenta.",
                color: Theme.of(context).primaryColor,
              ),
              Divider(
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 5),
              Form(
                key: _formKey,
                child: Wrap(
                  children: [
                    SizedBox(
                      width: screenWidth < 800
                          ? (widget.sideController.extended ? screenWidth : 355)
                          : 355,
                      child: Card(
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextStyles.standardText(
                                  isBold: true,
                                  text: "Información general",
                                  overClip: true,
                                  color: Theme.of(context).primaryColor,
                                  size: 16),
                              const SizedBox(height: 20),
                              Center(
                                child: Stack(
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                          "assets/image/usuario.png"),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      right: 10,
                                      child: SizedBox(
                                        height: 35,
                                        width: 35,
                                        child: FloatingActionButton(
                                          backgroundColor: Colors.white,
                                          onPressed: () {},
                                          child: Icon(
                                            Icons.edit,
                                            color: DesktopColors.cerulean,
                                            size: 26,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                child: TextButton(
                                  onPressed: () {},
                                  child: TextStyles.buttonText(
                                      text: "Rol de usuario",
                                      size: 14,
                                      color: DesktopColors.cerulean),
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormFieldCustom.textFormFieldwithBorder(
                                name: "Nombre de usuario",
                                controller: usernameController,
                              ),
                              SizedBox(height: 6),
                              SizedBox(
                                width: double.infinity,
                                child: Wrap(
                                  runSpacing: 5,
                                  spacing: 10,
                                  children: [
                                    TextFormFieldCustom.textFormFieldwithBorder(
                                        name: "Nombre",
                                        controller: firstnameController),
                                    TextFormFieldCustom.textFormFieldwithBorder(
                                        name: "Apellido",
                                        controller: lastnameController),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: double.infinity,
                                child: TextFormFieldCustom
                                    .textFormFieldwithBorderCalendar(
                                  name: "Fecha de nacimiento",
                                  msgError: "Campo requerido*",
                                  dateController: dateController,
                                  nowLastYear: true,
                                  fechaLimite: "1900-01-01",
                                  changed: !changeDate,
                                  onChanged: () {
                                    setState(() {
                                      changeDate = true;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: double.infinity,
                                child:
                                    TextFormFieldCustom.textFormFieldwithBorder(
                                  isPassword: true,
                                  passwordVisible: true,
                                  //    initialValue: Preferences.passwordMail,
                                  name: "Contraseña",
                                  readOnly: true,
                                  controller: passwordController,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    setState(() => canChangedKey = true);
                                  },
                                  child: TextStyles.buttonText(
                                      text: "Cambiar contraseña", size: 12),
                                ),
                              )
                                  .animate(target: canChangedKey ? 0 : 1)
                                  .fadeIn(delay: 300.ms),
                              const SizedBox(height: 7),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth < 800
                          ? (widget.sideController.extended ? screenWidth : 355)
                          : 355,
                      child: Card(
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextStyles.standardText(
                                  isBold: true,
                                  text: "Datos de correo y teléfono",
                                  overClip: true,
                                  color: Theme.of(context).primaryColor,
                                  size: 16),
                              TextStyles.standardText(
                                text:
                                    "Requerido para el envio del comprobante para cotización.",
                                color: Theme.of(context).primaryColor,
                                size: 11,
                                overClip: true,
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                child: Wrap(
                                  runSpacing: 5,
                                  spacing: 10,
                                  children: [
                                    TextFormFieldCustom.textFormFieldwithBorder(
                                      name: "Teléfono",
                                      controller: phoneController,
                                      isNumeric: true,
                                    ),
                                    TextFormFieldCustom.textFormFieldwithBorder(
                                        name: "Correo electrónico",
                                        controller: mailController),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: double.infinity,
                                child:
                                    TextFormFieldCustom.textFormFieldwithBorder(
                                  isPassword: true,
                                  passwordVisible: true,
                                  name: "Contraseña de correo",
                                  controller: passwordMailController,
                                  readOnly: true,
                                ),
                              ),
                              SizedBox(
                                height: canChangedKeyMail ? 0 : null,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() => canChangedKeyMail = true);
                                      Future.delayed(
                                          Durations.long1,
                                          () => setState(() =>
                                              cancelChangedKeyMail = true));
                                    },
                                    child: TextStyles.buttonText(
                                        text: "Cambiar contraseña  de correo",
                                        size: 12),
                                  ),
                                )
                                    .animate(target: canChangedKeyMail ? 0 : 1)
                                    .fadeIn(delay: 300.ms),
                              ),
                              SizedBox(
                                height: cancelChangedKeyMail ? null : 0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: TextStyles.standardText(
                                        text: "Modificación de contraseña",
                                        color: Theme.of(context).primaryColor,
                                        size: 11,
                                      ),
                                    ),
                                    Wrap(
                                      children: [
                                        TextFormFieldCustom
                                            .textFormFieldwithBorder(
                                          name: "Nueva Contraseña",
                                          controller: passwordMailNewController,
                                        ),
                                        TextFormFieldCustom
                                            .textFormFieldwithBorder(
                                          name: "Confirmar Contraseña",
                                          controller:
                                              passwordMailConfirmController,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Buttons.commonButton(
                                            onPressed: () {
                                              setState(() =>
                                                  cancelChangedKeyMail = false);
                                              Future.delayed(
                                                  Durations.long1,
                                                  () => setState(() =>
                                                      canChangedKeyMail =
                                                          false));
                                            },
                                            color: DesktopColors.mentaOscure,
                                            text: "Cancelar"),
                                        Buttons.commonButton(
                                            onPressed: () {}, text: "Guardar")
                                      ],
                                    )
                                  ],
                                )
                                    .animate(
                                        target: cancelChangedKeyMail ? 1 : 0)
                                    .fadeIn(duration: 500.ms),
                              ),
                              const SizedBox(height: 7),
                              if (screenWidth < 800)
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    height: 35,
                                    width: 120,
                                    child: Buttons.commonButton(
                                        onPressed: () {
                                          updateUser.call();
                                        },
                                        text: "Guardar"),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  updateUser() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
  }
}
