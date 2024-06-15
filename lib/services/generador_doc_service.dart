import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generador_formato/helpers/doc_templates.dart';
import 'package:generador_formato/helpers/utility.dart';
import 'package:generador_formato/models/cotizacion_individual_model.dart';
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
    pw.TextStyle styleLigthHeader =
        pw.TextStyle(font: await DocTemplates.fontLightGoogle(), fontSize: 6.3);
    pw.TextStyle styleLigth =
        pw.TextStyle(font: await DocTemplates.fontLightGoogle(), fontSize: 6.8);
    pw.TextStyle styleBold =
        pw.TextStyle(font: await DocTemplates.fontBoldGoogle(), fontSize: 7);

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
          footer: (context) {
            return pw.Column(children: []);
          },
          build: (context) => [
                pw.SizedBox(
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.SizedBox(height: 15),
                        pw.Text("ESTIMAD@:", style: styleBold),
                        pw.SizedBox(height: 13),
                        pw.Text(DocTemplates.StructureDoc(1),
                            style: styleLigth),
                        pw.SizedBox(height: 13),
                        pw.Text(DocTemplates.StructureDoc(2),
                            style: styleLigth),
                        pw.SizedBox(height: 13),
                        DocTemplates.getTablesCotIndiv(
                            cotizaciones, context, styleLigth)
                      ]),
                ),
              ]),
    );
    pdfPrinc = pdf;
    return pdf;
  }

  // getDetallesxDocumento(List<VentaDetalle>? ventaDetalles) {
  //   return pw.Column(
  //     children: [
  //       for (var element in ventaDetalles!)
  //         pw.SizedBox(
  //           width: 365,
  //           child: pw.Column(
  //             crossAxisAlignment: pw.CrossAxisAlignment.start,
  //             children: [
  //               pw.Row(children: [
  //                 pw.SizedBox(
  //                   width: 170,
  //                   child: pw.Text("${element.claveArticulo}",
  //                       softWrap: true, style: style),
  //                 ),
  //                 pw.SizedBox(
  //                   width: 132,
  //                   child: pw.Align(
  //                       alignment: pw.Alignment.center,
  //                       child:
  //                           pw.Text(element.cantidad.toString(), style: style)),
  //                 ),
  //                 pw.SizedBox(
  //                   width: 100,
  //                   child: pw.Text(
  //                       "\$${(element.precioUnitario! * element.cantidad!).toStringAsFixed(2)}",
  //                       style: style),
  //                 )
  //               ]),
  //               pw.SizedBox(height: 5),
  //               pw.SizedBox(
  //                 width: 400,
  //                 child: pw.Text(element.articulo!.nombre!,
  //                     softWrap: true, style: style),
  //               ),
  //               pw.SizedBox(height: 5),
  //               pw.Text(
  //                   "--------------------------------------------------------------------",
  //                   style: style),
  //               pw.SizedBox(height: 15),
  //             ],
  //           ),
  //         )
  //     ],
  //   );
  // }
}
