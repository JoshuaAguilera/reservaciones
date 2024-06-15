import 'package:generador_formato/models/cotizacion_individual_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class DocTemplates {
  static Future<pw.Font> fontLightGoogle() async {
    return PdfGoogleFonts.poppinsLight();
  }

  static Future<pw.Font> fontBoldGoogle() async {
    return PdfGoogleFonts.poppinsBold();
  }

  static String StructureDoc(int id) {
    String text = "";

    switch (id) {
      case 1:
        text =
            "Agradecemos su interés en nuestro hotel CORAL BLUE HUATULCO, de acuerdo con su amable solicitud, me complace en presentarle la siguiente cotización.";
        break;
      case 2:
        text =
            "En Hotel Coral Blue Huatulco contamos con 2 categorías de habitación y 2 planes de tarifas, por favor elija la que más le agrade.";
        break;
      default:
        text = "Not found";
    }

    return text;
  }

  static pw.Table getTablesCotIndiv(List<CotizacionIndividual> cotizaciones,
      pw.Context context, pw.TextStyle styleLigth) {
    return pw.TableHelper.fromTextArray(
      cellStyle: styleLigth,
      context: context,
      data: const <List<String>>[
        <String>[
          'DIA',
          'FECHAS DE ESTANCIA',
          'ADULTOS',
          'MENORES 0-6',
          'MENORES 7-12',
          'TARIFA REAL',
          'TARIFA DE PREVENTA OFERTA POR TIEMPO LIMITADO',
        ],
        <String>['', '', '', '', '', '', ''],
        <String>['', '', '', '', '', '', ''],
        <String>['', '', '', '', '', '', ''],
        <String>['', '', '', '', '', '', ''],
      ],
    );
  }
}
