import 'dart:io';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/models/cotizacion_model.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/utils/shared_preferences/preferences.dart';
import 'package:generador_formato/views/generacion_cotizaciones/dialogs/send_message_dialog.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/send_quote_service.dart';
import '../../ui/progress_indicator.dart';
import '../../ui/show_snackbar.dart';
import '../../utils/helpers/desktop_colors.dart';
import '../../widgets/dialogs.dart';
import '../../widgets/textformfield_custom.dart';

class PdfCotizacionView extends StatefulWidget {
  const PdfCotizacionView({
    super.key,
    required this.comprobantePDF,
    required this.cotizacion,
    this.isDetail = false,
  });

  final pw.Document comprobantePDF;
  final Cotizacion cotizacion;
  final bool isDetail;

  @override
  State<PdfCotizacionView> createState() => _PdfCotizacionViewState();
}

class _PdfCotizacionViewState extends State<PdfCotizacionView> {
  bool isSendingEmail = false;
  bool isDownloading = false;
  String selectMail = "";

  @override
  void initState() {
    selectMail = widget.cotizacion.correoElectronico ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;

    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Center(
        child: SizedBox(
          height: screenHeight * 0.89,
          width: screenWidth < 1080 ? null : 1080,
          child: PdfPreview(
            loadingWidget: ProgressIndicatorCustom(
              screenHight: screenHeight,
              colorIndicator: Colors.white,
              inHorizontal: true,
              message: TextStyles.standardText(
                text: "Cargando comprobante",
                aling: TextAlign.center,
                size: 11,
                color: Colors.white,
              ),
            ),
            scrollViewDecoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              color: brightness == Brightness.dark
                  ? Theme.of(context).cardColor
                  : DesktopColors.grisPalido,
            ),
            build: (format) => widget.comprobantePDF.save(),
            actionBarTheme: PdfActionBarTheme(
              backgroundColor: DesktopColors.ceruleanOscure,
              iconColor: Colors.white,
              actionSpacing: 30,
              alignment: WrapAlignment.center,
              elevation: 8,
            ),
            canChangeOrientation: false,
            canChangePageFormat: false,
            canDebug: false,
            allowSharing: false,
            allowPrinting: false,
            pdfFileName:
                "Comprobante de cotizacion ${DateTime.now().toString().substring(0, 10)}.pdf",
            actions: [
              IconButton(
                onPressed: () async => await Printing.layoutPdf(
                    onLayout: (_) async => widget.comprobantePDF.save()),
                icon: const Icon(
                  CupertinoIcons.printer,
                  color: Colors.white,
                ),
                tooltip: "Imprimir",
              ),
              if (isDownloading)
                const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(color: Colors.white),
                )
              else
                IconButton(
                  tooltip: "Descargar",
                  onPressed: () async {
                    await _downloadPDF();
                  },
                  icon: const Icon(
                    // CupertinoIcons.tray_arrow_down_fill,
                    Icons.download_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              // if (!widget.isDetail)
              if (isSendingEmail)
                const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(color: Colors.white),
                )
              else
                IconButton(
                  tooltip: "Enviar por correo",
                  icon: const Icon(
                    CupertinoIcons.mail,
                    color: Colors.white,
                    size: 22,
                  ),
                  onPressed: () async {
                    if (Preferences.mail.isEmpty ||
                        Preferences.passwordMail.isEmpty) {
                      showSnackBar(
                        type: "alert",
                        context: context,
                        iconCustom: CupertinoIcons.tray_fill,
                        duration: 4.seconds,
                        title: "Correo SMTP o contraseña no registrada",
                        message:
                            "Se requiere del correo SMTP o contraseña para enviar este comprobante por correo.",
                      );
                      return;
                    }
        
                    await _SendMailSMTP();
                  },
                ),
              // if (!widget.isDetail)
              IconButton(
                onPressed: () async {
                  if (Preferences.phone.isEmpty) {
                    showSnackBar(
                      type: "alert",
                      context: context,
                      iconCustom: CupertinoIcons.tray_fill,
                      duration: 4.seconds,
                      title: "Número no registrada",
                      message:
                          "Se requiere de un número telefonico para enviar este comprobante por WhatsApp.",
                    );
                    return;
                  }
        
                  await _sendMessage();
                },
                icon: const Image(
                  image: AssetImage("assets/image/whatsApp_icon.png"),
                  width: 22,
                  color: Colors.white,
                ),
                tooltip: "Enviar por WhatsApp",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _SendMailSMTP({String? newMail}) async {
    setState(() => isSendingEmail = true);

    String messageError = "";

    try {
      String messageRequest = await SendQuoteService().sendQuoteMail(
        widget.comprobantePDF,
        widget.cotizacion,
        widget.cotizacion.habitaciones!,
        newMail: newMail,
      );
      if (messageRequest.isEmpty) {
        if (!mounted) return;
        setState(() => isSendingEmail = false);
        showSnackBar(
          type: "success",
          context: context,
          duration: 5.seconds,
          title: "Correo enviado",
          message: "El correo fue enviado exitosamente",
          iconCustom: CupertinoIcons.envelope_open_fill,
        );
      } else {
        messageError = messageRequest;
        if (!mounted) return;
        setState(() => isSendingEmail = false);
      }
    } catch (e) {
      print(e);
      messageError = e.toString();
      setState(() => isSendingEmail = false);
    }

    print(messageError);

    if (messageError.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          TextEditingController _mailController =
              TextEditingController(text: selectMail);
          final GlobalKey<FormState> _formDialogKey = GlobalKey<FormState>();

          return Dialogs.customAlertDialog(
            context: context,
            iconData: Icons.cancel_schedule_send_rounded,
            iconColor: DesktopColors.turqueza,
            title: "Error al enviar el comprobante\nde cotización por correo",
            contentCustom: SizedBox(
              height: 200,
              child: Form(
                key: _formDialogKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextStyles.standardText(
                      text: "Se produjo el siguiente error al enviar:",
                      size: 12,
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 70,
                      width: 350,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 0.8),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          color: Utility.darken(
                              Theme.of(context).cardColor, -0.2)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                            child: Column(
                          children: [
                            TextStyles.errorText(
                              text: messageError,
                              size: 11.5,
                            ),
                          ],
                        )),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextStyles.standardText(
                      text:
                          "Utilice otro correo electronico para realizar el envió:",
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
                        if (!_formDialogKey.currentState!.validate()) return;

                        _SendMailSMTP(newMail: p0);
                      },
                    ),
                  ],
                ),
              ),
            ),
            nameButtonMain: "Aceptar",
            funtionMain: () {
              if (!_formDialogKey.currentState!.validate()) return;

              _SendMailSMTP(newMail: _mailController.text);
            },
            nameButtonCancel: "",
            withButtonCancel: false,
          );
        },
      );
    }
  }

  Future<void> _downloadPDF() async {
    isDownloading = true;
    setState(() {});
    try {
      final output = await getDownloadsDirectory();
      final file = File(
          '${output!.path}/Comprobante de cotizacion ${widget.cotizacion.folioPrincipal} ${DateTime.now().toString().replaceAll(RegExp(r':'), "_")}.pdf');
      await file.writeAsBytes(await widget.comprobantePDF.save());

      final pdfUrl = Uri.file(file.path);
      await launchUrl(pdfUrl);
    } catch (e) {
      if (!mounted) return;
      showSnackBar(
        type: "danger",
        context: context,
        title: "Error al guardar el documento",
        message: "Se produjo el siguiente error: $e",
      );
    }
    isDownloading = false;
    setState(() {});
  }

  Future<void> _sendMessage() async {
    String message = (widget.cotizacion.esGrupo ?? false)
        ? await SendQuoteService()
            .generateMessageWhatsAppGroup(widget.cotizacion)
        : await SendQuoteService().generateMessageWhatsApp(
            widget.cotizacion, widget.cotizacion.habitaciones!);

    String response = "";

    showDialog(
      context: context,
      builder: (context) => SendMessageDialog(
          message: message,
          nombreHuesped: widget.cotizacion.nombreHuesped ?? ''),
    ).then(
      (value) async {
        if (value != null) {
          response =  value;
          Future.delayed(
            Durations.short4,
            () async => await SendQuoteService().sendQuoteWhatsApp(response.replaceAll(r'🏞️', "").replaceAll(r'🌊', "")),
          );
        } else {
          return;
        }
      },
    );
  }
}
