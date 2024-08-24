import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/services/auth_service.dart';
import 'package:generador_formato/ui/show_snackbar.dart';
import 'package:generador_formato/utils/encrypt/encrypter.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/widgets/change_password_widget.dart';
import 'package:generador_formato/widgets/custom_dropdown.dart';
import 'package:generador_formato/widgets/form_widgets.dart';
import 'package:generador_formato/widgets/number_input_with_increment_decrement.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:generador_formato/widgets/textformfield_custom.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';

import '../utils/helpers/constants.dart';
import '../models/habitacion_model.dart';

class Dialogs {
  Widget habitacionDialog({
    required BuildContext buildContext,
    Habitacion? cotizacion,
    void Function(Habitacion?)? onInsert,
    void Function(Habitacion?)? onUpdate,
  }) {
    Habitacion nuevaHabitacion = cotizacion ??
        Habitacion(
          categoria: categorias.first,
          plan: planes.first,
          fechaCheckIn: DateTime.now().toString().substring(0, 10),
          adultos: 0,
          menores0a6: 0,
          menores7a12: 0,
          paxAdic: 0,
        );
    final _formKeyHabitacion = GlobalKey<FormState>();
    TextEditingController _fechaEntrada = TextEditingController(
        text: cotizacion != null
            ? cotizacion.fechaCheckIn
            : DateTime.now().toString().substring(0, 10));
    TextEditingController _fechaSalida = TextEditingController(
        text: cotizacion != null
            ? cotizacion.fechaCheckOut
            : DateTime.now()
                .add(const Duration(days: 1))
                .toString()
                .substring(0, 10));
    bool esOferta = cotizacion != null ? cotizacion.esPreventa! : false;
    bool isError = false;

    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        insetPadding: const EdgeInsets.all(10),
        title: TextStyles.titleText(
          text: cotizacion != null ? "Editar" : "Agregar" " habitación",
          color: Theme.of(context).primaryColor,
        ),
        content: SingleChildScrollView(
          child: Form(
            key: _formKeyHabitacion,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: TextStyles.standardText(
                      text: "Categoría: ",
                      overClip: true,
                      color: Theme.of(context).primaryColor,
                    )),
                    const SizedBox(width: 15),
                    CustomDropdown.dropdownMenuCustom(
                        initialSelection: cotizacion != null
                            ? cotizacion.categoria!
                            : categorias.first,
                        onSelected: (String? value) {
                          nuevaHabitacion.categoria = value!;
                        },
                        elements: categorias,
                        screenWidth: MediaQuery.of(context).size.width),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: TextStyles.standardText(
                      text: "Plan: ",
                      overClip: true,
                      color: Theme.of(context).primaryColor,
                    )),
                    const SizedBox(width: 15),
                    CustomDropdown.dropdownMenuCustom(
                      initialSelection:
                          cotizacion != null ? cotizacion.plan! : planes.first,
                      onSelected: (String? value) {
                        nuevaHabitacion.plan = value!;
                      },
                      elements: planes,
                      screenWidth: MediaQuery.of(context).size.width,
                      removeItem: "PLAN SIN ALIMENTOS",
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child:
                          TextFormFieldCustom.textFormFieldwithBorderCalendar(
                        name: "Fecha de entrada",
                        msgError: "Campo requerido*",
                        fechaLimite: DateTime.now()
                            .subtract(const Duration(days: 1))
                            .toIso8601String()
                            .substring(0, 10),
                        dateController: _fechaEntrada,
                        onChanged: () => setState(
                          () {
                            _fechaSalida.text =
                                Utility.getNextDay(_fechaEntrada.text);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child:
                          TextFormFieldCustom.textFormFieldwithBorderCalendar(
                        name: "Fecha de salida",
                        msgError: "Campo requerido*",
                        dateController: _fechaSalida,
                        fechaLimite: _fechaEntrada.text,
                      ),
                    ),
                  ],
                ),
                Table(
                  children: [
                    TableRow(children: [
                      TextStyles.standardText(
                          text: "Adultos",
                          aling: TextAlign.center,
                          color: Theme.of(context).primaryColor),
                      TextStyles.standardText(
                          text: "Menores 0-6",
                          aling: TextAlign.center,
                          color: Theme.of(context).primaryColor),
                      TextStyles.standardText(
                          text: "Menores 7-12",
                          aling: TextAlign.center,
                          color: Theme.of(context).primaryColor),
                    ]),
                    TableRow(children: [
                      NumberInputWithIncrementDecrement(
                        onChanged: (p0) {
                          nuevaHabitacion.adultos = int.tryParse(p0);
                        },
                        initialValue: cotizacion?.adultos!.toString(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: NumberInputWithIncrementDecrement(
                          onChanged: (p0) {
                            nuevaHabitacion.menores0a6 = int.tryParse(p0);
                          },
                          initialValue: cotizacion?.menores0a6!.toString(),
                        ),
                      ),
                      NumberInputWithIncrementDecrement(
                        onChanged: (p0) {
                          nuevaHabitacion.menores7a12 = int.tryParse(p0);
                        },
                        initialValue: cotizacion?.menores7a12!.toString(),
                      )
                    ]),
                  ],
                ),
                SizedBox(
                    height: 16,
                    child: isError
                        ? TextStyles.errorText(
                            text:
                                "Se requiere de al menos un adulto para generar la reservación",
                            size: 12)
                        : null),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                if (_formKeyHabitacion.currentState!.validate()) {
                  nuevaHabitacion.fechaCheckIn = _fechaEntrada.text;
                  nuevaHabitacion.fechaCheckOut = _fechaSalida.text;
                  nuevaHabitacion.esPreventa = esOferta;
                  if (nuevaHabitacion.adultos == 0) {
                    setState(() => isError = true);
                    return;
                  } else {
                    setState(() => isError = false);
                  }

                  if (onUpdate != null) {
                    onUpdate.call(nuevaHabitacion);
                  }

                  Navigator.of(buildContext).pop(nuevaHabitacion);
                }
              },
              child: TextStyles.buttonText(
                  text: cotizacion != null ? "Editar" : "Agregar")),
          TextButton(
            onPressed: () {
              Navigator.pop(buildContext);
            },
            child: TextStyles.buttonText(text: "Cancelar"),
          ),
        ],
      );
    });
  }

  static Widget tarifaFormDialog({
    required BuildContext context,
    Habitacion? habitacion,
    void Function(Habitacion?)? onInsert,
    void Function(Habitacion?)? onUpdate,
  }) {
    //data Quote
    String type = tipoHabitacion.first;
    String plan = planes.first;

    final _formKeyHabitacion = GlobalKey<FormState>();
    TextEditingController _fechaEntrada = TextEditingController(
        text: habitacion != null
            ? habitacion.fechaCheckIn
            : DateTime.now().toString().substring(0, 10));
    TextEditingController _fechaSalida = TextEditingController(
        text: habitacion != null
            ? habitacion.fechaCheckOut
            : DateTime.now()
                .add(const Duration(days: 1))
                .toString()
                .substring(0, 10));
    TextEditingController _adults1_2Controller = TextEditingController();
    TextEditingController _adults3Controller = TextEditingController();
    TextEditingController _adults4Controller = TextEditingController();
    TextEditingController _minors7_12Controller = TextEditingController();

    return AlertDialog(
      insetPadding: const EdgeInsets.all(10),
      title: TextStyles.titleText(
          text: habitacion != null ? "Editar tarifa" : "Agregar tarifa",
          color: Theme.of(context).primaryColor),
      content: StatefulBuilder(
        builder: (context, setState) {
          return SingleChildScrollView(
            child: Form(
              key: _formKeyHabitacion,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child:
                            TextFormFieldCustom.textFormFieldwithBorderCalendar(
                          name: "Fecha de entrada",
                          msgError: "Campo requerido*",
                          fechaLimite: DateTime.now()
                              .subtract(const Duration(days: 1))
                              .toIso8601String()
                              .substring(0, 10),
                          dateController: _fechaEntrada,
                          onChanged: () => setState(
                            () {
                              _fechaSalida.text =
                                  Utility.getNextDay(_fechaEntrada.text);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child:
                            TextFormFieldCustom.textFormFieldwithBorderCalendar(
                          name: "Fecha de salida",
                          msgError: "Campo requerido*",
                          dateController: _fechaSalida,
                          fechaLimite: _fechaEntrada.text,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: TextStyles.standardText(
                              text: "Categoría: ",
                              overClip: true,
                              color: Theme.of(context).primaryColor)),
                      const SizedBox(width: 15),
                      CustomDropdown.dropdownMenuCustom(
                          initialSelection:
                              habitacion != null ? habitacion.categoria! : type,
                          onSelected: (String? value) {
                            type = value!;
                          },
                          elements: tipoHabitacion,
                          screenWidth: MediaQuery.of(context).size.width),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextStyles.titleText(
                        text: "Tarífas:",
                        size: 15,
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FormWidgets.textFormFieldResizable(
                          name: "SGL/DBL",
                          isDecimal: true,
                          isNumeric: true,
                          isMoneda: true,
                          controller: _adults1_2Controller,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FormWidgets.textFormFieldResizable(
                          name: "PAX ADIC",
                          isDecimal: true,
                          isNumeric: true,
                          isMoneda: true,
                          controller: _adults3Controller,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: FormWidgets.textFormFieldResizable(
                          name: "TPL",
                          isDecimal: true,
                          isNumeric: true,
                          isMoneda: true,
                          blocked: true,
                          controller: _adults4Controller,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FormWidgets.textFormFieldResizable(
                          name: "CPLE",
                          isDecimal: true,
                          isNumeric: true,
                          isMoneda: true,
                          blocked: true,
                          controller: _minors7_12Controller,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: FormWidgets.textFormFieldResizable(
                          name: "MENORES 7 A 12 AÑOS",
                          isDecimal: true,
                          isNumeric: true,
                          isMoneda: true,
                          controller: _adults1_2Controller,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FormWidgets.textFormFieldResizable(
                          name: "MENORES 0 A 6 AÑOS",
                          isDecimal: true,
                          initialValue: "GRATIS",
                          isNumeric: true,
                          // isMoneda: true,
                          blocked: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      ),
      actions: [
        TextButton(
            onPressed: () {
              if (!_formKeyHabitacion.currentState!.validate()) {
                return;
              }

              // Cotizacion cotGrup = CotizacionGrupal();
              // cotGrup.categoria = type;
              // cotGrup.plan = plan;
              // cotGrup.fechaEntrada = _fechaEntrada.text;
              // cotGrup.fechaSalida = _fechaSalida.text;
              // cotGrup.tarifaAdulto1_2 = double.parse(_adults1_2Controller.text);
              // cotGrup.tarifaAdulto3 = double.parse(_adults3Controller.text);
              // cotGrup.tarifaAdulto4 = double.parse(_adults4Controller.text);
              // cotGrup.tarifaMenor = double.parse(_minors7_12Controller.text);

              // if (onInsert != null) {
              //   onInsert.call(cotGrup);
              // }

              // if (onUpdate != null) {
              //   onUpdate.call(cotGrup);
              // }

              Navigator.of(context).pop();
            },
            child: TextStyles.buttonText(
                text: habitacion != null ? "Editar" : "Agregar")),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: TextStyles.buttonText(text: "Cancelar"))
      ],
    );
  }

  Widget userFormDialog({
    required BuildContext buildContext,
    UsuarioData? usuario,
    void Function(UsuarioData?)? onInsert,
    void Function(UsuarioData?)? onUpdate,
  }) {
    String rol = roles.first;
    bool inProcess = false;

    final _formKeyUsuario = GlobalKey<FormState>();
    final TextEditingController nameController =
        TextEditingController(text: usuario != null ? usuario.nombre : '');
    final TextEditingController mailController = TextEditingController(
        text: usuario != null ? usuario.correoElectronico : '');
    final TextEditingController passwordNewController = TextEditingController();
    final TextEditingController passwordConfirmController =
        TextEditingController();

    final TextEditingController passwordEditController = TextEditingController(
        text: usuario != null
            ? EncrypterTool.decryptData(usuario.password!, null)
            : '');

    final TextEditingController passwordMailEditController =
        TextEditingController(
            text: usuario != null
                ? (usuario.passwordCorreo != null &&
                        usuario.passwordCorreo!.isNotEmpty)
                    ? EncrypterTool.decryptData(usuario.passwordCorreo!, null)
                    : ''
                : '');
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        insetPadding: const EdgeInsets.all(10),
        title: TextStyles.titleText(
            text: usuario != null ? "Editar Usuario" : "Agregar Usuario",
            color: Theme.of(buildContext).primaryColor),
        content: SizedBox(
          width: 550,
          child: SingleChildScrollView(
            child: Form(
              key: _formKeyUsuario,
              child: Column(
                children: [
                  TextFormFieldCustom.textFormFieldwithBorder(
                    name: "Nombre de usuario",
                    controller: nameController,
                    validator: (value) {
                      if ((value == null || value.isEmpty)) {
                        return "Campo requirido*";
                      }

                      return null;
                    },
                  ),
                  if (usuario != null)
                    TextFormFieldCustom.textFormFieldwithBorder(
                      name: "Correo electrónico",
                      controller: mailController,
                      validator: (value) {
                        if ((value == null || value.isEmpty)) {
                          return "Campo requirido*";
                        }

                        return null;
                      },
                    ),
                  if (usuario != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ChangePasswordWidget(
                                passwordController: passwordEditController,
                                isChanged: (value) {},
                                userId: usuario.id,
                                username: usuario.username,
                                isPasswordMail: false,
                                notAskChange:
                                    passwordEditController.text.isEmpty,
                              ),
                            ),
                            const SizedBox(width: 10),
                            if (usuario != null &&
                                passwordMailEditController.text.isEmpty)
                              Expanded(
                                child:
                                    TextFormFieldCustom.textFormFieldwithBorder(
                                  name: "Contraseña de correo",
                                  passwordVisible: true,
                                  isPassword: true,
                                  controller: passwordMailEditController,
                                  validator: (p0) {
                                    if (p0 == null ||
                                        p0.isEmpty ||
                                        p0.length < 4) {
                                      return "La contraseña debe de tener al menos 4 caracteres*";
                                    }
                                    return null;
                                  },
                                ),
                              )
                            else
                              Expanded(
                                child: ChangePasswordWidget(
                                  passwordController:
                                      passwordMailEditController,
                                  isChanged: (value) {},
                                  userId: usuario.id,
                                  username: usuario.username,
                                  isPasswordMail: true,
                                  notAskChange:
                                      passwordMailEditController.text.isEmpty,
                                ),
                              ),
                          ]),
                    ),
                  if (usuario == null)
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextFormFieldCustom.textFormFieldwithBorder(
                              name: "Contraseña",
                              passwordVisible: true,
                              isPassword: true,
                              controller: passwordNewController,
                              validator: (p0) {
                                if (p0 == null || p0.isEmpty || p0.length < 4) {
                                  return "La contraseña debe de tener al menos 4 caracteres*";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormFieldCustom.textFormFieldwithBorder(
                              name: "Confirmar contraseña",
                              isPassword: true,
                              passwordVisible: true,
                              controller: passwordConfirmController,
                              validator: (p0) {
                                if (passwordNewController.text.length > 0) {
                                  if (p0 == null ||
                                      p0.isEmpty ||
                                      p0 != passwordNewController.text) {
                                    return "La contraseña debe ser la misma*";
                                  }
                                }
                                return null;
                              },
                            ),
                          ),
                        ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextStyles.standardText(
                          text: "Rol del usuario: ",
                          overClip: true,
                          color: Theme.of(context).primaryColor),
                      const SizedBox(width: 15),
                      CustomDropdown.dropdownMenuCustom(
                        initialSelection: usuario != null ? usuario.rol! : rol,
                        onSelected: (String? value) {
                          rol = value!;
                        },
                        elements: roles,
                        screenWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (!_formKeyUsuario.currentState!.validate()) {
                return;
              }

              setState(() => inProcess = true);

              if (await AuthService().foundUserName(nameController.text)) {
                showSnackBar(
                    context: buildContext,
                    title: "Nombre no valido",
                    message:
                        "Este usuario ya existe, cambie el nombre de usuario",
                    type: "alert");
                setState(() => inProcess = false);
                return;
              }

              UsuarioData user = usuario != null
                  ? UsuarioData(
                      id: usuario.id,
                      username: nameController.text,
                      correoElectronico: mailController.text,
                      passwordCorreo: EncrypterTool.encryptData(
                          passwordMailEditController.text, null),
                      rol: rol,
                    )
                  : UsuarioData(
                      id: 0,
                      username: nameController.text,
                      password: EncrypterTool.encryptData(
                          passwordNewController.text, null),
                      rol: rol,
                    );

              if (onInsert != null) {
                onInsert.call(user);
              }

              if (onUpdate != null) {
                onUpdate.call(user);
              }
              setState(() => inProcess = false);

              Navigator.of(buildContext).pop();
            },
            child: inProcess
                ? const SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(),
                  )
                : TextStyles.buttonText(
                    text: usuario != null ? "Editar" : "Agregar",
                  ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(buildContext);
            },
            child: TextStyles.buttonText(text: "Cancelar"),
          ),
        ],
      );
    });
  }

  static AlertDialog customAlertDialog({
    IconData? iconData,
    Color? iconColor,
    required BuildContext context,
    required String title,
    required String content,
    String? contentBold,
    required String nameButtonMain,
    required VoidCallback funtionMain,
    required String nameButtonCancel,
    required bool withButtonCancel,
  }) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      title: Row(children: [
        if (iconData != null)
          Icon(
            iconData,
            size: 33,
            color: iconColor ?? DesktopColors.ceruleanOscure,
          ),
        const SizedBox(width: 10),
        Expanded(
            child: TextStyles.titleText(
                text: title, size: 18, color: Theme.of(context).primaryColor))
      ]),
      content: TextStyles.TextAsociative(contentBold ?? "", content,
          isInverted: contentBold != null,
          color: Theme.of(context).primaryColor),
      actions: [
        if (withButtonCancel)
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: TextStyles.buttonText(text: nameButtonCancel)),
        TextButton(
          onPressed: () {
            funtionMain.call();
            Navigator.of(context).pop(true);
          },
          child: TextStyles.buttonText(
            text: nameButtonMain,
          ),
        ),
      ],
    );
  }

  static AlertDialog taridaAlertDialog({
    IconData? iconData,
    Color? iconColor,
    required BuildContext context,
    required String title,
    String? contentBold,
    required String nameButtonMain,
    required VoidCallback funtionMain,
    required String nameButtonCancel,
    required bool withButtonCancel,
  }) {
    String tarifaSelect = "Mayo - Abril";
    TextEditingController _tarifaAdulto = TextEditingController(text: "0");
    TextEditingController _tarifaMenores = TextEditingController(text: "0");
    TextEditingController _tarifaPaxAdicional =
        TextEditingController(text: "0");

    return AlertDialog(
      //  insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      title: Row(children: [
        if (iconData != null)
          Icon(
            iconData,
            size: 33,
            color: iconColor ?? DesktopColors.ceruleanOscure,
          ),
        const SizedBox(width: 10),
        Expanded(
            child: TextStyles.titleText(
                text: title, size: 16, color: Theme.of(context).primaryColor))
      ]),
      content: StatefulBuilder(builder: (context, snapshot) {
        return SizedBox(
          height: 465,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextStyles.standardText(
                      text: "Periodo: ",
                      overClip: true,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 10),
                    CustomDropdown.dropdownMenuCustom(
                      initialSelection: tarifaSelect,
                      onSelected: (String? value) {
                        tarifaSelect = value!;
                      },
                      elements: [
                        'Mayo - Abril',
                        'Junio - Julio',
                        'Agosto - Septiembre',
                        'Octubre - Noviembre'
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextStyles.standardText(
                      text: "Temporada: ",
                      overClip: true,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 10),
                    CustomDropdown.dropdownMenuCustom(
                      initialSelection: tarifaSelect,
                      onSelected: (String? value) {
                        tarifaSelect = value!;
                      },
                      elements: [
                        'Mayo - Abril',
                        'Junio - Julio',
                        'Agosto - Septiembre',
                        'Octubre - Noviembre'
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormFieldCustom.textFormFieldwithBorder(
                  name: "Tarifa adulto SGL/DBL",
                  isMoneda: true,
                  isNumeric: true,
                  isDecimal: true,
                  controller: _tarifaAdulto,
                  onChanged: (p0) => snapshot(() {}),
                ),
                const SizedBox(height: 12),
                Opacity(
                  opacity: 0.6,
                  child: TextFormFieldCustom.textFormFieldwithBorder(
                    name: "Tarifa adulto TPL",
                    isMoneda: true,
                    isNumeric: true,
                    isDecimal: true,
                    blocked: true,
                    controller: TextEditingController(
                      text: Utility.calculateRate(
                          _tarifaAdulto, _tarifaPaxAdicional, 1),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Opacity(
                  opacity: 0.6,
                  child: TextFormFieldCustom.textFormFieldwithBorder(
                    name: "Tarifa adulto CPLE",
                    isMoneda: true,
                    isNumeric: true,
                    isDecimal: true,
                    blocked: true,
                    controller: TextEditingController(
                      text: Utility.calculateRate(
                          _tarifaAdulto, _tarifaPaxAdicional, 2),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormFieldCustom.textFormFieldwithBorder(
                  name: "Tarifa Menores 7 a 12 años",
                  isMoneda: true,
                  isNumeric: true,
                  isDecimal: true,
                  controller: _tarifaMenores,
                ),
                const SizedBox(height: 12),
                TextFormFieldCustom.textFormFieldwithBorder(
                  name: "Tarifa Pax Adicional",
                  isMoneda: true,
                  isNumeric: true,
                  isDecimal: true,
                  controller: _tarifaPaxAdicional,
                  onChanged: (p0) => snapshot(() {}),
                ),
              ],
            ),
          ),
        );
      }),
      actions: [
        if (withButtonCancel)
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: TextStyles.buttonText(text: nameButtonCancel)),
        TextButton(
          onPressed: () {
            funtionMain.call();
            Navigator.of(context).pop(true);
          },
          child: TextStyles.buttonText(
            text: nameButtonMain,
          ),
        ),
      ],
    );
  }

  static AlertDialog filterDateDialog({
    required BuildContext context,
    required VoidCallback funtionMain,
  }) {
    final TextEditingController _initDateController = TextEditingController(
        text: DateTime.now()
            .subtract(const Duration(days: 30))
            .toIso8601String()
            .substring(0, 10));
    final TextEditingController _endDateController = TextEditingController(
        text: DateTime.now().toIso8601String().substring(0, 10));

    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      title: Row(children: [
        Icon(
          Icons.date_range_outlined,
          size: 33,
          color: DesktopColors.ceruleanOscure,
        ),
        const SizedBox(width: 10),
        Expanded(
            child: TextStyles.titleText(
          text: "Filtrar por fechas",
          color: Theme.of(context).primaryColor,
          size: 18,
        ))
      ]),
      content: StatefulBuilder(
        builder: (context, setState) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextStyles.standardText(
                    text: "Seleccione un periodo de tiempo:",
                    color: Theme.of(context).primaryColor),
                const SizedBox(height: 15),
                TextFormFieldCustom.textFormFieldwithBorderCalendar(
                  name: "Fecha inicial",
                  msgError: "",
                  esInvertido: true,
                  dateController: _initDateController,
                  onChanged: () => setState(
                    () => _endDateController.text =
                        Utility.getNextMonth(_initDateController.text),
                  ),
                ),
                TextFormFieldCustom.textFormFieldwithBorderCalendar(
                  name: "Fecha final",
                  msgError: "",
                  dateController: _endDateController,
                  fechaLimite: (_initDateController.text),
                )
              ],
            ),
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            funtionMain.call();
            Navigator.of(context)
                .pop(_initDateController.text + _endDateController.text);
          },
          child: TextStyles.buttonText(
            text: "Aceptar",
          ),
        ),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: TextStyles.buttonText(text: "Cancelar")),
      ],
    );
  }
}
