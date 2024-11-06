import 'package:flutter/services.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/utils/helpers/files_templates.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/models/cotizacion_model.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'base_service.dart';

class GeneradorDocService extends BaseService {
  late pw.Document pdfPrinc;
  pw.Document get pdfPrincget => this.pdfPrinc;

  //styles
  pw.TextStyle styleTag =
      pw.TextStyle(color: PdfColor.fromHex("#2A00A0"), fontSize: 16, height: 2);

  Future<pw.Document> generarComprobanteCotizacionIndividual({
    required List<Habitacion> habitaciones,
    required Cotizacion cotizacion,
    bool themeDefault = false,
  }) async {
    //PDF generation
    final pdf = pw.Document();
    PdfPageFormat pageFormatDefault = const PdfPageFormat(
      21.59 * PdfPageFormat.cm,
      27.94 * PdfPageFormat.cm,
      marginBottom: (2.5 * 0.2) * PdfPageFormat.cm,
      marginTop: (2.6 * 0.393) * PdfPageFormat.cm,
      marginLeft: 3 * PdfPageFormat.cm,
      marginRight: 3 * PdfPageFormat.cm,
    );

    //Header
    final imgenLogo = await rootBundle.load('assets/image/logo_documento.png');
    final imageBytes = imgenLogo.buffer.asUint8List();
    pw.MemoryImage logoImage = pw.MemoryImage(imageBytes);
    pw.Image logoHeaderImage = pw.Image(logoImage, width: 165);

    //Footer
    final imgWhatsApp = await rootBundle.load('assets/image/whatsApp_icon.png');
    final imageBytesW = imgWhatsApp.buffer.asUint8List();
    pw.Image whatsAppImage = pw.Image(pw.MemoryImage(imageBytesW), width: 9.5);

    //Styles
    pw.TextStyle styleLigthHeader = await TextStyles.pwStylePDF(size: 9);
    pw.TextStyle styleLigth = await TextStyles.pwStylePDF(size: 9);
    pw.TextStyle styleLigthHeaderTable =
        await TextStyles.pwStylePDF(size: 9, isWhite: true, isBold: true);
    pw.TextStyle styleBold = await TextStyles.pwStylePDF(size: 9, isBold: true);
    pw.TextStyle styleBoldTable =
        await TextStyles.pwStylePDF(size: 9, isBold: true, lineSpacing: 1);
    pw.TextStyle styleBoldUnderline =
        await TextStyles.pwStylePDF(size: 9, isBold: true, withUnderline: true);
    pw.TextStyle styleItalic =
        await TextStyles.pwStylePDF(size: 9, isItalic: true, isBold: true);
    pw.TextStyle styleFooter =
        await TextStyles.pwStylePDF(size: 9, isRegular: true);
    pw.TextStyle styleRegular =
        await TextStyles.pwStylePDF(size: 9.4, isBold: true);

    // text Asotiative
    pw.RichText cancelPolity1 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(120),
        content: FilesTemplate.StructureDoc(12),
        size: 9);
    pw.RichText cancelPolity2 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(130),
        content: FilesTemplate.StructureDoc(13),
        size: 9);
    pw.RichText cancelPolity3 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(140),
        content: FilesTemplate.StructureDoc(14),
        size: 9);

    pw.RichText service1 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(149),
        content: FilesTemplate.StructureDoc(49),
        size: 9);
    pw.RichText service2 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(136),
        content: FilesTemplate.StructureDoc(36),
        size: 9);
    pw.RichText service3 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(137),
        content: FilesTemplate.StructureDoc(37),
        size: 9);
    pw.RichText service4 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(138),
        content: FilesTemplate.StructureDoc(38),
        size: 9);
    pw.RichText service5 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(148),
        content: FilesTemplate.StructureDoc(48),
        size: 9);

    //facilities
    pw.RichText ease1 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(150),
        content: FilesTemplate.StructureDoc(50),
        size: 9);
    pw.RichText ease2 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(151),
        content: FilesTemplate.StructureDoc(51),
        size: 9);
    pw.RichText ease3 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(152),
        content: FilesTemplate.StructureDoc(52),
        size: 9);
    pw.RichText ease4 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(153),
        content: FilesTemplate.StructureDoc(53),
        size: 9);
    pw.RichText ease5 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(154),
        content: FilesTemplate.StructureDoc(54),
        size: 9);
    pw.RichText ease6 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(155),
        content: FilesTemplate.StructureDoc(55),
        size: 9);

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
                      "Bahías de Huatulco Oaxaca a ${Utility.getCompleteDate()}",
                      style: styleLigthHeader),
                ),
              ],
            ),
            pw.SizedBox(height: 24),
          ]);
        },
        build: (context) => [
          pw.SizedBox(
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text("ESTIMAD@: ${cotizacion.nombreHuesped}",
                      style: styleBold),
                  pw.SizedBox(height: 13),
                  pw.Text(FilesTemplate.StructureDoc(1), style: styleLigth),
                  pw.SizedBox(height: 14),
                  pw.Text(FilesTemplate.StructureDoc(2), style: styleLigth),
                  pw.SizedBox(height: 12),
                  generateTables(
                    habitaciones: habitaciones,
                    styleLigth: styleLigth,
                    styleLigthHeaderTable: styleBoldTable,
                    styleBoldTable: styleBoldTable,
                    color: "#93dcf8",
                  ),
                  // pw.Text("NOTAS", style: styleBoldUnderline),
                  // pw.SizedBox(height: 10),
                  // pw.Text(FilesTemplate.StructureDoc(3), style: styleRegular),
                  // pw.SizedBox(height: 10),
                  // pw.Padding(
                  //   padding: const pw.EdgeInsets.only(left: 27),
                  //   child: pw.Text(FilesTemplate.StructureDoc(4),
                  //       style: styleItalic),
                  // ),
                  // pw.Padding(
                  //   padding: const pw.EdgeInsets.only(left: 27),
                  //   child: pw.Text(FilesTemplate.StructureDoc(5),
                  //       style: styleItalic),
                  // ),
                  pw.Text("POLÍTICAS PARA RESERVACIÓN",
                      style: styleBoldUnderline),
                  pw.SizedBox(height: 11),
                  FilesTemplate.getListDocument(
                      styleItalic: styleItalic,
                      styleLight: styleLigth,
                      styleIndice: styleBold,
                      idsText: [6, 7, 8, 9, 10, 11]),
                  pw.SizedBox(height: 10),
                  pw.Text("POLÍTICAS DE CANCELACIÓN",
                      style: styleBoldUnderline),
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
                  pw.SizedBox(height: 10),
                ]),
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

  Future<pw.Document> generarComprobanteCotizacionGrupal(
      List<Habitacion> habitaciones, Cotizacion comprobante) async {
    //PDF generation
    final pdf = pw.Document();
    PdfPageFormat pageFormatDefault = const PdfPageFormat(
      21.59 * PdfPageFormat.cm,
      27.94 * PdfPageFormat.cm,
      marginBottom: (2.5 * 0.2) * PdfPageFormat.cm,
      marginTop: (3.13 * 0.393) * PdfPageFormat.cm,
      marginLeft: 0.3 * PdfPageFormat.cm,
      marginRight: 0.3 * PdfPageFormat.cm,
    );

    //Header img
    final img = await rootBundle.load('assets/image/logo_documento.png');
    final imageBytes = img.buffer.asUint8List();
    pw.Image logoHeaderImage = pw.Image(pw.MemoryImage(imageBytes), width: 131);

    //Footer img
    final imgWhatsApp = await rootBundle.load('assets/image/whatsApp_icon.png');
    final imageBytesW = imgWhatsApp.buffer.asUint8List();
    pw.Image whatsAppImage = pw.Image(pw.MemoryImage(imageBytesW), width: 9);

    //Styles
    pw.TextStyle styleLigthHeader = await TextStyles.pwStylePDF(size: 9);
    pw.TextStyle styleLigth = await TextStyles.pwStylePDF(size: 9);
    pw.TextStyle styleLigthHeaderTable =
        await TextStyles.pwStylePDF(size: 9, isWhite: true, isBold: true);
    pw.TextStyle styleBold = await TextStyles.pwStylePDF(size: 9, isBold: true);
    pw.TextStyle styleBoldTable =
        await TextStyles.pwStylePDF(size: 9, isBold: true, lineSpacing: 1);
    pw.TextStyle styleBoldUnderline = await TextStyles.pwStylePDF(
        size: 9.2, isBold: true, withUnderline: true);
    pw.TextStyle styleItalic =
        await TextStyles.pwStylePDF(size: 9, isItalic: true, isBold: true);
    pw.TextStyle styleFooter =
        await TextStyles.pwStylePDF(size: 9, isRegular: true);
    // pw.TextStyle styleRegular =
    //     await TextStyles.pwStylePDF(size: 9.2, isBold: true);

    // text Asotiative
    pw.RichText cancelPolity1 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(69),
        content: FilesTemplate.StructureDoc(70),
        size: 9);
    pw.RichText cancelPolity2 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(71),
        content: FilesTemplate.StructureDoc(72),
        size: 9);
    pw.RichText cancelPolity3 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(73),
        content: FilesTemplate.StructureDoc(74),
        size: 9);

    pw.RichText service1 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(149),
        content: FilesTemplate.StructureDoc(49),
        size: 9);
    pw.RichText service2 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(136),
        content: FilesTemplate.StructureDoc(36),
        size: 9);
    pw.RichText service3 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(137),
        content: FilesTemplate.StructureDoc(37),
        size: 9);
    pw.RichText service4 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(138),
        content: FilesTemplate.StructureDoc(38),
        size: 9);
    pw.RichText service5 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(148),
        content: FilesTemplate.StructureDoc(48),
        size: 9);

    //facilities
    pw.RichText ease1 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(150),
        content: FilesTemplate.StructureDoc(50),
        size: 9);
    pw.RichText ease2 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(151),
        content: FilesTemplate.StructureDoc(51),
        size: 9);
    pw.RichText ease3 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(152),
        content: FilesTemplate.StructureDoc(52),
        size: 9);
    pw.RichText ease4 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(153),
        content: FilesTemplate.StructureDoc(53),
        size: 9);
    pw.RichText ease5 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(154),
        content: FilesTemplate.StructureDoc(54),
        size: 9);
    pw.RichText ease6 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(155),
        content: FilesTemplate.StructureDoc(55),
        size: 9);

    // Colection images
    pw.Image oneImage = await getImagePDF("habitacion_1.jpeg");
    pw.Image secImage = await getImagePDF("habitacion_2.jpeg");
    pw.Image threeImage = await getImagePDF("buffet.jpeg");
    pw.Image fourImage = await getImagePDF("parque_acuatico.jpeg");
    pw.Image fiveImage = await getImagePDF("fachada.jpeg");
    pw.Image sixImage = await getImagePDF("alberca.jpeg");

    pdf.addPage(
      pw.MultiPage(
        pageFormat: pageFormatDefault,
        header: (context) {
          return pw.Column(children: [
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(
                  horizontal: 2.7 * PdfPageFormat.cm),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  logoHeaderImage,
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(bottom: 10),
                    child: pw.Text(
                        "Bahías de Huatulco Oaxaca a ${Utility.getCompleteDate()}",
                        style: styleLigthHeader),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 10),
          ]);
        },
        build: (context) => [
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(
                horizontal: 2.7 * PdfPageFormat.cm),
            child: pw.SizedBox(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.SizedBox(height: 8),
                  pw.Text("ESTIMAD@: ${comprobante.nombreHuesped}",
                      style: styleBold),
                  pw.SizedBox(height: 3),
                  pw.Text("TELÉFONO: ${comprobante.numeroTelefonico}",
                      style: styleBold),
                  pw.SizedBox(height: 3),
                  pw.Text("CORREO: ${comprobante.correoElectronico}",
                      style: styleBold),
                  pw.SizedBox(height: 3),
                  pw.Text(
                      "FECHAS DE ESTANCIA: ${Utility.getDatesStay(habitaciones)}",
                      style: styleBold),
                  pw.SizedBox(height: 3),
                  pw.Text("HABITACIONES: ${comprobante.habitaciones}",
                      style: styleBold),
                  pw.SizedBox(height: 22),
                  pw.Text(FilesTemplate.StructureDoc(1), style: styleLigth),
                  pw.SizedBox(height: 12),
                  generateTables(
                      styleLigth: styleLigth,
                      styleLigthHeaderTable: styleBoldTable,
                      styleBoldTable: styleBoldTable,
                      color: "#93dcf8"),
                  pw.SizedBox(height: 10),
                  pw.Center(
                    child: pw.Text(FilesTemplate.StructureDoc(4),
                        style: styleItalic),
                  ),
                  pw.Center(
                    child: pw.Text(FilesTemplate.StructureDoc(5),
                        style: styleItalic),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text("POLÍTICAS PARA RESERVACIÓN",
                      style: styleBoldUnderline),
                  pw.SizedBox(height: 3),
                  FilesTemplate.getListDocument(
                      styleItalic: styleItalic,
                      styleLight: styleLigth,
                      styleIndice: styleBold,
                      idsText: [62, 63, 64, 65, 66, 67, 68]),
                  pw.SizedBox(height: 8),
                  pw.Text("POLÍTICAS DE CANCELACIÓN",
                      style: styleBoldUnderline),
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
                  pw.SizedBox(height: 10),
                  pw.Text("spaceName", style: styleLigth),
                  pw.SizedBox(height: 48),
                ],
              ),
            ),
          ),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              children: [
                oneImage,
                secImage,
                threeImage,
              ]),
          pw.SizedBox(height: 10),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              children: [
                fourImage,
                fiveImage,
                sixImage,
              ]),
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

  pw.Column generateTables(
      {List<Habitacion>? habitaciones,
      required pw.TextStyle styleLigth,
      required pw.TextStyle styleLigthHeaderTable,
      required pw.TextStyle styleBoldTable,
      String? color}) {
    List<pw.Widget> tablas = [];

    if (habitaciones == null) return pw.Column(children: tablas);

    if (habitaciones.any((element) => element.categoria == tipoHabitacion[0])) {
      tablas.add(
        FilesTemplate.getTablesCotIndiv(
          nameTable:
              "HABITACIÓN DELUXE DOBLE, VISTA A LA RESERVA – PLAN TODO INCLUIDO",
          habitaciones: habitaciones
              .where((element) => element.categoria == tipoHabitacion[0])
              .toList(),
          styleGeneral: styleLigth,
          styleHeader: styleLigthHeaderTable,
          styleBold: styleBoldTable,
          colorHeader: color,
        ),
      );
      tablas.add(pw.SizedBox(height: 10));
    }

    if (habitaciones.any((element) => element.categoria == tipoHabitacion[1])) {
      tablas.add(
        FilesTemplate.getTablesCotIndiv(
          nameTable:
              "HABITACIÓN DELUXE DOBLE O KING SIZE, VISTA PARCIAL AL OCÉANO – PLAN TODO INCLUIDO",
          habitaciones: habitaciones
              .where((element) => element.categoria == tipoHabitacion[1])
              .toList(),
          styleGeneral: styleLigth,
          styleHeader: styleLigthHeaderTable,
          styleBold: styleBoldTable,
          colorHeader: color,
        ),
      );
      tablas.add(pw.SizedBox(height: 10));
    }

    return pw.Column(children: tablas);
  }

  Future<pw.Image> getImagePDF(String route) async {
    final image = await rootBundle.load('assets/image/$route');
    final imageBytes = image.buffer.asUint8List();
    return pw.Image(pw.MemoryImage(imageBytes),
        width: 194, height: 128, fit: pw.BoxFit.fill);
  }
}
