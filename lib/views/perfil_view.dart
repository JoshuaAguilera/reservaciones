import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/providers/usuario_provider.dart';
import 'package:generador_formato/services/auth_service.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/utils/encrypt/encrypter.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
import 'package:generador_formato/utils/shared_preferences/preferences.dart';
import 'package:generador_formato/widgets/change_password_widget.dart';
import 'package:generador_formato/widgets/textformfield_custom.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import '../ui/show_snackbar.dart';
import '../widgets/text_styles.dart';

class PerfilView extends ConsumerStatefulWidget {
  const PerfilView({super.key, required this.sideController});

  final SidebarXController sideController;
  @override
  _PerfilViewState createState() => _PerfilViewState();
}

class _PerfilViewState extends ConsumerState<PerfilView> {
  final TextEditingController dateController =
      TextEditingController(text: DateTime.now().toString().substring(0, 10));
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordMailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool changeDate = false;
  bool canChangedKey = false;
  bool canChangedKeyMail = false;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    usernameController.text = Preferences.username;
    firstnameController.text = Preferences.firstName;
    lastnameController.text = Preferences.lastName;
    passwordController.text =
        EncrypterTool.decryptData(Preferences.password, null);
    phoneController.text = Preferences.phone.isNotEmpty
        ? Preferences.phone.toString().substring(3)
        : '';
    mailController.text = Preferences.mail;
    passwordMailController.text = Preferences.passwordMail.isNotEmpty
        ? EncrypterTool.decryptData(Preferences.passwordMail, null)
        : '';
    if (Preferences.birthDate.isNotEmpty) {
      dateController.text = Preferences.birthDate;
      changeDate = true;
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
    final usuario = ref.watch(userProvider);

    return Scaffold(
      floatingActionButton: screenWidth < 800
          ? null
          : SizedBox(
              height: 35,
              width: 120,
              child: Buttons.commonButton(
                  isLoading: isSaving,
                  onPressed: (canChangedKey || canChangedKeyMail)
                      ? null
                      : () async {
                          setState(() => isSaving = true);
                          await updateUser.call(usuario.id);
                          setState(() => isSaving = false);
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
              TextStyles.titlePagText(
                  text: "Perfil", color: Theme.of(context).primaryColor),
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
                                    text: Preferences.rol,
                                    size: 14,
                                    color: Utility.getColorTypeUser(
                                        Preferences.rol),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormFieldCustom.textFormFieldwithBorder(
                                name: "Nombre de usuario",
                                controller: usernameController,
                                textInputAction: TextInputAction.next,
                              ),
                              const SizedBox(height: 6),
                              SizedBox(
                                width: double.infinity,
                                child: Wrap(
                                  runSpacing: 5,
                                  spacing: 10,
                                  children: [
                                    TextFormFieldCustom.textFormFieldwithBorder(
                                      name: "Nombre",
                                      controller: firstnameController,
                                      textInputAction: TextInputAction.next,
                                      isRequired: false,
                                    ),
                                    TextFormFieldCustom.textFormFieldwithBorder(
                                      name: "Apellido",
                                      controller: lastnameController,
                                      textInputAction: TextInputAction.done,
                                      isRequired: false,
                                    ),
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
                                  // changed: !changeDate,
                                  onChanged: () {
                                    setState(() {
                                      changeDate = true;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(height: 5),
                              ChangePasswordWidget(
                                passwordController: passwordController,
                                isChanged: (value) =>
                                    setState(() => canChangedKey = value),
                                userId: usuario.id,
                                isPasswordMail: false,
                              ),
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
                                      isRequired: true,
                                      controller: phoneController,
                                      isNumeric: true,
                                      textInputAction: TextInputAction.next,
                                      validator: (p0) {
                                        if (p0 != null &&
                                            p0.isNotEmpty &&
                                            p0.length > 10) {
                                          return "Número no valido";
                                        }

                                        if (p0 != null &&
                                            p0.isNotEmpty &&
                                            p0.length < 10) {
                                          return "Número no valido";
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormFieldCustom.textFormFieldwithBorder(
                                      name: "Correo electrónico",
                                      controller: mailController,
                                      textInputAction: TextInputAction.done,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              ChangePasswordWidget(
                                passwordController: passwordMailController,
                                isChanged: (value) =>
                                    setState(() => canChangedKeyMail = value),
                                userId: usuario.id,
                                isPasswordMail: true,
                              ),
                              const SizedBox(height: 7),
                              if (screenWidth < 800)
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    height: 35,
                                    width: 120,
                                    child: Buttons.commonButton(
                                        isLoading: isSaving,
                                        onPressed: (canChangedKey ||
                                                canChangedKeyMail)
                                            ? null
                                            : () async {
                                                setState(() => isSaving = true);
                                                await updateUser
                                                    .call(usuario.id);
                                                setState(
                                                    () => isSaving = false);
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

  Future updateUser(int userId) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (usernameController.text.isEmpty) {
      showSnackBar(
          context: context,
          title: "Error de actualización",
          message:
              "No se puede actualizar ningun dato sin el nombre del usuario.",
          type: 'danger');
      return;
    }

    User usuario = User(
      id: userId,
      name: usernameController.text,
      firstName: firstnameController.text,
      secondName: lastnameController.text,
      birthDate: changeDate ? dateController.text : '',
      mail: mailController.text,
      phone: "+52${phoneController.text}",
    );

    if (await AuthService().updateUser(usuario)) {
      showSnackBar(
          context: context,
          title: "Error de actualización",
          message:
              "No se proceso el cambio de contraseña de correo correctamente",
          type: 'danger');
      return;
    }

    Preferences.birthDate = dateController.text;
    Preferences.username = usernameController.text;
    Preferences.firstName = firstnameController.text;
    Preferences.lastName = lastnameController.text;
    Preferences.mail = mailController.text;
    Preferences.phone = "+52${phoneController.text}";

    showSnackBar(
        context: context,
        title: "Perfil actualizado",
        message: "Se actualizaron los campos solicitados.",
        type: 'success');
  }
}
