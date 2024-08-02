import 'package:encrypt/encrypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/cotizacion_grupal_model.dart';
import 'package:generador_formato/services/auth_service.dart';
import 'package:generador_formato/ui/show_snackbar.dart';
import 'package:generador_formato/utils/encrypt/encrypter.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/widgets/change_password_widget.dart';
import 'package:generador_formato/widgets/custom_dropdown.dart';
import 'package:generador_formato/widgets/form_widgets.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:generador_formato/widgets/textformfield_custom.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
import 'package:generador_formato/widgets/number_input_with_increment_decrement.dart';

import '../utils/helpers/constants.dart';
import '../models/cotizacion_model.dart';

class Dialogs {
  Widget habitacionIndividualDialog({
    required BuildContext buildContext,
    Cotizacion? cotizacion,
    void Function(Cotizacion?)? onInsert,
    void Function(Cotizacion?)? onUpdate,
  }) {
    Cotizacion nuevaCotizacion = cotizacion ??
        Cotizacion(
          categoria: categorias.first,
          plan: planes.first,
          fechaEntrada: DateTime.now().toString().substring(0, 10),
          adultos: 0,
          menores0a6: 0,
          menores7a12: 0,
        );
    final _formKeyHabitacion = GlobalKey<FormState>();
    TextEditingController _fechaEntrada = TextEditingController(
        text: cotizacion != null
            ? cotizacion.fechaEntrada
            : DateTime.now().toString().substring(0, 10));
    TextEditingController _fechaSalida = TextEditingController(
        text: cotizacion != null
            ? cotizacion.fechaSalida
            : DateTime.now()
                .add(const Duration(days: 1))
                .toString()
                .substring(0, 10));
    bool esOferta = cotizacion != null ? cotizacion.esPreVenta! : false;
    bool isError = false;

    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        insetPadding: const EdgeInsets.all(10),
        title: TextStyles.titleText(
          text: cotizacion != null ? "Editar" : "Agregar" " cotización",
          color: Theme.of(context).primaryColor,
        ),
        content: SingleChildScrollView(
          child: Form(
            key: _formKeyHabitacion,
            child: Column(
              children: [
                CheckboxListTile.adaptive(
                  title: TextStyles.standardText(
                    text: "Cotización con preventa oferta de tiempo limitado",
                    color: Theme.of(context).primaryColor,
                  ),
                  value: esOferta,
                  onChanged: (value) {
                    setState(() {
                      esOferta = value!;
                    });
                    if (!value!) {
                      Future.delayed(Durations.medium1, () {
                        if (_formKeyHabitacion.currentState!.validate()) {}
                      });
                    }
                  },
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  contentPadding: const EdgeInsets.all(0),
                ),
                const SizedBox(height: 10),
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
                          nuevaCotizacion.categoria = value!;
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
                        nuevaCotizacion.plan = value!;
                      },
                      elements: planes,
                      screenWidth: MediaQuery.of(context).size.width,
                      removeItem: "PLAN SIN ALIMENTOS",
                    ),
                  ],
                ),
                const SizedBox(height: 10),
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
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(),
                      const SizedBox()
                    ]),
                    TableRow(children: [
                      NumberInputWithIncrementDecrement(
                        onChanged: (p0) => setState(
                            () => nuevaCotizacion.adultos = int.tryParse(p0)),
                        initialValue: cotizacion?.adultos!.toString(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          width: 150,
                          child: TextFormFieldCustom.textFormFieldwithBorder(
                              name: "Tarifa adulto",
                              msgError: "Campo requerido*",
                              isNumeric: true,
                              isDecimal: true,
                              isMoneda: true,
                              initialValue: cotizacion != null
                                  ? (nuevaCotizacion.tarifaRealAdulto ?? "")
                                      .toString()
                                  : null,
                              onChanged: (p0) => setState(() => nuevaCotizacion
                                  .tarifaRealAdulto = double.tryParse(p0)),
                              isRequired: nuevaCotizacion.adultos! > 0),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: TextFormFieldCustom.textFormFieldwithBorder(
                          name: "Tarifa preventa adulto",
                          msgError: "Campo requerido*",
                          isNumeric: true,
                          enabled: esOferta,
                          isRequired:
                              esOferta && (nuevaCotizacion.adultos! > 0),
                          isDecimal: true,
                          isMoneda: true,
                          initialValue: cotizacion != null
                              ? (cotizacion.tarifaPreventaAdulto ?? "")
                                  .toString()
                              : null,
                          onChanged: (p0) => setState(() => nuevaCotizacion
                              .tarifaPreventaAdulto = double.tryParse(p0)),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      TextStyles.standardText(
                        text: "Menores 7-12",
                        aling: TextAlign.center,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(),
                      const SizedBox()
                    ]),
                    TableRow(children: [
                      NumberInputWithIncrementDecrement(
                        onChanged: (p0) => setState(() =>
                            nuevaCotizacion.menores7a12 = int.tryParse(p0)),
                        initialValue: cotizacion?.menores7a12!.toString(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          width: 150,
                          child: TextFormFieldCustom.textFormFieldwithBorder(
                              name: "Tarifa menores",
                              msgError: "Campo requerido*",
                              isNumeric: true,
                              isDecimal: true,
                              isMoneda: true,
                              initialValue: cotizacion != null
                                  ? (nuevaCotizacion.tarifaRealMenor ?? "")
                                      .toString()
                                  : null,
                              onChanged: (p0) => setState(() => nuevaCotizacion
                                  .tarifaRealMenor = double.tryParse(p0)),
                              isRequired: nuevaCotizacion.menores7a12! > 0),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: TextFormFieldCustom.textFormFieldwithBorder(
                          name: "Tarifa preventa menores",
                          msgError: "Campo requerido*",
                          isNumeric: true,
                          isDecimal: true,
                          isMoneda: true,
                          isRequired:
                              esOferta && (nuevaCotizacion.menores7a12! > 0),
                          enabled: esOferta,
                          initialValue: cotizacion != null
                              ? (cotizacion.tarifaPreventaMenor ?? "")
                                  .toString()
                              : null,
                          onChanged: (p0) => setState(() => nuevaCotizacion
                              .tarifaPreventaMenor = double.tryParse(p0)),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      TextStyles.standardText(
                        text: "Menores 0-6",
                        aling: TextAlign.center,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(),
                      const SizedBox()
                    ]),
                    TableRow(children: [
                      NumberInputWithIncrementDecrement(
                        onChanged: (p0) => setState(() =>
                            nuevaCotizacion.menores0a6 = int.tryParse(p0)),
                        initialValue: cotizacion?.menores0a6!.toString(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: SizedBox(
                          child: Center(
                            child: esOferta
                                ? TextStyles.standardText(
                                    aling: TextAlign.right,
                                    size: 15,
                                    overClip: true,
                                    text:
                                        "Tarifa preventa diaria: ${Utility.formatterNumber(Utility.calculateTarifaDiaria(cotizacion: nuevaCotizacion, esPreventa: true))}",
                                    isBold: true,
                                    color: Theme.of(context).primaryColor,
                                  )
                                : const SizedBox(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: SizedBox(
                          child: TextStyles.standardText(
                            aling: TextAlign.right,
                            size: 15,
                            overClip: true,
                            text:
                                "Tarifa real diaria: ${Utility.formatterNumber(Utility.calculateTarifaDiaria(cotizacion: nuevaCotizacion))}",
                            isBold: true,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                    ])
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
                  nuevaCotizacion.fechaEntrada = _fechaEntrada.text;
                  nuevaCotizacion.fechaSalida = _fechaSalida.text;
                  nuevaCotizacion.esPreVenta = esOferta;
                  if (nuevaCotizacion.adultos == 0) {
                    setState(() => isError = true);
                    return;
                  } else {
                    setState(() => isError = false);
                  }

                  if (onUpdate != null) {
                    onUpdate.call(nuevaCotizacion);
                  }

                  Navigator.of(buildContext).pop(nuevaCotizacion);
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

  Widget habitacionGrupoDialog({
    required BuildContext buildContext,
    CotizacionGrupal? cotizacion,
    void Function(CotizacionGrupal?)? onInsert,
    void Function(CotizacionGrupal?)? onUpdate,
    required BuildContext context,
  }) {
    //data Quote
    String type = tipoHabitacion.first;
    String plan = planes.first;

    final _formKeyHabitacion = GlobalKey<FormState>();
    TextEditingController _fechaEntrada = TextEditingController(
        text: cotizacion != null
            ? cotizacion.fechaEntrada
            : DateTime.now().toString().substring(0, 10));
    TextEditingController _fechaSalida = TextEditingController(
        text: cotizacion != null
            ? cotizacion.fechaSalida
            : DateTime.now()
                .add(const Duration(days: 1))
                .toString()
                .substring(0, 10));
    TextEditingController _adults1_2Controller = TextEditingController(
        text: cotizacion != null ? cotizacion.tarifaAdulto1_2.toString() : '');
    TextEditingController _adults3Controller = TextEditingController(
        text: cotizacion != null ? cotizacion.tarifaAdulto3.toString() : '');
    TextEditingController _adults4Controller = TextEditingController(
        text: cotizacion != null ? cotizacion.tarifaAdulto4.toString() : '');
    TextEditingController _minors7_12Controller = TextEditingController(
        text: cotizacion != null ? cotizacion.tarifaMenor.toString() : '');

    return AlertDialog(
      insetPadding: const EdgeInsets.all(10),
      title: TextStyles.titleText(
          text: cotizacion != null ? "Editar habitación" : "Agregar habitación",
          color: Theme.of(context).primaryColor),
      content: StatefulBuilder(
        builder: (context, setState) {
          return SingleChildScrollView(
            child: Form(
              key: _formKeyHabitacion,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: TextStyles.standardText(
                              text: "Tipo de habitacion: ",
                              overClip: true,
                              color: Theme.of(context).primaryColor)),
                      const SizedBox(width: 15),
                      CustomDropdown.dropdownMenuCustom(
                          initialSelection:
                              cotizacion != null ? cotizacion.categoria! : type,
                          onSelected: (String? value) {
                            type = value!;
                          },
                          elements: tipoHabitacion,
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
                            color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(width: 15),
                      CustomDropdown.dropdownMenuCustom(
                        initialSelection:
                            cotizacion != null ? cotizacion.plan! : plan,
                        onSelected: (String? value) {
                          plan = value!;
                        },
                        elements: planes,
                        screenWidth: MediaQuery.of(context).size.width,
                        removeItem: "SOLO HOSPEDAJE",
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextStyles.titleText(
                        text: "Tarífas:",
                        size: 15,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FormWidgets.textFormFieldResizable(
                          name: "1 O 2 ADULTOS",
                          isDecimal: true,
                          isNumeric: true,
                          isMoneda: true,
                          controller: _adults1_2Controller,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FormWidgets.textFormFieldResizable(
                          name: "3 ADULTOS",
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
                          name: "4 ADULTO",
                          isDecimal: true,
                          isNumeric: true,
                          isMoneda: true,
                          controller: _adults4Controller,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FormWidgets.textFormFieldResizable(
                          name: "MENORES 7 A 12 AÑOS",
                          isDecimal: true,
                          isNumeric: true,
                          isMoneda: true,
                          controller: _minors7_12Controller,
                        ),
                      ),
                    ],
                  ),
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

              CotizacionGrupal cotGrup = CotizacionGrupal();
              cotGrup.categoria = type;
              cotGrup.plan = plan;
              cotGrup.fechaEntrada = _fechaEntrada.text;
              cotGrup.fechaSalida = _fechaSalida.text;
              cotGrup.tarifaAdulto1_2 = double.parse(_adults1_2Controller.text);
              cotGrup.tarifaAdulto3 = double.parse(_adults3Controller.text);
              cotGrup.tarifaAdulto4 = double.parse(_adults4Controller.text);
              cotGrup.tarifaMenor = double.parse(_minors7_12Controller.text);

              if (onInsert != null) {
                onInsert.call(cotGrup);
              }

              if (onUpdate != null) {
                onUpdate.call(cotGrup);
              }

              Navigator.of(buildContext).pop();
            },
            child: TextStyles.buttonText(
                text: cotizacion != null ? "Editar" : "Agregar")),
        TextButton(
            onPressed: () {
              Navigator.pop(buildContext);
            },
            child: TextStyles.buttonText(text: "Cancelar"))
      ],
    );
  }

  Widget userFormDialog({
    required BuildContext buildContext,
    User? usuario,
    void Function(User?)? onInsert,
    void Function(User?)? onUpdate,
  }) {
    String rol = roles.first;
    bool inProcess = false;

    final _formKeyUsuario = GlobalKey<FormState>();
    final TextEditingController nameController =
        TextEditingController(text: usuario != null ? usuario.name : '');
    final TextEditingController mailController =
        TextEditingController(text: usuario != null ? usuario.mail : '');
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
                ? (usuario.passwordMail != null &&
                        usuario.passwordMail!.isNotEmpty)
                    ? EncrypterTool.decryptData(usuario.passwordMail!, null)
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
                                isPasswordMail: false,
                                notAskChange:
                                    passwordEditController.text.isEmpty,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ChangePasswordWidget(
                                passwordController: passwordMailEditController,
                                isChanged: (value) {},
                                userId: usuario.id,
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
                        initialSelection: rol,
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

              User usuario = User(
                id: 0,
                name: nameController.text,
                password:
                    EncrypterTool.encryptData(passwordNewController.text, null),
                rol: rol,
              );

              if (onInsert != null) {
                onInsert.call(usuario);
              }

              if (onUpdate != null) {
                onUpdate.call(usuario);
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
