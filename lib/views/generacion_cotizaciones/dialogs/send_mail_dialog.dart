import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/view-models/services/cotizacion_service.dart';
import 'package:generador_formato/utils/widgets/form_widgets.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../models/cliente_model.dart';
import '../../../res/ui/buttons.dart';
import '../../../res/ui/title_page.dart';
import '../../../res/helpers/desktop_colors.dart';
import '../../../res/ui/text_styles.dart';
import '../../../utils/widgets/textformfield_custom.dart';

class SendMailDialog extends StatefulWidget {
  const SendMailDialog(
      {Key? key,
      required this.selectMail,
      required this.id,
      this.messageError = '',
      this.returnFunction})
      : super(key: key);
  final String selectMail;
  final String messageError;
  final int id;
  final void Function(String, bool)? returnFunction;

  @override
  State<SendMailDialog> createState() => _SendMailDialogState();
}

class _SendMailDialogState extends State<SendMailDialog> {
  final GlobalKey<FormState> _formDialogKey = GlobalKey<FormState>();
  TextEditingController _mailController = TextEditingController();
  bool isSending = false;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    _mailController = TextEditingController(text: widget.selectMail);
  }

  @override
  Widget build(BuildContext context) {
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: SizedBox(
        height: widget.messageError.isEmpty ? 265 : 420,
        width: 430,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TitlePage(
                      icons: Iconsax.send_2_outline,
                      isDialog: true,
                      title: widget.messageError.isEmpty
                          ? "Enviar comprobante de Cotización\npor Correo Electronico"
                          : "Error al enviar el comprobante\nde cotización por correo",
                    ),
                    Divider(
                        color: Theme.of(context).primaryColor, thickness: 0.6),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: SizedBox(
                        width: 450,
                        height: null,
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formDialogKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (widget.messageError.isNotEmpty)
                                  TextStyles.standardText(
                                    text:
                                        "Se produjo el siguiente error al enviar:",
                                    size: 12,
                                  ),
                                if (widget.messageError.isNotEmpty)
                                  const SizedBox(height: 5),
                                if (widget.messageError.isNotEmpty)
                                  FormWidgets.textAreaForm(
                                    controller: TextEditingController(
                                        text: widget.messageError),
                                    maxLines: 4,
                                    readOnly: true,
                                    isError: true,
                                  ),
                                if (widget.messageError.isNotEmpty)
                                  const SizedBox(height: 14),
                                TextStyles.standardText(
                                  text:
                                      "${widget.messageError.isEmpty ? "Ingrese un" : "Utilice otro"} correo electronico para realizar el envió:",
                                  size: 12,
                                ),
                                const SizedBox(height: 5),
                                TextFormFieldCustom.textFormFieldwithBorder(
                                  name: "",
                                  hintText: "example@mail.com",
                                  msgError: "Campo requerido*",
                                  isRequired: true,
                                  controller: _mailController,
                                  onFieldSubmitted: (p0) {
                                    if (!_formDialogKey.currentState!
                                        .validate()) return;

                                    if (widget.returnFunction != null) {
                                      widget.returnFunction!.call(p0, false);

                                      Navigator.of(context).pop(false);
                                    }
                                  },
                                ),
                              ],
                            ),
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
                mainAxisAlignment: (widget.messageError.isNotEmpty)
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.messageError.isEmpty)
                    Buttons.commonButton(
                      text: "Guardar y enviar",
                      isLoading: isSending,
                      sizeText: 12.5,
                      onPressed: isSending
                          ? null
                          : () async {
                              if (!_formDialogKey.currentState!.validate()) {
                                return;
                              }

                              bool result = await CotizacionService()
                                  .updateCotizacion(CotizacionTableData(
                                id: widget.id,
                              ));

                              if (!result) {
                                Navigator.of(context).pop(true);
                                return;
                              }

                              if (!mounted) return;
                              if (widget.returnFunction != null) {
                                widget.returnFunction!
                                    .call(_mailController.text, true);
                              }
                              Navigator.of(context).pop(false);
                            },
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: (isSaving || isSending)
                            ? null
                            : () {
                                Navigator.pop(context);
                              },
                        child: TextStyles.standardText(
                          text: "Cancelar",
                          isBold: true,
                          size: 12.5,
                          color: brightness == Brightness.light
                              ? DesktopColors.cerulean
                              : DesktopColors.azulUltClaro,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Buttons.commonButton(
                        text: "Enviar",
                        isLoading: isSending,
                        sizeText: 12.5,
                        onPressed: isSaving
                            ? null
                            : () async {
                                if (!_formDialogKey.currentState!.validate()) {
                                  return;
                                }

                                isSending = true;
                                setState(() {});

                                if (widget.returnFunction != null) {
                                  widget.returnFunction!
                                      .call(_mailController.text, false);
                                }

                                Navigator.of(context).pop(false);
                              },
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
