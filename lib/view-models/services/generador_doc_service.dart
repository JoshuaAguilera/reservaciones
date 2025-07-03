import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../models/categoria_model.dart';
import '../../models/cotizacion_model.dart';
import '../../models/habitacion_model.dart';
import '../../res/helpers/constants.dart';
import '../../res/helpers/date_helpers.dart';
import '../../res/helpers/files_templates.dart';
import '../../res/ui/text_styles.dart';
import '../../utils/shared_preferences/preferences.dart';
import 'base_service.dart';

class GeneradorDocService extends BaseService {
  late pw.Document pdfPrinc;
  pw.Document get pdfPrincget => this.pdfPrinc;

  //styles
  pw.TextStyle styleTag =
      pw.TextStyle(color: PdfColor.fromHex("#2A00A0"), fontSize: 16, height: 2);

  static PdfPageFormat pageFormatDefault = const PdfPageFormat(
    21.59 * PdfPageFormat.cm,
    27.94 * PdfPageFormat.cm,
    marginBottom: (2.5 * 0.2) * PdfPageFormat.cm,
    marginTop: (2.6 * 0.393) * PdfPageFormat.cm,
    marginLeft: 3 * PdfPageFormat.cm,
    marginRight: 3 * PdfPageFormat.cm,
  );

  Future<pw.Image> getImagePDF({
    required String route,
    pw.BoxFit fit = pw.BoxFit.contain,
    double? width,
    double? height,
  }) async {
    final image = await rootBundle.load('assets/image/$route');
    final imageBytes = image.buffer.asUint8List();
    return pw.Image(
      pw.MemoryImage(imageBytes),
      width: width,
      height: height,
      fit: fit,
    );
  }

  Future<pw.Image> getImageGallery(String route) async {
    return await getImagePDF(
      route: route,
      width: 194,
      height: 128,
      fit: pw.BoxFit.fill,
    );
  }

  Future<pw.RichText> getTextStyle(int title, int content, double size) async {
    return await TextStyles.pwTextAsotiation(
      title: FilesTemplate.StructureDoc(title),
      content: FilesTemplate.StructureDoc(content),
      size: size,
    );
  }

  Future<pw.Document> generarCompInd({
    required Cotizacion cotizacion,
    bool themeDefault = false,
    bool isDirect = false,
  }) async {
    //PDF generation
    final pdf = pw.Document();
    final logoHeaderImage =
        await getImagePDF(route: "logo_documento.png", width: 165);
    final whatsAppImage =
        await getImagePDF(route: "whatsApp_icon.png", width: 9);

    //Styles
    pw.TextStyle styleLigthHeader = await TextStyles.pwStylePDF(size: 9);
    pw.TextStyle styleLigth = await TextStyles.pwStylePDF(size: 9);
    pw.TextStyle styleLigthHeaderTable = await TextStyles.pwStylePDF(size: 8.5);
    pw.TextStyle styleBold = await TextStyles.pwStylePDF(size: 9, isBold: true);
    pw.TextStyle styleBoldTable =
        await TextStyles.pwStylePDF(size: 8.5, isBold: true, lineSpacing: 1);
    pw.TextStyle styleBoldUnderline =
        await TextStyles.pwStylePDF(size: 9, isBold: true, withUnderline: true);
    pw.TextStyle styleItalic =
        await TextStyles.pwStylePDF(size: 9, isItalic: true, isBold: true);
    pw.TextStyle styleFooter =
        await TextStyles.pwStylePDF(size: 9, isRegular: true);

    // text Asotiative
    pw.RichText cancelPolity1 = await getTextStyle(120, 12, 9);
    pw.RichText cancelPolity2 = await getTextStyle(130, 13, 9);
    pw.RichText cancelPolity3 = await getTextStyle(140, 14, 9);
    pw.RichText service1 = await getTextStyle(149, 49, 9);
    pw.RichText service2 = await getTextStyle(136, 36, 9);
    pw.RichText service3 = await getTextStyle(137, 37, 9);
    pw.RichText service4 = await getTextStyle(138, 38, 9);
    pw.RichText service5 = await getTextStyle(148, 48, 9);

    //facilities
    pw.RichText ease1 = await getTextStyle(150, 50, 9);
    pw.RichText ease2 = await getTextStyle(151, 51, 9);
    pw.RichText ease3 = await getTextStyle(152, 52, 9);
    pw.RichText ease4 = await getTextStyle(153, 53, 9);
    pw.RichText ease5 = await getTextStyle(154, 54, 9);
    pw.RichText ease6 = await getTextStyle(155, 55, 9);

    List<pw.Widget> tables = generateTables(
      habitaciones: cotizacion.habitaciones,
      styleLigth: styleLigthHeaderTable,
      styleLigthHeaderTable: styleBoldTable,
      styleBoldTable: styleBoldTable,
      color: "#93dcf8",
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: pageFormatDefault,
        header: (context) {
          return pw.Column(children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                logoHeaderImage,
                pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 40),
                  child: pw.Text(
                      "Bahías de Huatulco Oaxaca a ${DateHelpers.getStringDate()}",
                      style: styleLigthHeader),
                ),
              ],
            ),
            pw.SizedBox(height: 24),
          ]);
        },
        build: (context) => [
          pw.Text("ESTIMAD@: ${cotizacion.cliente?.nombres}", style: styleBold),
          pw.SizedBox(height: 13),
          pw.Text(FilesTemplate.StructureDoc(1), style: styleLigth),
          pw.SizedBox(height: 14),
          pw.Text(FilesTemplate.StructureDoc(2), style: styleLigth),
          pw.SizedBox(height: 12),
          for (var element in tables) element,
          pw.Text("POLÍTICAS PARA RESERVACIÓN", style: styleBoldUnderline),
          pw.SizedBox(height: 11),
          FilesTemplate.getListDocument(
              styleItalic: styleItalic,
              styleLight: styleLigth,
              styleIndice: styleBold,
              idsText: [6, 7, 8, 9, 10, 11]),
          pw.SizedBox(height: 10),
          pw.Text("POLÍTICAS DE CANCELACIÓN", style: styleBoldUnderline),
          pw.SizedBox(height: 11),
          FilesTemplate.getListDocument(
              styleLight: styleLigth,
              styleIndice: styleBold,
              idsText: [],
              widgets: [cancelPolity1, cancelPolity2, cancelPolity3]),
          pw.SizedBox(height: 10),
          pw.Text("POLÍTICAS Y CONDICIONES GENERALES",
              style: styleBoldUnderline),
          pw.SizedBox(height: 11),
          for (var element in [15, 16, 17, 18, 19, 20])
            FilesTemplate.textIndice(
              text: FilesTemplate.StructureDoc(element),
              styleText: styleLigth,
              styleIndice: styleBold,
              withRound: true,
            ),
          pw.SizedBox(height: 10),
          pw.Text("CARACTERÍSTICAS DE LAS HABITACIONES",
              style: styleBoldUnderline),
          pw.SizedBox(height: 12),
          FilesTemplate.getListDocument(
              withRound: true,
              styleLight: styleLigth,
              styleIndice: styleBold,
              idsText: [21, 22, 23, 24, 25, 26, 27, 28, 29, 30]),
          pw.SizedBox(height: 10),
          pw.Text("GENERALES", style: styleBoldUnderline),
          pw.SizedBox(height: 12),
          FilesTemplate.getListDocument(
              withRound: true,
              styleLight: styleLigth,
              styleIndice: styleBold,
              idsText: [31, 32, 33, 34, 35]),
          pw.SizedBox(height: 10),
          pw.Text("HORARIOS Y SERVICIOS RESTAURANTE CORALES:",
              style: styleBold),
          pw.SizedBox(height: 12),
          FilesTemplate.getListDocument(
              withRound: true,
              styleLight: styleLigth,
              styleIndice: styleBold,
              widgets: [service1, service2, service3, service4],
              widgetFirst: true,
              idsText: [39]),
          pw.SizedBox(height: 8),
          FilesTemplate.getListDocument(
              withRound: true,
              isSubIndice: true,
              styleLight: styleLigth,
              styleIndice: styleBold,
              idsText: [40, 41, 42, 43, 44, 45, 46]),
          pw.SizedBox(height: 10),
          FilesTemplate.getListDocument(
              withRound: true,
              styleLight: styleLigth,
              styleIndice: styleBold,
              idsText: [47],
              widgets: [service5]),
          pw.SizedBox(height: 14),
          pw.Text("FACILIDADES", style: styleBold),
          pw.SizedBox(height: 13),
          FilesTemplate.getListDocument(
              withRound: true,
              styleLight: styleLigth,
              styleIndice: styleBold,
              idsText: [],
              widgets: [ease1, ease2, ease3, ease4, ease5, ease6]),
          pw.SizedBox(height: 9),
          pw.Text(FilesTemplate.StructureDoc(56), style: styleBold),
          pw.Text(FilesTemplate.StructureDoc(57), style: styleLigth),
          pw.SizedBox(height: 13),
          FilesTemplate.getListDocument(
              withRound: true,
              styleLight: styleLigth,
              styleIndice: styleBold,
              idsText: [58, 59]),
          pw.SizedBox(height: 11),
          pw.Text(FilesTemplate.StructureDoc(60), style: styleLigth),
          pw.SizedBox(height: 10),
          pw.Text(FilesTemplate.StructureDoc(61), style: styleLigth),
          if (isDirect)
            pw.Text("${Preferences.firstName} ${Preferences.lastName}",
                style: styleLigth)
          else
            pw.Text(
              "${cotizacion.creadoPor?.nombre ?? ''} ${cotizacion.creadoPor?.apellido ?? ''}",
              style: styleLigth,
            ),
        ],
        footer: (context) {
          return FilesTemplate.footerPage(
              styleFooter: styleFooter, whatsAppIcon: whatsAppImage);
        },
      ),
    );
    pdfPrinc = pdf;
    return pdf;
  }

  Future<pw.Document> generarComprobanteCotizacionGrupal({
    required List<Habitacion> habitaciones,
    required Cotizacion cotizacion,
    bool isDirect = false,
  }) async {
    //PDF generation
    final pdf = pw.Document();
    final logoHeaderImage =
        await getImagePDF(route: "logo_documento.png", width: 165);
    final whatsAppImage =
        await getImagePDF(route: "whatsApp_icon.png", width: 9);

    //Styles
    pw.TextStyle styleLigthHeader = await TextStyles.pwStylePDF(size: 9);
    pw.TextStyle styleLigth = await TextStyles.pwStylePDF(size: 9);
    pw.TextStyle styleBold = await TextStyles.pwStylePDF(size: 9, isBold: true);
    pw.TextStyle styleBoldTable =
        await TextStyles.pwStylePDF(size: 9, isBold: true, lineSpacing: 1);
    pw.TextStyle styleBoldUnderline = await TextStyles.pwStylePDF(
        size: 9.2, isBold: true, withUnderline: true);
    pw.TextStyle styleItalic =
        await TextStyles.pwStylePDF(size: 9, isItalic: true, isBold: true);
    pw.TextStyle styleFooter =
        await TextStyles.pwStylePDF(size: 9, isRegular: true);
    pw.TextStyle styleUrlLink = await TextStyles.pwStylePDF(
      size: 9,
      isBold: true,
      withUnderline: true,
      color: PdfColors.blue900,
    );
    // pw.TextStyle styleRegular =
    //     await TextStyles.pwStylePDF(size: 9.2, isBold: true);

    // Text Asotiative
    pw.RichText cancelPolity1 = await getTextStyle(69, 70, 9);
    pw.RichText cancelPolity2 = await getTextStyle(71, 72, 9);
    pw.RichText cancelPolity3 = await getTextStyle(73, 74, 9);

    pw.RichText service1 = await getTextStyle(149, 49, 9);
    pw.RichText service2 = await getTextStyle(136, 36, 9);
    pw.RichText service3 = await getTextStyle(137, 37, 9);
    pw.RichText service4 = await getTextStyle(138, 38, 9);
    pw.RichText service5 = await getTextStyle(148, 48, 9);

    // Facilities
    pw.RichText ease1 = await getTextStyle(150, 50, 9);
    pw.RichText ease2 = await getTextStyle(151, 51, 9);
    pw.RichText ease3 = await getTextStyle(152, 52, 9);
    pw.RichText ease4 = await getTextStyle(153, 53, 9);
    pw.RichText ease5 = await getTextStyle(154, 54, 9);
    pw.RichText ease6 = await getTextStyle(155, 55, 9);

    // Collection images
    pw.Image oneImage = await getImageGallery("habitacion_1.jpeg");
    pw.Image secImage = await getImageGallery("habitacion_2.jpeg");
    pw.Image threeImage = await getImageGallery("buffet.jpeg");
    pw.Image fourImage = await getImageGallery("parque_acuatico.jpeg");
    pw.Image fiveImage = await getImageGallery("fachada.jpeg");
    pw.Image sixImage = await getImageGallery("alberca.jpeg");

    int numRooms = 0;

    int freeRooms = 0;

    for (var element in habitaciones) {
      if (!element.esCortesia) {
        numRooms += element.count;
      } else {
        freeRooms += element.count;
      }
    }

    List<pw.Widget> tables = generateTables(
      habitaciones: cotizacion.habitaciones,
      styleLigth: styleLigth,
      styleLigthHeaderTable: styleBoldTable,
      styleBoldTable: styleBoldTable,
      color: "#93dcf8",
      typeQuote: cotizacion.esGrupo!,
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: pageFormatDefault,
        header: (context) {
          return pw.Column(children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                logoHeaderImage,
                pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 40),
                  child: pw.Text(
                      "Bahías de Huatulco Oaxaca a ${DateHelpers.getStringDate()}",
                      style: styleLigthHeader),
                ),
              ],
            ),
            pw.SizedBox(height: 24),
          ]);
        },
        build: (context) => [
          pw.SizedBox(height: 8),
          pw.Text("ESTIMAD@: ${cotizacion.cliente?.nombres}", style: styleBold),
          pw.SizedBox(height: 3),
          if ((cotizacion.cliente?.numeroTelefonico ?? '').isNotEmpty)
            pw.Text("TELÉFONO: ${cotizacion.cliente?.numeroTelefonico}",
                style: styleBold),
          if ((cotizacion.cliente?.numeroTelefonico ?? '').isNotEmpty)
            pw.SizedBox(height: 3),
          if ((cotizacion.cliente?.correoElectronico ?? '').isNotEmpty)
            pw.Row(
              children: [
                pw.Text("CORREO: ", style: styleBold),
                pw.UrlLink(
                  child: pw.Text("${cotizacion.cliente?.correoElectronico}",
                      style: styleUrlLink),
                  destination:
                      "mailto:${cotizacion.cliente?.correoElectronico}",
                )
              ],
            ),
          if ((cotizacion.cliente?.correoElectronico ?? '').isNotEmpty)
            pw.SizedBox(height: 3),
          pw.Text(
              "FECHAS DE ESTANCIA: ${DateHelpers.getPeriodReservation(habitaciones)}",
              style: styleBold),
          pw.SizedBox(height: 3),
          pw.Text(
              "HABITACIONES: $numRooms habitaciones ${freeRooms > 0 ? "($freeRooms habitacion${freeRooms > 1 ? "es" : ""} de cortesía)" : ""}",
              style: styleBold),
          pw.SizedBox(height: 22),
          pw.Text(FilesTemplate.StructureDoc(1), style: styleLigth),
          pw.SizedBox(height: 12),
          for (var element in tables) element,
          pw.SizedBox(height: 10),
          // pw.Center(
          //   child: pw.Text(FilesTemplate.StructureDoc(4),
          //       style: styleItalic),
          // ),
          // pw.Center(
          //   child: pw.Text(FilesTemplate.StructureDoc(5),
          //       style: styleItalic),
          // ),
          // pw.SizedBox(height: 20),
          pw.Text("POLÍTICAS PARA RESERVACIÓN", style: styleBoldUnderline),
          pw.SizedBox(height: 3),
          FilesTemplate.getListDocument(
              styleItalic: styleItalic,
              styleLight: styleLigth,
              styleIndice: styleBold,
              idsText: [62, 63, 64, 65, 66, 67, 68]),
          pw.SizedBox(height: 8),
          pw.Text("POLÍTICAS DE CANCELACIÓN", style: styleBoldUnderline),
          pw.SizedBox(height: 10),
          FilesTemplate.getListDocument(
              styleLight: styleLigth,
              styleIndice: styleBold,
              idsText: [],
              widgets: [cancelPolity1, cancelPolity2, cancelPolity3]),
          pw.SizedBox(height: 8),
          pw.Text("POLÍTICAS Y CONDICIONES GENERALES",
              style: styleBoldUnderline),
          pw.SizedBox(height: 5),
          // FilesTemplate.getListDocument(
          //   withRound: true,
          //   styleLight: styleLigth,
          //   styleIndice: styleBold,
          //   idsText: [15, 75, 17, 18, 19, 20],
          // ),
          for (var element in [15, 75, 17, 18, 19, 20])
            FilesTemplate.textIndice(
              text: FilesTemplate.StructureDoc(element),
              styleText: styleLigth,
              styleIndice: styleBold,
              withRound: true,
            ),
          pw.SizedBox(height: 8),
          pw.Text("CARACTERÍSTICAS DE LAS HABITACIONES",
              style: styleBoldUnderline),
          pw.SizedBox(height: 5),
          FilesTemplate.getListDocument(
              withRound: true,
              styleLight: styleLigth,
              styleIndice: styleBold,
              idsText: [21, 22, 23, 24, 25, 26, 27, 28, 29, 30]),
          pw.SizedBox(height: 8),
          pw.Text("GENERALES", style: styleBoldUnderline),
          pw.SizedBox(height: 5),
          FilesTemplate.getListDocument(
              withRound: true,
              styleLight: styleLigth,
              styleIndice: styleBold,
              idsText: [31, 32, 33, 34, 35]),
          pw.SizedBox(height: 8),
          pw.Text("HORARIOS Y SERVICIOS RESTAURANTE CORALES:",
              style: styleBold),
          pw.SizedBox(height: 5),
          FilesTemplate.getListDocument(
              withRound: true,
              styleLight: styleLigth,
              styleIndice: styleBold,
              widgets: [service1, service2, service3, service4],
              widgetFirst: true,
              idsText: [39]),
          pw.SizedBox(height: 8),
          FilesTemplate.getListDocument(
              withRound: true,
              isSubIndice: true,
              styleLight: styleLigth,
              styleIndice: styleBold,
              idsText: [40, 41, 42, 43, 44, 45, 46]),
          pw.SizedBox(height: 10),
          FilesTemplate.getListDocument(
              withRound: true,
              styleLight: styleLigth,
              styleIndice: styleBold,
              idsText: [47],
              widgets: [service5]),
          pw.SizedBox(height: 5),
          pw.Text("FACILIDADES", style: styleBold),
          pw.SizedBox(height: 13),
          FilesTemplate.getListDocument(
              withRound: true,
              styleLight: styleLigth,
              styleIndice: styleBold,
              idsText: [],
              widgets: [ease1, ease2, ease3, ease4, ease5, ease6]),
          pw.SizedBox(height: 9),
          pw.Text(FilesTemplate.StructureDoc(56), style: styleBold),
          pw.Text(FilesTemplate.StructureDoc(57), style: styleLigth),
          pw.SizedBox(height: 13),
          FilesTemplate.getListDocument(
              withRound: true,
              styleLight: styleLigth,
              styleIndice: styleBold,
              idsText: [58, 59]),
          pw.SizedBox(height: 11),
          pw.Text(FilesTemplate.StructureDoc(60), style: styleLigth),
          pw.SizedBox(height: 10),
          pw.Text(FilesTemplate.StructureDoc(61), style: styleLigth),
          if (isDirect)
            pw.Text("${Preferences.firstName} ${Preferences.lastName}",
                style: styleLigth)
          else
            pw.Text(
              "${cotizacion.cerradoPor?.nombre ?? ''} ${cotizacion.creadoPor?.apellido ?? ''}",
              style: styleLigth,
            ),
          pw.SizedBox(height: 48),
          pw.Padding(
            padding: const pw.EdgeInsets.only(left: -70),
            child: pw.Column(
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                  children: [
                    oneImage,
                    secImage,
                    threeImage,
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                  children: [
                    fourImage,
                    fiveImage,
                    sixImage,
                  ],
                ),
              ],
            ),
          ),
        ],
        footer: (context) {
          return FilesTemplate.footerPage(
              styleFooter: styleFooter, whatsAppIcon: whatsAppImage);
        },
      ),
    );
    pdfPrinc = pdf;
    return pdf;
  }

  List<pw.Widget> generateTables({
    List<Habitacion>? habitaciones,
    List<Categoria>? categorias,
    required pw.TextStyle styleLigth,
    required pw.TextStyle styleLigthHeaderTable,
    required pw.TextStyle styleBoldTable,
    String? color,
    bool typeQuote = false,
  }) {
    List<pw.Widget> tablas = [];

    if (habitaciones == null) return tablas;
    categorias ??= [];

    if (!typeQuote) {
      for (var element
          in habitaciones.where((element) => !element.esCortesia).toList()) {
        for (var categoria in categorias) {
          tablas.add(
            FilesTemplate.getTablesCotIndiv(
              categoria: categoria,
              room: element,
              styleGeneral: styleLigth,
              styleHeader: styleLigthHeaderTable,
              styleBold: styleBoldTable,
              colorHeader: color,
              tipoHab: tipoHabitacion.last,
              numRooms: habitaciones
                  .where((element) => !element.esCortesia)
                  .toList()
                  .length,
            ),
          );
          tablas.add(pw.SizedBox(height: 10));
        }
      }
    } else {
      for (var element
          in habitaciones.where((element) => !element.esCortesia).toList()) {
        tablas.add(
          FilesTemplate.getTablesCotGroup(
            nameTable: "PLAN TODO INCLUIDO - TARIFA POR NOCHE"
                " ${habitaciones.length > 1 ? DateHelpers.getStringPeriod(initDate: element.checkIn!, lastDate: element.checkOut!) : ""}",
            habitacion: element,
            styleGeneral: styleLigth,
            styleHeader: styleLigthHeaderTable,
            styleBold: styleBoldTable,
            colorHeader: color,
          ),
        );
        if (habitaciones
                .where((element) => !element.esCortesia)
                .toList()
                .indexOf(element) <
            habitaciones
                .where((element) => !element.esCortesia)
                .toList()
                .length) {
          tablas.add(pw.SizedBox(height: 10));
        }
      }
    }

    return tablas;
  }
}
