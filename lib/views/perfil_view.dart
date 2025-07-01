import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/imagen_model.dart';
import 'package:generador_formato/view-models/providers/usuario_provider.dart';
import 'package:generador_formato/view-models/services/auth_service.dart';
import 'package:generador_formato/res/ui/buttons.dart';
import 'package:generador_formato/utils/encrypt/encrypter.dart';
import 'package:generador_formato/utils/shared_preferences/preferences.dart';
import 'package:generador_formato/utils/widgets/change_password_widget.dart';
import 'package:generador_formato/utils/widgets/gestor_imagenes_widget.dart';
import 'package:generador_formato/utils/widgets/textformfield_custom.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import '../res/ui/custom_widgets.dart';
import '../res/ui/show_snackbar.dart';
import '../res/ui/title_page.dart';
import '../utils/shared_preferences/settings.dart';
import '../res/ui/text_styles.dart';

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
  bool isImplementImages = false;
  Imagen photoPeril = Imagen();

  @override
  void initState() {
    super.initState();
    usernameController.text = Preferences.username;
    firstnameController.text = Preferences.firstName;
    lastnameController.text = Preferences.lastName;
    passwordController.text =
        EncrypterTool.decryptData(Preferences.password, null);
    phoneController.text =
        Preferences.phone.isNotEmpty ? Preferences.phone : '';
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
    double screenWidth = MediaQuery.of(context).size.width;
    final usuario = ref.watch(userProvider);
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;
    final foundImageFile = ref.watch(foundImageFileProvider);

    Future submitData() async {
      setState(() => isSaving = true);
      await updateUser(usuario.id);
      setState(() => isSaving = false);
    }

    return Stack(
      children: [
        Scaffold(
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
                              await updateUser(usuario.id);
                              setState(() => isSaving = false);
                            },
                      text: "Guardar"),
                ).animate().fadeIn(
                    delay: !Settings.applyAnimations ? null : 150.ms,
                    duration: Settings.applyAnimations ? null : 0.ms,
                  ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: screenWidth < 800
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  const TitlePage(
                    title: "Perfil",
                    subtitle:
                        "Gestiona y personaliza la información de tu cuenta",
                  ).animate().fadeIn(
                        duration: Settings.applyAnimations ? null : 0.ms,
                      ),
                  const SizedBox(height: 5),
                  Form(
                    key: _formKey,
                    child: Wrap(
                      runSpacing: 15,
                      children: [
                        SizedBox(
                          width: screenWidth < 800
                              ? (widget.sideController.extended
                                  ? screenWidth * 0.8
                                  : 355)
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
                                  const SizedBox(height: 10),
                                  Center(
                                    child: CustomWidgets.itemMedal(
                                        usuario.rol!, brightness),
                                  ),
                                  const SizedBox(height: 7),
                                  GestorImagenes(
                                    imagenes: [photoPeril],
                                    isDialog: true,
                                    implementDirecty: true,
                                    blocked: isSaving,
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormFieldCustom.textFormFieldwithBorder(
                                    name: "Nombre de usuario",
                                    enabled: !isSaving,
                                    controller: usernameController,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (p0) async {
                                      submitData();
                                    },
                                  ),
                                  const SizedBox(height: 6),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Wrap(
                                      runSpacing: 5,
                                      spacing: 10,
                                      children: [
                                        TextFormFieldCustom
                                            .textFormFieldwithBorder(
                                          name: "Nombre",
                                          enabled: !isSaving,
                                          controller: firstnameController,
                                          textInputAction: TextInputAction.next,
                                          isRequired: false,
                                          onFieldSubmitted: (p0) async {
                                            submitData();
                                          },
                                        ),
                                        TextFormFieldCustom
                                            .textFormFieldwithBorder(
                                          name: "Apellido",
                                          enabled: !isSaving,
                                          controller: lastnameController,
                                          textInputAction: TextInputAction.done,
                                          isRequired: false,
                                          onFieldSubmitted: (p0) async {
                                            submitData();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    width: double.infinity,
                                    child: TextFormFieldCustom
                                        .textFormFieldwithBorderCalendar(
                                      readOnly: true,
                                      name: "Fecha de nacimiento",
                                      msgError: "Campo requerido*",
                                      dateController: dateController,
                                      nowLastYear: true,
                                      enabled: !isSaving,
                                      fechaLimite: "1900-01-01",
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
                                    username: usuario.username ?? '',
                                    isPasswordMail: false,
                                    enable: !isSaving,
                                  ),
                                  const SizedBox(height: 7),
                                ],
                              ),
                            ),
                          ).animate().fadeIn(
                                delay:
                                    !Settings.applyAnimations ? null : 350.ms,
                                duration:
                                    Settings.applyAnimations ? null : 0.ms,
                              ),
                        ),
                        SizedBox(
                          width: screenWidth < 800
                              ? (widget.sideController.extended
                                  ? screenWidth * 0.8
                                  : 355)
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
                                        TextFormFieldCustom
                                            .textFormFieldwithBorder(
                                          name: "Teléfono",
                                          isRequired: true,
                                          controller: phoneController,
                                          onFieldSubmitted: (p0) async {
                                            submitData();
                                          },
                                          enabled: !isSaving,
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
                                        TextFormFieldCustom
                                            .textFormFieldwithBorder(
                                          name: "Correo electrónico",
                                          controller: mailController,
                                          enabled: !isSaving,
                                          isRequired: false,
                                          textInputAction: TextInputAction.done,
                                          onFieldSubmitted: (p0) async {
                                            submitData();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  ChangePasswordWidget(
                                    passwordController: passwordMailController,
                                    isChanged: (value) => setState(
                                        () => canChangedKeyMail = value),
                                    userId: usuario.id,
                                    username: usuario.username ?? '',
                                    isPasswordMail: true,
                                    enable: !isSaving,
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
                                                    setState(
                                                        () => isSaving = true);
                                                    await updateUser(
                                                        usuario.id);
                                                    setState(
                                                        () => isSaving = false);
                                                  },
                                            text: "Guardar"),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ).animate().fadeIn(
                                delay:
                                    !Settings.applyAnimations ? null : 550.ms,
                                duration:
                                    Settings.applyAnimations ? null : 0.ms,
                              ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        if (foundImageFile)
          ModalBarrier(
            dismissible: false,
            color: Colors.black.withOpacity(0.5),
          ),
      ],
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

    if (await AuthService().getUser(usernameController.text, userId)) {
      showSnackBar(
        type: "alert",
        context: context,
        title: "Usuario ya existente",
        message:
            "No se puede registrar el nombre: '${usernameController.text}' porque ya esta siendo utilizado.",
      );
      usernameController.text = Preferences.username;
      return;
    }

    UsuarioTableData usuario = UsuarioTableData(
      id: userId,
      username: usernameController.text,
      nombre: firstnameController.text,
      apellido: lastnameController.text,
      fechaNacimiento: changeDate ? dateController.text : '',
      correoElectronico: mailController.text,
      telefono: phoneController.text,
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
    Preferences.phone = phoneController.text;

    showSnackBar(
        context: context,
        title: "Perfil actualizado",
        message: "Se actualizaron los campos solicitados.",
        type: 'success');
  }
}
