import 'package:flutter/services.dart';
import 'package:generador_formato/models/cotizacion_individual_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class DocTemplates {
  static Future<pw.Font> fontLightGoogle() async {
    return PdfGoogleFonts.poppinsLight();
  }

  static Future<pw.Font> fontBoldGoogle() async {
    return PdfGoogleFonts.poppinsMedium();
  }

  static String StructureDoc(int id) {
    switch (id) {
      case 1:
        return "Agradecemos su interés en nuestro hotel CORAL BLUE HUATULCO, de acuerdo con su amable solicitud, me complace en presentarle la siguiente cotización.";
      case 2:
        return "En Hotel Coral Blue Huatulco contamos con 2 categorías de habitación y 2 planes de tarifas, por favor elija la que más le agrade.";
      case 3:
        return "En caso de elegir el plan sin alimentos, puede adquirir estos directamente en los centros de consumo. ";
      default:
        return "Not found";
    }
  }

  static pw.Widget getTablesCotIndiv({
    required List<CotizacionIndividual> cotizaciones,
    required String nameTable,
    required pw.TextStyle styleGeneral,
    required pw.TextStyle styleHeader,
    required pw.TextStyle styleBold,
  }) {
    return pw.Column(children: [
      pw.TableHelper.fromTextArray(
          border: pw.TableBorder.all(width: 0.5),
          headerStyle: styleHeader,
          cellPadding: const pw.EdgeInsets.all(2),
          headerCellDecoration:
              pw.BoxDecoration(color: PdfColor.fromHex("#009999")),
          headers: [nameTable],
          data: []),
      pw.TableHelper.fromTextArray(
        cellStyle: styleGeneral,
        border: pw.TableBorder.all(width: 0.5),
        headerStyle: styleBold,
        cellPadding: pw.EdgeInsets.all(2),
        data: const <List<String>>[
          <String>[
            'DIA',
            'FECHAS DE\nESTANCIA',
            '  ADULTOS  ',
            'MENORES\n0-6',
            'MENORES\n7-12',
            'TARIFA REAL',
            'TARIFA DE PREVENTA\nOFERTA POR TIEMPO LIMITADO',
          ],
          <String>['1', '', '', '', '', '', ''],
          ],
      ),
      pw.Padding(
        padding: const pw.EdgeInsets.only(left: 135),
        child: pw.TableHelper.fromTextArray(
            border: pw.TableBorder.all(width: 0.5),
            headerStyle: styleHeader,
            cellPadding: const pw.EdgeInsets.all(2),
            headerCellDecoration:
                pw.BoxDecoration(color: PdfColor.fromHex("#009999")),
            headers: [
              "TOTAL DE ESTANCIA",
              "\$                   ",
              "\$                                                    ",
            ],
            data: []),
      )
    ]);
    // return pw.Table(border: pw.TableBorder(bottom: pw.BorderSide(color: pw.C)),children: [pw.TableRow(children: [])]);
  }
}
