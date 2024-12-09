import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generador_formato/ui/show_snackbar.dart';
import 'package:generador_formato/widgets/form_widgets.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../ui/buttons.dart';
import '../../../utils/helpers/desktop_colors.dart';
import '../../../widgets/text_styles.dart';
import '../../../widgets/textformfield_custom.dart';

class SendMessageDialog extends StatefulWidget {
  const SendMessageDialog(
      {super.key, required this.message, required this.nombreHuesped});

  final String message;
  final String nombreHuesped;

  @override
  State<SendMessageDialog> createState() => _SendMessageDialogState();
}

class _SendMessageDialogState extends State<SendMessageDialog> {
  final _messageController = TextEditingController();
  bool inProcess = false;
  bool isEditable = false;

  @override
  void initState() {
    _messageController.text = widget.message;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: SizedBox(
        height: 500,
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: brightness == Brightness.light
                                          ? Colors.black87
                                          : Colors.white,
                                      width: 0.5,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(9))),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Brand(
                                    Brands.whatsapp,
                                    size: 32,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextStyles.titleText(
                                    text: "Enviar Mensaje de WhatsApp",
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  TextStyles.standardText(
                                    text:
                                        "Revisa o modifica el mensaje predefinido para cliente.",
                                    size: 10.5,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                        color: Theme.of(context).primaryColor, thickness: 0.6),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: SizedBox(
                        width: 450,
                        height: 350,
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
                                      tooltip:
                                          isEditable ? "Restablecer" : "Editar",
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
                                        Clipboard.setData(ClipboardData(
                                            text: _messageController.text));

                                        showSnackBar(
                                          context: context,
                                          title: "Mensaje copiado",
                                          message:
                                              "El mensaje para ${widget.nombreHuesped} fue copiado en el portapapeles.",
                                          type: "info",
                                          iconCustom: Iconsax.copy_bold,
                                        );
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
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
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
                  const SizedBox(width: 8),
                  Buttons.commonButton(
                    text: "Enviar por WhatsApp Web",
                    isLoading: inProcess,
                    sizeText: 12.5,
                    onPressed: () {
                      inProcess = true;
                      setState(() {});
                      Navigator.of(context).pop(_messageController.text);
                    },
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
