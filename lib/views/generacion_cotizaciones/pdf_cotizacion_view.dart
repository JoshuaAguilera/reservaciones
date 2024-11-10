import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/models/cotizacion_model.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/utils/shared_preferences/preferences.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/send_quote_service.dart';
import '../../ui/show_snackbar.dart';
import '../../utils/helpers/web_colors.dart';
import '../../widgets/dialogs.dart';

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

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: SizedBox(
        height: screenHeight * 0.89,
        child: PdfPreview(
          loadingWidget: Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: Colors.grey,
              size: 45,
            ),
          ),
          scrollViewDecoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              color: Utility.darken(Theme.of(context).scaffoldBackgroundColor)),
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
          pdfFileName:
              "Comprobante de cotizacion ${DateTime.now().toString().substring(0, 10)}.pdf",
          actions: [
            IconButton(
              onPressed: () async {
                try {
                  final output = await getDownloadsDirectory();
                  final file = File(
                      '${output!.path}/Comprobante de cotizacion ${widget.cotizacion.folioPrincipal} ${DateTime.now().toString().replaceAll(RegExp(r':'), "_")}.pdf');
                  await file.writeAsBytes(await widget.comprobantePDF.save());

                  final pdfUrl = Uri.file(file.path);
                  await launchUrl(pdfUrl);
                } catch (e) {
                  print(e);
                  showSnackBar(
                    type: "danger",
                    context: context,
                    title: "Error al guardar el documento",
                    message: "Se produjo el siguiente error: $e",
                  );
                }
              },
              icon: const Icon(
                CupertinoIcons.tray_arrow_down_fill,
                color: Colors.white,
                size: 22,
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
                      duration: 3.seconds,
                      title: "Correo SMTP o contraseña no registrada",
                      message:
                          "Se requiere del correo SMTP o contraseña para enviar este comprobante por correo.",
                    );
                  }

                  setState(() => isSendingEmail = true);

                  String messageError = "";

                  try {
                    String messageRequest =
                        await SendQuoteService().sendQuoteMail(
                      widget.comprobantePDF,
                      widget.cotizacion,
                      widget.cotizacion.habitaciones!,
                    );
                    if (messageRequest.isEmpty) {
                      if (!mounted) return;
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialogs.customAlertDialog(
                              context: context,
                              iconData: Icons.send,
                              iconColor: DesktopColors.turqueza,
                              title: "Correo enviado",
                              contentText: "El correo fue enviado exitosamente",
                              nameButtonMain: "Aceptar",
                              funtionMain: () {},
                              nameButtonCancel: "",
                              withButtonCancel: false);
                        },
                      ).then((value) => setState(() => isSendingEmail = false));
                    } else {
                      messageError = messageRequest;
                      setState(() => isSendingEmail = false);
                    }
                  } catch (e) {
                    print(e);
                    messageError = e.toString();
                    setState(() => isSendingEmail = false);
                  }

                  if (messageError.isNotEmpty) {
                    showSnackBar(
                      type: "danger",
                      context: context,
                      duration: 5.seconds,
                      title: "Error al enviar el comprobante por correo",
                      message:
                          "Se produjo el siguiente error al enviar: $messageError",
                    );
                  }
                },
              ),
            // if (!widget.isDetail)
            GestureDetector(
              onTap: () async {
                SendQuoteService().sendQuoteWhatsApp(
                    widget.cotizacion, widget.cotizacion.habitaciones!);
              },
              child: const Image(
                  image: AssetImage("assets/image/whatsApp_icon.png"),
                  width: 22,
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
