import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generador_formato/utils/helpers/files_templates.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/models/comprobante_cotizacion_model.dart';
import 'package:generador_formato/models/cotizacion_model.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class GeneradorDocService extends ChangeNotifier {
  late pw.Document pdfPrinc;
  pw.Document get pdfPrincget => this.pdfPrinc;

  //styles
  pw.TextStyle styleTag =
      pw.TextStyle(color: PdfColor.fromHex("#2A00A0"), fontSize: 16, height: 2);

  Future<pw.Document> generarComprobanteCotizacion(
      List<Cotizacion> cotizaciones, ComprobanteCotizacion comprobante) async {
    //PDF generation
    final pdf = pw.Document();
    PdfPageFormat pageFormatDefault = const PdfPageFormat(
      21.59 * PdfPageFormat.cm,
      27.94 * PdfPageFormat.cm,
      marginBottom: (2.5 * 0.2) * PdfPageFormat.cm,
      marginTop: (3.13 * 0.393) * PdfPageFormat.cm,
      marginLeft: 3 * PdfPageFormat.cm,
      marginRight: 3 * PdfPageFormat.cm,
    );

    //Header
    final img = await rootBundle.load('assets/image/logo_header.png');
    final imageBytes = img.buffer.asUint8List();
    pw.Image logoHeaderImage = pw.Image(pw.MemoryImage(imageBytes), width: 131);

    //Footer
    final imgWhatsApp = await rootBundle.load('assets/image/whatsApp_icon.png');
    final imageBytesW = imgWhatsApp.buffer.asUint8List();
    pw.Image whatsAppImage = pw.Image(pw.MemoryImage(imageBytesW), width: 9);

    //Styles
    pw.TextStyle styleLigthHeader = await TextStyles.pwStylePDF(size: 8);
    pw.TextStyle styleLigth = await TextStyles.pwStylePDF(size: 8);
    pw.TextStyle styleLigthHeaderTable =
        await TextStyles.pwStylePDF(size: 8, isWhite: true, isBold: true);
    pw.TextStyle styleBold = await TextStyles.pwStylePDF(size: 8, isBold: true);
    pw.TextStyle styleBoldTable =
        await TextStyles.pwStylePDF(size: 7, isBold: true, lineSpacing: 1);
    pw.TextStyle styleBoldUnderline =
        await TextStyles.pwStylePDF(size: 8, isBold: true, withUnderline: true);
    pw.TextStyle styleItalic =
        await TextStyles.pwStylePDF(size: 8, isItalic: true, isBold: true);
    pw.TextStyle styleFooter =
        await TextStyles.pwStylePDF(size: 8, isRegular: true);
    pw.TextStyle styleRegular =
        await TextStyles.pwStylePDF(size: 8.4, isBold: true);

    // text Asotiative
    pw.RichText cancelPolity1 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(120),
        content: FilesTemplate.StructureDoc(12),
        size: 8);
    pw.RichText cancelPolity2 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(130),
        content: FilesTemplate.StructureDoc(13),
        size: 8);
    pw.RichText cancelPolity3 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(140),
        content: FilesTemplate.StructureDoc(14),
        size: 8);

    pw.RichText service1 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(149),
        content: FilesTemplate.StructureDoc(49),
        size: 8);
    pw.RichText service2 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(136),
        content: FilesTemplate.StructureDoc(36),
        size: 8);
    pw.RichText service3 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(137),
        content: FilesTemplate.StructureDoc(37),
        size: 8);
    pw.RichText service4 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(138),
        content: FilesTemplate.StructureDoc(38),
        size: 8);
    pw.RichText service5 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(148),
        content: FilesTemplate.StructureDoc(48),
        size: 8);

    //facilities
    pw.RichText ease1 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(150),
        content: FilesTemplate.StructureDoc(50),
        size: 8);
    pw.RichText ease2 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(151),
        content: FilesTemplate.StructureDoc(51),
        size: 8);
    pw.RichText ease3 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(152),
        content: FilesTemplate.StructureDoc(52),
        size: 8);
    pw.RichText ease4 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(153),
        content: FilesTemplate.StructureDoc(53),
        size: 8);
    pw.RichText ease5 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(154),
        content: FilesTemplate.StructureDoc(54),
        size: 8);
    pw.RichText ease6 = await TextStyles.pwTextAsotiation(
        title: FilesTemplate.StructureDoc(155),
        content: FilesTemplate.StructureDoc(55),
        size: 8);

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
                  padding: const pw.EdgeInsets.only(bottom: 10),
                  child: pw.Text(
                      "Bahías de Huatulco Oaxaca a ${Utility.getCompleteDate()}",
                      style: styleLigthHeader),
                ),
              ],
            ),
            pw.SizedBox(height: 18),
          ]);
        },
        build: (context) => [
          pw.SizedBox(
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text("ESTIMAD@: ${comprobante.nombre}", style: styleBold),
                  pw.SizedBox(height: 13),
                  pw.Text(FilesTemplate.StructureDoc(1), style: styleLigth),
                  pw.SizedBox(height: 14),
                  pw.Text(FilesTemplate.StructureDoc(2), style: styleLigth),
                  pw.SizedBox(height: 12),
                  generateTables(cotizaciones, styleLigth,
                      styleLigthHeaderTable, styleBoldTable),
                  pw.Text("NOTAS", style: styleBoldUnderline),
                  pw.SizedBox(height: 10),
                  pw.Text(FilesTemplate.StructureDoc(3), style: styleRegular),
                  pw.SizedBox(height: 10),
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 27),
                    child: pw.Text(FilesTemplate.StructureDoc(4),
                        style: styleItalic),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 27),
                    child: pw.Text(FilesTemplate.StructureDoc(5),
                        style: styleItalic),
                  ),
                  pw.SizedBox(height: 20),
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
                  pw.SizedBox(height: 12),
                  FilesTemplate.getListDocument(
                      withRound: true,
                      styleLight: styleLigth,
                      styleIndice: styleBold,
                      idsText: [15, 16, 17, 18, 19, 20]),
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
          return pw.Center(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.SizedBox(height: 15),
                pw.Text(
                    "Dirección: Manzana 3, Lote 8, Sector Mirador Chahué, Huatulco, Oaxaca, México",
                    style: styleFooter),
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 2),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text("Correo: reservas@coralbluehuatulco.mx  ",
                          style: styleFooter),
                      whatsAppImage,
                      pw.Text(" 958 186 8767", style: styleFooter)
                    ],
                  ),
                ),
                pw.Text("Teléfono:  958 525 2061 Ext. 708", style: styleFooter)
              ],
            ),
          );
        },
      ),
    );
    pdfPrinc = pdf;
    return pdf;
  }

  pw.Column generateTables(
      List<Cotizacion> cotizaciones,
      pw.TextStyle styleLigth,
      pw.TextStyle styleLigthHeaderTable,
      pw.TextStyle styleBoldTable) {
    List<pw.Widget> tablas = [];

    if (cotizaciones
        .any((element) => element.categoria == "HABITACIÓN DELUXE DOBLE")) {
      if (cotizaciones.any((element) => element.plan == "PLAN TODO INCLUIDO")) {
        tablas.add(
          FilesTemplate.getTablesCotIndiv(
            nameTable:
                "HABITACIÓN DELUXE DOBLE, VISTA A LA RESERVA – PLAN TODO INCLUIDO",
            cotizaciones: cotizaciones
                .where((element) =>
                    element.plan == "PLAN TODO INCLUIDO" &&
                    element.categoria == "HABITACIÓN DELUXE DOBLE")
                .toList(),
            styleGeneral: styleLigth,
            styleHeader: styleLigthHeaderTable,
            styleBold: styleBoldTable,
          ),
        );
        tablas.add(pw.SizedBox(height: 20));
      }
      if (cotizaciones.any((element) => element.plan == "SOLO HOSPEDAJE")) {
        tablas.add(FilesTemplate.getTablesCotIndiv(
          nameTable:
              "HABITACIÓN DELUXE DOBLE, VISTA A LA RESERVA – SOLO HOSPEDAJE",
          cotizaciones: cotizaciones
              .where((element) =>
                  element.plan == "SOLO HOSPEDAJE" &&
                  element.categoria == "HABITACIÓN DELUXE DOBLE")
              .toList(),
          styleGeneral: styleLigth,
          styleHeader: styleLigthHeaderTable,
          styleBold: styleBoldTable,
        ));
        tablas.add(pw.SizedBox(height: 20));
      }
    }

    if (cotizaciones.any((element) =>
        element.categoria == "HABITACIÓN DELUXE DOBLE O KING SIZE")) {
      if (cotizaciones.any((element) => element.plan == "PLAN TODO INCLUIDO")) {
        tablas.add(
          FilesTemplate.getTablesCotIndiv(
            nameTable:
                "HABITACIÓN DELUXE DOBLE O KING SIZE, VISTA PARCIAL AL OCÉANO – PLAN TODO INCLUIDO",
            cotizaciones: cotizaciones
                .where((element) =>
                    element.plan == "PLAN TODO INCLUIDO" &&
                    element.categoria == "HABITACIÓN DELUXE DOBLE O KING SIZE")
                .toList(),
            styleGeneral: styleLigth,
            styleHeader: styleLigthHeaderTable,
            styleBold: styleBoldTable,
          ),
        );
        tablas.add(pw.SizedBox(height: 20));
      }
      if (cotizaciones.any((element) => element.plan == "SOLO HOSPEDAJE")) {
        tablas.add(FilesTemplate.getTablesCotIndiv(
          nameTable:
              "HABITACIÓN DELUXE DOBLE O KING SIZE, VISTA PARCIAL AL OCÉANO – SOLO HOSPEDAJE ",
          cotizaciones: cotizaciones
              .where((element) =>
                  element.plan == "SOLO HOSPEDAJE" &&
                  element.categoria == "HABITACIÓN DELUXE DOBLE O KING SIZE")
              .toList(),
          styleGeneral: styleLigth,
          styleHeader: styleLigthHeaderTable,
          styleBold: styleBoldTable,
        ));
        tablas.add(pw.SizedBox(height: 20));
      }
    }

    return pw.Column(children: tablas);
  }
}
