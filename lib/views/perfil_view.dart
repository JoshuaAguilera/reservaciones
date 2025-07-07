import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sidebarx/sidebarx.dart';

import '../models/imagen_model.dart';
import '../models/usuario_model.dart';
import '../res/helpers/animation_helpers.dart';
import '../res/helpers/format_helpers.dart';
import '../res/helpers/functions_ui.dart';
import '../res/ui/buttons.dart';
import '../res/ui/custom_widgets.dart';
import '../res/ui/title_page.dart';
import '../utils/shared_preferences/preferences.dart';
import '../res/ui/text_styles.dart';
import '../utils/widgets/change_password_widget.dart';
import '../utils/widgets/gestor_imagenes_widget.dart';
import '../utils/widgets/textformfield_custom.dart';
import '../view-models/providers/usuario_provider.dart';

class PerfilView extends ConsumerStatefulWidget {
  const PerfilView({super.key, required this.sideController});

  final SidebarXController sideController;
  @override
  ConsumerState<PerfilView> createState() => _PerfilViewState();
}

class _PerfilViewState extends ConsumerState<PerfilView> {
  final TextEditingController dateController = TextEditingController(
    text: DateTime.now().toString().substring(0, 10),
  );
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
  Imagen photoPeril = Imagen();

  @override
  void initState() {
    super.initState();
    var user = ref.read(userProvider);
    _fillForm(user);
  }

  void _fillForm(Usuario? usuario) {
    usernameController.text = usuario?.username ?? Preferences.username;
    firstnameController.text = usuario?.nombre ?? Preferences.firstName;
    lastnameController.text = usuario?.apellido ?? Preferences.lastName;
    phoneController.text = usuario?.telefono ?? Preferences.phone;
    mailController.text = usuario?.correoElectronico ?? Preferences.mail;
    dateController.text = Preferences.birthDate;
  }

  Future<void> updateUser([int? userId = 0]) async {
    // if (!_formKey.currentState!.validate()) return;
    applyUnfocus();
    setState(() => isSaving = true);

    Usuario workUser = Usuario();
    workUser.idInt = userId;
    workUser.username = FormatHelpers.emptyToNull(usernameController.text);
    workUser.nombre = FormatHelpers.emptyToNull(firstnameController.text);
    workUser.apellido = FormatHelpers.emptyToNull(lastnameController.text);
    workUser.fechaNacimiento = DateTime.tryParse(dateController.text);
    workUser.correoElectronico = FormatHelpers.emptyToNull(mailController.text);
    workUser.telefono = FormatHelpers.emptyToNull(phoneController.text);

    ref.read(usuarioProvider.notifier).state = workUser;
    final response = await ref.read(saveUserProvider.future);
    setState(() => isSaving = false);
    if (response.item1) ref.read(usuarioProvider.notifier).state = null;
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
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;
    final usuario = ref.watch(userProvider);
    final foundImageFile = ref.watch(foundImageFileProvider);

    Future submitData() async => await updateUser(usuario?.idInt);

    Widget saveButton() {
      return AnimatedEntry(
        duration: const Duration(milliseconds: 0),
        child: SizedBox(
          height: 35,
          width: 120,
          child: Buttons.buttonPrimary(
            isLoading: isSaving,
            onPressed: (canChangedKey || canChangedKeyMail)
                ? () async => await submitData()
                : null,
            enable: (canChangedKey || canChangedKeyMail),
            text: "Guardar",
          ),
        ),
      );
    }

    return Stack(
      children: [
        Scaffold(
          floatingActionButton: screenWidth < 800 ? null : saveButton(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: SingleChildScrollView(
              child: Column(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: screenWidth < 800
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  const TitlePage(
                    title: "Perfil",
                    subtitle:
                        "Gestiona y personaliza la información de tu cuenta",
                  ),
                  Form(
                    key: _formKey,
                    child: Wrap(
                      runSpacing: 15,
                      children: [
                        AnimatedEntry(
                          delay: 350.ms,
                          child: SizedBox(
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
                                  spacing: 10,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextStyles.standardText(
                                        isBold: true,
                                        text: "Información general",
                                        overClip: true,
                                        size: 16),
                                    Center(
                                      child: CustomWidgets.itemMedal(
                                          usuario?.rol?.nombre ?? '',
                                          brightness),
                                    ),
                                    GestorImagenes(
                                      imagenes: [photoPeril],
                                      isDialog: true,
                                      implementDirecty: true,
                                      blocked: isSaving,
                                    ),
                                    TextFormFieldCustom.textFormFieldwithBorder(
                                      name: "Nombre de usuario",
                                      enabled: !isSaving,
                                      controller: usernameController,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (p0) async {
                                        submitData();
                                      },
                                    ),
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
                                            textInputAction:
                                                TextInputAction.next,
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
                                            textInputAction:
                                                TextInputAction.done,
                                            isRequired: false,
                                            onFieldSubmitted: (p0) async {
                                              submitData();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
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
                                    ChangePasswordWidget(
                                      passwordController: passwordController,
                                      isChanged: (value) =>
                                          setState(() => canChangedKey = value),
                                      userId: usuario?.idInt ?? 0,
                                      username: usuario?.username ?? '',
                                      isPasswordMail: false,
                                      enable: !isSaving,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        AnimatedEntry(
                          delay: 550.ms,
                          child: SizedBox(
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
                                      size: 16,
                                    ),
                                    TextStyles.standardText(
                                      text:
                                          "Requerido para el envio del comprobante para cotización.",
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
                                            textInputAction:
                                                TextInputAction.next,
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
                                            textInputAction:
                                                TextInputAction.done,
                                            onFieldSubmitted: (p0) async {
                                              submitData();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    ChangePasswordWidget(
                                      passwordController:
                                          passwordMailController,
                                      isChanged: (value) => setState(
                                          () => canChangedKeyMail = value),
                                      userId: usuario?.idInt ?? 0,
                                      username: usuario?.username ?? '',
                                      isPasswordMail: true,
                                      enable: !isSaving,
                                    ),
                                    const SizedBox(height: 7),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  saveButton(),
                ],
              ),
            ),
          ),
        ),
        if (foundImageFile)
          ModalBarrier(
            dismissible: false,
            color: Colors.black.withValues(alpha: 0.5),
          ),
      ],
    );
  }
}
