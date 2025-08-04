import 'dart:io';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/cotizacion_model.dart';
import 'package:generador_formato/utils/shared_preferences/preferences.dart';
import 'package:generador_formato/views/generacion_cotizaciones/dialogs/send_mail_dialog.dart';
import 'package:generador_formato/views/generacion_cotizaciones/dialogs/send_message_dialog.dart';
import 'package:generador_formato/res/ui/text_styles.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/categoria_model.dart';
import '../../models/habitacion_model.dart';
import '../../view-models/providers/cotizacion_provider.dart';
import '../../view-models/services/send_quote_service.dart';
import '../../res/ui/progress_indicator.dart';
import '../../res/ui/show_snackbar.dart';
import '../../res/helpers/desktop_colors.dart';

class PdfCotizacionView extends ConsumerStatefulWidget {
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
  _PdfCotizacionViewState createState() => _PdfCotizacionViewState();
}

class _PdfCotizacionViewState extends ConsumerState<PdfCotizacionView> {
  bool isSendingEmail = false;
  bool isDownloading = false;
  String selectMail = "";
  bool isLoadingDoc = false;

  @override
  void initState() {
    selectMail = widget.cotizacion.cliente?.correoElectronico ?? '';
    isLoadingDoc = true;
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
              screenHeight: screenHeight,
              colorIndicator: Colors.white,
              type: IndicatorType.progressiveDots,
              message: TextStyles.standardText(
                text: "Cargando comprobante",
                align: TextAlign.center,
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
            build: (format) => widget.comprobantePDF.save().then(
              (value) {
                if (!isLoadingDoc) return value;
                Future.delayed(
                  Durations.short4,
                  () {
                    if (!mounted) return;
                    isLoadingDoc = false;
                    setState(() {});
                  },
                );
                return value;
              },
            ),
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
              if (isLoadingDoc)
                ProgressIndicatorCustom(
                  screenHeight: 17,
                  sizeProgressIndicator: 43,
                  colorIndicator: Colors.white,
                  type: IndicatorType.staggeredDotsWave,
                ),
              if (!isLoadingDoc)
                IconButton(
                  onPressed: () async => await Printing.layoutPdf(
                      onLayout: (_) async => widget.comprobantePDF.save()),
                  icon: const Icon(
                    CupertinoIcons.printer,
                    color: Colors.white,
                  ),
                  tooltip: "Imprimir",
                ),
              if (!isLoadingDoc)
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
                      Icons.download_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
              if (!isLoadingDoc)
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
              if (!isLoadingDoc)
                IconButton(
                  onPressed: () async {
                    await _sendMessage();
                  },
                  icon: const Icon(Bootstrap.whatsapp, size: 20),
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

    if ((widget.cotizacion.cliente?.correoElectronico ?? '').isEmpty &&
        newMail == null) {
      showDialogMail(messageError);
      return;
    }

    try {
      String messageRequest = await SendQuoteService().sendQuoteMail(
        widget.comprobantePDF,
        widget.cotizacion,
        widget.cotizacion.habitaciones ?? <Habitacion>[],
        <Categoria>[],
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

    if (messageError.isNotEmpty) showDialogMail(messageError);
  }

  void showDialogMail(String messageError) {
    showDialog(
      context: context,
      builder: (context) {
        return SendMailDialog(
          id: widget.cotizacion.idInt ?? 0,
          selectMail: selectMail,
          messageError: messageError,
          returnFunction: (p0, p1) {
            selectMail = p0;

            if (p1) {
              widget.cotizacion.cliente?.correoElectronico = p0;
              ref
                  .read(changeHistoryProvider.notifier)
                  .update((state) => UniqueKey().hashCode);
              setState(() {});
              _SendMailSMTP();
              return;
            }

            _SendMailSMTP(newMail: p0);
          },
        );
      },
    ).then(
      (value) => verifSaveMail(value),
    );
  }

  void verifSaveMail(value) {
    if (value != null) {
      if (!value) return;
      if (!mounted) return;
      setState(() => isSendingEmail = false);
      showSnackBar(
        type: "danger",
        context: context,
        title: "Error al guardar nuevo email",
        message: "Se produjo al intentar guardar nuevo email en la cotización.",
      );
    } else {
      setState(() => isSendingEmail = false);
    }
  }

  Future<void> _downloadPDF() async {
    isDownloading = true;
    setState(() {});
    try {
      final output = await getDownloadsDirectory();
      final file = File(
          '${output!.path}/Comprobante de cotizacion ${widget.cotizacion.folio} ${DateTime.now().toString().replaceAll(RegExp(r':'), "_")}.pdf');
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
        : await SendQuoteService()
            .generateMessageWhatsApp(widget.cotizacion, <Categoria>[]);

    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => SendMessageDialog(
        message: message,
        nombreHuesped: widget.cotizacion.cliente?.nombres ?? '',
        numberContact: widget.cotizacion.cliente?.numeroTelefonico ?? '',
        cotizacionId: widget.cotizacion.idInt ?? 0,
        saveFunction: (p0) {
          print(p0);
          widget.cotizacion.cliente?.numeroTelefonico = p0;
          setState(() {});
        },
      ),
    ).then(
      (value) {
        if (value != null) {
          showSnackBar(
            type: "success",
            context: context,
            title: "Mensaje de WhatsApp enviado",
            message: "El mensaje fue enviado correctamente.",
            iconCustom: Bootstrap.whatsapp,
          );
        }
      },
    );
  }
}
