import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/models/cotizacion_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../services/send_quote_service.dart';
import '../../utils/helpers/web_colors.dart';
import '../../widgets/dialogs.dart';

class PdfCotizacionView extends StatefulWidget {
  const PdfCotizacionView({
    super.key,
    required this.comprobantePDF,
    required this.cotizacion,
  });

  final pw.Document comprobantePDF;
  final Cotizacion cotizacion;

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
          build: (format) => widget.comprobantePDF.save(),
          actionBarTheme: PdfActionBarTheme(
            backgroundColor: DesktopColors.ceruleanOscure,
            iconColor: Colors.white,
            actionSpacing: 30,
            alignment: WrapAlignment.center,
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
                await Printing.sharePdf(
                  filename:
                      "Comprobante de cotizacion ${DateTime.now().toString().substring(0, 10)}.pdf",
                  bytes: await widget.comprobantePDF.save(),
                );
              },
              icon: const Icon(
                CupertinoIcons.tray_arrow_down_fill,
                color: Colors.white,
                size: 22,
              ),
            ),
            if (isSendingEmail)
              const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(color: Colors.white),
              )
            else
              IconButton(
                onPressed: () async {
                  setState(() => isSendingEmail = true);

                  if (await SendQuoteService().sendQuoteMail(
                    widget.comprobantePDF,
                    widget.cotizacion,
                    widget.cotizacion.habitaciones!,
                  )) {
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
                  }
                },
                icon: const Icon(
                  CupertinoIcons.mail,
                  color: Colors.white,
                  size: 22,
                ),
              ),
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
