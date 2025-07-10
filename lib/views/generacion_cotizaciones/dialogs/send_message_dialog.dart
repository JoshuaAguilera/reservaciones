import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/utils/shared_preferences/preferences.dart';
import 'package:generador_formato/utils/widgets/form_widgets.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../database/database.dart';
import '../../../view-models/services/cotizacion_service.dart';
import '../../../view-models/services/send_quote_service.dart';
import '../../../res/ui/buttons.dart';
import '../../../res/ui/inside_snackbar.dart';
import '../../../res/ui/title_page.dart';
import '../../../res/helpers/desktop_colors.dart';
import '../../../res/ui/text_styles.dart';
import '../../../utils/widgets/textformfield_custom.dart';

class SendMessageDialog extends StatefulWidget {
  const SendMessageDialog({
    super.key,
    required this.message,
    required this.nombreHuesped,
    required this.numberContact,
    required this.cotizacionId,
    this.saveFunction,
  });

  final String message;
  final String nombreHuesped;
  final String numberContact;
  final int cotizacionId;
  final void Function(String)? saveFunction;

  @override
  State<SendMessageDialog> createState() => _SendMessageDialogState();
}

class _SendMessageDialogState extends State<SendMessageDialog> {
  final _messageController = TextEditingController();
  TextEditingController _newNumberController = TextEditingController();
  bool inProcess = false;
  bool isSaving = false;
  bool isEditable = false;
  bool showMessage = false;
  bool withNumber = false;
  String typeMessage = "info";
  String snackMessage = "Mensaje copiado en el portapapeles.";
  final _formKeyMessage = GlobalKey<FormState>();

  @override
  void initState() {
    _messageController.text = widget.message;
    _newNumberController = TextEditingController(text: widget.numberContact);
    withNumber = Preferences.phone.isNotEmpty;
    super.initState();
  }

  void _toggleSnackbar() {
    setState(() => showMessage = true);
    Future.delayed(3.seconds, () => setState(() => showMessage = false));
  }

  Future<bool> _sendingMessage() async {
    bool send = false;
    try {
      await SendQuoteService().sendQuoteWhatsApp(
        widget.numberContact.isNotEmpty
            ? widget.numberContact
            : _messageController.text
                .trim()
                .replaceAll(r'🏞️', "")
                .replaceAll(r'🌊', ""),
      );

      send = true;
    } catch (e) {
      print(e);
      snackMessage = "Error al enviar mensaje por web WhatsApp";
      typeMessage = "danger";
      setState(() {});
      _toggleSnackbar();
    }

    return send;
  }

  Future<void> _sendMessage() async {
    if (!_formKeyMessage.currentState!.validate()) {
      return;
    }

    inProcess = true;
    setState(() {});

    if (!mounted) return;
    bool status = await _sendingMessage();
    inProcess = false;
    setState(() {});
    if (!status) return;

    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: SizedBox(
        height: (widget.numberContact.isEmpty && withNumber) ? 580 : 500,
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TitlePage(
                      icons: Bootstrap.whatsapp,
                      isDialog: true,
                      title:
                          "${withNumber ? "Enviar " : ""}Mensaje de WhatsApp",
                      sizeSubtitle: 10,
                      subtitle:
                          "Revisa o modifica el mensaje predefinido para cliente.",
                    ),
                    Divider(
                        color: Theme.of(context).primaryColor, thickness: 0.6),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: 450,
                            height: 340,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextStyles.standardText(
                                            text: "Mensaje computado:",
                                            size: 12,
                                          ),
                                        ),
                                        Buttons.iconButtonCard(
                                          icon: isEditable
                                              ? CupertinoIcons
                                                  .arrow_counterclockwise
                                              : Iconsax.edit_outline,
                                          tooltip: isEditable
                                              ? "Restablecer"
                                              : "Editar",
                                          onPressed: () {
                                            if (isEditable) {
                                              _messageController.text =
                                                  widget.message;
                                            }
                                            setState(() {
                                              isEditable = !isEditable;
                                            });
                                          },
                                        ),
                                        Buttons.iconButtonCard(
                                          icon: Iconsax.copy_bold,
                                          tooltip: "Copiar",
                                          onPressed: () {
                                            snackMessage =
                                                "Mensaje copiado en el portapapeles.";
                                            typeMessage = "info";
                                            setState(() {});

                                            Clipboard.setData(ClipboardData(
                                                text: _messageController.text));

                                            _toggleSnackbar();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 280,
                                    child: FormWidgets.textAreaForm(
                                      controller: _messageController,
                                      readOnly: !isEditable,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 100,
                            right: 70,
                            child: insideSnackBar(
                              message: snackMessage,
                              type: typeMessage,
                              showAnimation: showMessage,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (widget.numberContact.isEmpty && withNumber)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Form(
                          key: _formKeyMessage,
                          child: TextFormFieldCustom.textFormFieldwithBorder(
                            name: "Numero de contacto de WhatsApp",
                            withLabelAndHint: true,
                            hintText: "Ejemp: 52 9589990000",
                            msgError: "Campo requerido*",
                            isRequired: true,
                            isNumeric: true,
                            controller: _newNumberController,
                            onFieldSubmitted: isSaving
                                ? null
                                : (p0) async => await _sendMessage(),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
              child: Row(
                mainAxisAlignment: (widget.numberContact.isEmpty && withNumber)
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.end,
                children: [
                  if (widget.numberContact.isEmpty && withNumber)
                    Buttons.commonButton(
                      text: "Guardar y enviar",
                      isLoading: isSaving,
                      sizeText: 12.5,
                      onPressed: inProcess
                          ? null
                          : () async {
                              if (!_formKeyMessage.currentState!.validate()) {
                                return;
                              }

                              isSaving = true;
                              setState(() {});

                              // bool result = await CotizacionService()
                              //     .updateCotizacion(CotizacionTableData(
                              //   id: widget.cotizacionId,
                              //   // numeroTelefonico: _newNumberController.text,
                              // ));

                              // if (!result) {
                              //   snackMessage =
                              //       "Error al guardar nuevo contacto";
                              //   typeMessage = "danger";
                              //   setState(() {});

                              //   _toggleSnackbar();
                              //   return;
                              // }

                              if (widget.saveFunction != null) {
                                widget.saveFunction!
                                    .call(_newNumberController.text);
                              }

                              if (!mounted) return;
                              bool status = await _sendingMessage();
                              isSaving = false;
                              setState(() {});
                              if (!status) return;

                              Navigator.of(context).pop(true);
                            },
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: (inProcess || isSaving)
                            ? null
                            : () {
                                Navigator.pop(context);
                              },
                        child: TextStyles.standardText(
                          text: "Cerrar",
                          isBold: true,
                          size: 12.5,
                          color: brightness == Brightness.light
                              ? DesktopColors.cerulean
                              : DesktopColors.azulUltClaro,
                        ),
                      ),
                      if (withNumber) const SizedBox(width: 8),
                      if (withNumber)
                        Buttons.commonButton(
                          text: "Enviar por Web",
                          isLoading: inProcess,
                          sizeText: 12.5,
                          onPressed: isSaving
                              ? null
                              : () async => await _sendMessage(),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
