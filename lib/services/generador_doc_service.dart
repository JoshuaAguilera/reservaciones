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
      marginBottom: (2.5 * 0.4) * PdfPageFormat.cm,
      marginTop: (3.13 * 0.393) * PdfPageFormat.cm,
      marginLeft: 3 * PdfPageFormat.cm,
      marginRight: 3 * PdfPageFormat.cm,
    );

    //Header
    final img = await rootBundle.load('assets/image/logo_header.png');
    final imageBytes = img.buffer.asUint8List();
    pw.Image logoHeaderImage = pw.Image(pw.MemoryImage(imageBytes), width: 131);

    //Styles
    pw.TextStyle styleLigthHeader = await TextStyles.pwStylePDF();
    pw.TextStyle styleLigth = await TextStyles.pwStylePDF(size: 6.8);
    pw.TextStyle styleLigthHeaderTable =
        await TextStyles.pwStylePDF(size: 7, isWhite: true, isBold: true);
    pw.TextStyle styleBold = await TextStyles.pwStylePDF(size: 7, isBold: true);
    pw.TextStyle styleBoldUnderline =
        await TextStyles.pwStylePDF(size: 7, isBold: true, withUnderline: true);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: pageFormatDefault,
        header: (context) {
          return pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                logoHeaderImage,
                pw.Padding(
                    padding: const pw.EdgeInsets.only(bottom: 10),
                    child: pw.Text(
                        "Bahías de Huatulco Oaxaca a ${Utility.getCompleteDate()}",
                        style: styleLigthHeader))
              ]);
        },
        build: (context) => [
          pw.SizedBox(
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.SizedBox(height: 15),
                  pw.Text("ESTIMAD@:", style: styleBold),
                  pw.SizedBox(height: 13),
                  pw.Text(DocTemplates.StructureDoc(1), style: styleLigth),
                  pw.SizedBox(height: 13),
                  pw.Text(DocTemplates.StructureDoc(2), style: styleLigth),
                  pw.SizedBox(height: 13),
                  DocTemplates.getTablesCotIndiv(
                    nameTable:
                        "HABITACIÓN DELUXE DOBLE, VISTA A LA RESERVA – PLAN TODO INCLUIDO",
                    cotizaciones: cotizaciones,
                    styleGeneral: styleLigth,
                    styleHeader: styleLigthHeaderTable,
                    styleBold: styleBold,
                  ),
                  pw.SizedBox(height: 20),
                  DocTemplates.getTablesCotIndiv(
                    nameTable:
                        "HABITACIÓN DELUXE DOBLE, VISTA A LA RESERVA – SOLO HOSPEDAJE",
                    cotizaciones: cotizaciones,
                    styleGeneral: styleLigth,
                    styleHeader: styleLigthHeaderTable,
                    styleBold: styleBold,
                  ),
                  pw.SizedBox(height: 20),
                  DocTemplates.getTablesCotIndiv(
                    nameTable:
                        "HABITACIÓN DELUXE DOBLE O KING SIZE, VISTA PARCIAL AL OCÉANO – PLAN TODO INCLUIDO",
                    cotizaciones: cotizaciones,
                    styleGeneral: styleLigth,
                    styleHeader: styleLigthHeaderTable,
                    styleBold: styleBold,
                  ),
                  pw.SizedBox(height: 20),
                  DocTemplates.getTablesCotIndiv(
                    nameTable:
                        "HABITACIÓN DELUXE DOBLE O KING SIZE, VISTA PARCIAL AL OCÉANO – SOLO HOSPEDAJE ",
                    cotizaciones: cotizaciones,
                    styleGeneral: styleLigth,
                    styleHeader: styleLigthHeaderTable,
                    styleBold: styleBold,
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text("Notas:", style: styleBoldUnderline),
                  pw.SizedBox(height: 10),
                  pw.Text(DocTemplates.StructureDoc(3), style: styleLigth),
                ]),
          ),
        ],
        footer: (context) {
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center, children: []);
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
