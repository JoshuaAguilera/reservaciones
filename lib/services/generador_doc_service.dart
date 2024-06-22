import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generador_formato/helpers/doc_templates.dart';
import 'package:generador_formato/helpers/utility.dart';
import 'package:generador_formato/models/cotizacion_individual_model.dart';
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
      List<CotizacionIndividual> cotizaciones) async {
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
                  pw.Text("ESTIMAD@:", style: styleBold),
                  pw.SizedBox(height: 13),
                  pw.Text(DocTemplates.StructureDoc(1), style: styleLigth),
                  pw.SizedBox(height: 14),
                  pw.Text(DocTemplates.StructureDoc(2), style: styleLigth),
                  pw.SizedBox(height: 12),
                  DocTemplates.getTablesCotIndiv(
                    nameTable:
                        "HABITACIÓN DELUXE DOBLE, VISTA A LA RESERVA – PLAN TODO INCLUIDO",
                    cotizaciones: cotizaciones,
                    styleGeneral: styleLigth,
                    styleHeader: styleLigthHeaderTable,
                    styleBold: styleBoldTable,
                  ),
                  pw.SizedBox(height: 20),
                  DocTemplates.getTablesCotIndiv(
                    nameTable:
                        "HABITACIÓN DELUXE DOBLE, VISTA A LA RESERVA – SOLO HOSPEDAJE",
                    cotizaciones: cotizaciones,
                    styleGeneral: styleLigth,
                    styleHeader: styleLigthHeaderTable,
                    styleBold: styleBoldTable,
                  ),
                  pw.SizedBox(height: 20),
                  DocTemplates.getTablesCotIndiv(
                    nameTable:
                        "HABITACIÓN DELUXE DOBLE O KING SIZE, VISTA PARCIAL AL OCÉANO – PLAN TODO INCLUIDO",
                    cotizaciones: cotizaciones,
                    styleGeneral: styleLigth,
                    styleHeader: styleLigthHeaderTable,
                    styleBold: styleBoldTable,
                  ),
                  pw.SizedBox(height: 20),
                  DocTemplates.getTablesCotIndiv(
                    nameTable:
                        "HABITACIÓN DELUXE DOBLE O KING SIZE, VISTA PARCIAL AL OCÉANO – SOLO HOSPEDAJE ",
                    cotizaciones: cotizaciones,
                    styleGeneral: styleLigth,
                    styleHeader: styleLigthHeaderTable,
                    styleBold: styleBoldTable,
                  ),
                  pw.SizedBox(height: 25),
                  pw.Text("NOTAS", style: styleBoldUnderline),
                  pw.SizedBox(height: 10),
                  pw.Text(DocTemplates.StructureDoc(3), style: styleRegular),
                  pw.SizedBox(height: 10),
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 27),
                    child: pw.Text(DocTemplates.StructureDoc(4),
                        style: styleItalic),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 27),
                    child: pw.Text(DocTemplates.StructureDoc(5),
                        style: styleItalic),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text("POLÍTICAS PARA RESERVACIÓN",
                      style: styleBoldUnderline),
                  pw.SizedBox(height: 0),
                  DocTemplates.getListDocument(
                      styleItalic: styleItalic,
                      styleLight: styleLigth,
                      styleIndice: styleBold,
                      idsText: [6, 7, 8, 9, 10, 11]),
                  pw.SizedBox(height: 10),
                  pw.Text("POLÍTICAS DE CANCELACIÓN",
                      style: styleBoldUnderline),
                  pw.SizedBox(height: 11),
                  DocTemplates.getListDocument(
                      styleLight: styleLigth,
                      styleIndice: styleBold,
                      idsText: [12, 13, 14]),
                  pw.SizedBox(height: 10),
                  pw.Text("POLÍTICAS Y CONDICIONES GENERALES",
                      style: styleBoldUnderline),
                  pw.SizedBox(height: 12),
                  DocTemplates.getListDocument(
                      withRound: true,
                      styleLight: styleLigth,
                      styleIndice: styleBold,
                      idsText: [15, 16, 17, 18, 19, 20]),
                  pw.SizedBox(height: 10),
                  pw.Text("CARACTERÍSTICAS DE LAS HABITACIONES",
                      style: styleBoldUnderline),
                  pw.SizedBox(height: 12),
                  DocTemplates.getListDocument(
                      withRound: true,
                      styleLight: styleLigth,
                      styleIndice: styleBold,
                      idsText: [21, 22, 23, 24, 25, 26, 27, 28, 29, 30]),
                  pw.SizedBox(height: 10),
                  pw.Text("GENERALES", style: styleBoldUnderline),
                  pw.SizedBox(height: 12),
                  DocTemplates.getListDocument(
                      withRound: true,
                      styleLight: styleLigth,
                      styleIndice: styleBold,
                      idsText: [31, 32, 33, 34, 35]),
                  pw.SizedBox(height: 10),
                  pw.Text("HORARIOS Y SERVICIOS RESTAURANTE CORALES:",
                      style: styleBold),
                  pw.SizedBox(height: 12),
                  DocTemplates.getListDocument(
                      withRound: true,
                      styleLight: styleLigth,
                      styleIndice: styleBold,
                      idsText: [49, 36, 37, 38, 39]),
                  pw.SizedBox(height: 8),
                  DocTemplates.getListDocument(
                      withRound: true,
                      isSubIndice: true,
                      styleLight: styleLigth,
                      styleIndice: styleBold,
                      idsText: [40, 41, 42, 43, 44, 45, 46]),
                  pw.SizedBox(height: 10),
                  DocTemplates.getListDocument(
                      withRound: true,
                      styleLight: styleLigth,
                      styleIndice: styleBold,
                      idsText: [47, 48]),
                  pw.SizedBox(height: 14),
                  pw.Text("FACILIDADES", style: styleBold),
                  pw.SizedBox(height: 13),
                  DocTemplates.getListDocument(
                      withRound: true,
                      styleLight: styleLigth,
                      styleIndice: styleBold,
                      idsText: [50, 51, 52, 53, 54, 55]),
                  pw.SizedBox(height: 9),
                  pw.Text(DocTemplates.StructureDoc(56), style: styleBold),
                  pw.Text(DocTemplates.StructureDoc(57), style: styleLigth),
                  pw.SizedBox(height: 13),
                  DocTemplates.getListDocument(
                      withRound: true,
                      styleLight: styleLigth,
                      styleIndice: styleBold,
                      idsText: [58, 59]),
                  pw.SizedBox(height: 11),
                  pw.Text(DocTemplates.StructureDoc(60), style: styleLigth),
                  pw.SizedBox(height: 10),
                  pw.Text(DocTemplates.StructureDoc(61), style: styleLigth),
                  pw.SizedBox(height: 10),
                ]),
          ),
        ],
        footer: (context) {
          return pw.Center(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.SizedBox(height: 20),
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

  Future<Uint8List> saveDocument() async {
    pw.Document doc = await generarComprobanteCotizacion([]);

    return await doc.save();
  }
}
