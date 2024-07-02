import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generador_formato/helpers/constants.dart';
import 'package:generador_formato/helpers/utility.dart';
import 'package:generador_formato/models/cotizacion_model.dart';
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
      case 4:
        return "TARIFA DE ALIMENTOS TIPO BUFFET ADULTOS: DESAYUNO \$280 – COMIDA \$350 – CENA\$440";
      case 5:
        return "TARIFA DE ALIMENTOS TIPO BUFFET MENORES 7 A 12 AÑOS: DESAYUNO \$200 – COMIDA \$280 – CENA \$360";
      case 6:
        return "Tarifas en MXN, por ocupación y por noche. Impuestos ya incluidos.";
      case 7:
        return "Tarifas exclusivas de preventa, sujetas a cambio sin previo aviso.";
      case 8:
        return "Depósito de garantía no es reembolsable. (Sujeto a cambios de fecha)";
      case 9:
        return "Los menores de 0 a 6 años son gratis, menores de 7 a 12 años tienen costo extra por noche, a partir de 13 años ya son considerados como adultos y están incluidos en la cotización final. ";
      case 10:
        return "Nuestras habitaciones son máximo para 4 personas sean adultos o menores.";
      case 11:
        return "Para poder realizar su reservación le solicitamos el depósito de la primera noche como garantía, el resto de su estancia lo liquida a su llegada.";
      case 12:
        return "Temporada baja: 3 días sin penalidad, 2 días genera el cargo de una noche, no show pago total, salidas anticipadas cargo total de estancia.";
      case 13:
        return "Temporada media: 5 días sin penalidad, 4 días genera el cargo de una noche, no show pago total, salidas anticipadas cargo total de estancia.";
      case 14:
        return "Temporada alta: 15 días sin penalidad, 14 días genera el cargo de una noche, no show pago total, salidas anticipadas cargo total de estancia.";
      case 15:
        return "El hotel es 100% libre de humo. No se permite fumar en habitaciones o en otras áreas del hotel.";
      case 16:
        return "Al check in a todo huésped se le requiere dejar en garantía \$1,000 MXN (que puede ser en efectivo o tarjeta de crédito mediante la creación de un voucher abierto) que servirá para cubrir alguna penalidad en caso de perdida o extravio de llaves, toallas o alguna amenidad dentro de la habitación. La garantía de pago será devuelta al huésped al momento de hacer check out (salida de su reservación) y previa revisión al cuarto ocupado sin haber hallado algo roto, dañado, manchado o extraviado.";
      case 17:
        return "Los costos para el hospedaje son en razón de la cantidad de adultos y niños que ingresen a la habitación.";
      case 18:
        return "Se considera adultos a las personas con edad de 18 años cumplidos en adelante.";
      case 19:
        return "Se considera niños hasta los 12 años cumplidos al momento de hacer check in al hotel.";
      case 20:
        return "Propinas a discreción del cliente.";
      case 21:
        return "Pantalla plasma de 32”.";
      case 22:
        return "Aire acondicionado tipo “mini-Split”.";
      case 23:
        return "Teléfono ";
      case 24:
        return "Baño con amenidades, secadora de cabello y espejo de vanidad.";
      case 25:
        return "Caja de seguridad digital. ";
      case 26:
        return "Closet, y kit de planchado";
      case 27:
        return "Cafetera, área de trabajo y sofá.";
      case 28:
        return "Habitación vista parcial al mar incluye frigobar en plan todo incluido.";
      case 29:
        return "Sólo hay cobertura WIFI de internet en determinadas áreas comunes del hotel.";
      case 30:
        return "Habitaciones disponibles: 38 doble vista parcial al mar, 29 king size vista parcial al mar, 39 doble vista verde.";
      case 31:
        return "Check in: 15:00 hrs.";
      case 32:
        return "Check out: 12:00 hrs.";
      case 33:
        return "Solicitudes no realizadas en el momento de la reservación quedan sujetas a disponibilidad.";
      case 34:
        return "Early check in: sujeto a disponibilidad del hotel genera costo extra según la temporada.";
      case 35:
        return "Late check out: sujeto a disponibilidad del hotel genera costo extra según la temporada.";
      case 49:
        return "Desayuno servido en el área de restaurante en horario de 8:00 – 11:30 hrs.";
      case 36:
        return "Comidas disponibles en la zona del restaurante en horario de 13:00 – 17:00 hrs.";
      case 37:
        return "Bar Tortuga abierto de 12:00 – 22:30 hrs. Barra libre en bebidas nacionales para todo incluido.";
      case 38:
        return "Cenas en horario de 19:00 – 22:00 hrs., código de vestimenta para el horario de cena: casual – playa, (no traje de baño, no salidas de baño)";
      case 39:
        return "Cena de especialidades: ";
      case 40:
        return "Lunes: Mar y Tierra";
      case 41:
        return "Martes: Italiano";
      case 42:
        return "Miércoles: Mexicano";
      case 43:
        return "Jueves: Internacional";
      case 44:
        return "Viernes: Italiano";
      case 45:
        return "Sábado: Oaxaqueño";
      case 46:
        return "Domingo: Internacional";
      case 47:
        return "Los alimentos quedan sujeto a ocupación para ser montados en tipo buffet, o bien el cliente podrá tener la opción de elegir de los menús estipulados por el hotel, con previa reservación, garantizando así otorgar el plan todo incluido (para quien reserveen dicho plan) dentro de los horarios previamente mencionados, pero no obligado a montar buffet como parte del servicio.";
      case 48:
        return "Room service de 12:00 – 21:00 hrs. (cargo extra del 20%)";
      case 50:
        return "Alberca adultos abierta de 8:00 – 21:00 hrs.";
      case 51:
        return "Parque acuático para niños abierta de 8:00 – 21:00 hrs.";
      case 52:
        return "Actividades acuáticas no motorizadas incluidas. (sujetas a disponibilidad)";
      case 53:
        return "Área de juegos disponible de 18:00 – 22:00 hrs.";
      case 54:
        return "GYM disponible de 07:00 – 22:00 hrs.";
      case 55:
        return "La Octava área de trabajo con acceso ilimitado a WIFI.";
      case 56:
        return "Nos reservamos el derecho de admisión. ";
      case 57:
        return "Lo invitamos hacer uso correcto de las instalaciones del hotel para que su estancia sea placentera.";
      case 58:
        return "No se permite ingresar alimentos, o bebidas ajenas a nuestros centros de consumo a las áreas comunes del hotel como restaurante, bar, albercas, zona de playa, etc.";
      case 59:
        return "No se permiten bocinas, parlantes o altavoces en la zona de playa, alberca, bar y restaurante o en las habitaciones con ruido excesivo. Nuestro hotel es considerado como un hotel de descanso y se reserva el derecho de admisión sin reembolsos ante estas eventualidades.";
      case 60:
        return "Esperamos con entusiasmo su visita y estamos comprometidos a hacer de su estancia una experiencia excepcional. ¡Gracias por elegirnos!";
      case 61:
        return "Cordialmente";
      default:
        return "Not found";
    }
  }

  static pw.Widget getTablesCotIndiv({
    required List<Cotizacion> cotizaciones,
    required String nameTable,
    required pw.TextStyle styleGeneral,
    required pw.TextStyle styleHeader,
    required pw.TextStyle styleBold,
    bool requiredPreventa = false,
  }) {
    List<List<String>> contenido = [];

    contenido = [
      <String>[
        'DIA',
        'FECHAS DE\nESTANCIA',
        'ADULTOS',
        'MENORES\n0-6',
        'MENORES\n7-12',
        '       TARIFA REAL       ',
        if (cotizaciones.any((element) => element.esPreVenta!))
          'TARIFA DE PREVENTA\nOFERTA POR TIEMPO LIMITADO',
      ]
    ];

    for (var element in cotizaciones) {
      int index = contenido.length - 1;
      contenido.addAll(generateDaysCotizacion(element, index));
    }

    return pw.Column(children: [
      pw.TableHelper.fromTextArray(
          border: pw.TableBorder.all(width: 0.7),
          headerStyle: styleHeader,
          cellPadding: const pw.EdgeInsets.all(4),
          headerCellDecoration:
              pw.BoxDecoration(color: PdfColor.fromHex("#009999")),
          headers: [nameTable],
          data: []),
      pw.TableHelper.fromTextArray(
        cellStyle: styleGeneral,
        border: pw.TableBorder.all(width: 0.9),
        headerStyle: styleBold,
        cellPadding:
            const pw.EdgeInsets.symmetric(horizontal: 1, vertical: 0.5),
        headerPadding: const pw.EdgeInsets.fromLTRB(1.5, 2.5, 1.5, 1),
        cellAlignment: pw.Alignment.center,
        columnWidths: {
          0: const pw.FixedColumnWidth(10),
          1: const pw.FixedColumnWidth(40),
          2: const pw.FixedColumnWidth(30),
          3: const pw.FixedColumnWidth(30),
          4: const pw.FixedColumnWidth(30),
          5: const pw.FixedColumnWidth(60),
        },
        data: contenido,
      ),
      pw.Padding(
        padding: pw.EdgeInsets.only(
            left: (cotizaciones.any((element) => element.esPreVenta!))
                ? 140
                : 177),
        child: pw.TableHelper.fromTextArray(
            border: pw.TableBorder.all(width: 0.9),
            headerStyle: styleHeader,
            columnWidths: {
              0: const pw.FixedColumnWidth(100),
              1: const pw.FixedColumnWidth(100),
              if (cotizaciones.any((element) => element.esPreVenta!))
                2: const pw.FixedColumnWidth(120)
            },
            cellPadding:
                const pw.EdgeInsets.symmetric(horizontal: 2, vertical: 3),
            headerCellDecoration:
                pw.BoxDecoration(color: PdfColor.fromHex("#009999")),
            headers: [
              "TOTAL DE ESTANCIA",
              Utility.formatterNumber(
                  Utility.calculateTarifaTotal(cotizaciones)),
              if (cotizaciones.any((element) => element.esPreVenta!))
                Utility.formatterNumber(Utility.calculateTarifaTotal(
                    cotizaciones,
                    esPreventa: true)),
            ],
            data: []),
      )
    ]);
  }

  static pw.Column getListDocument({
    pw.TextStyle? styleItalic,
    required pw.TextStyle styleLight,
    required pw.TextStyle styleIndice,
    required List<int> idsText,
    bool withRound = false,
    bool isSubIndice = false,
  }) {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          for (var element in idsText)
            if (element == 39)
              textIndice(
                text: StructureDoc(element),
                styleText: styleIndice,
                styleIndice: styleIndice,
                withRound: withRound,
              )
            else if (element == 6 || element == 7)
              textIndice(
                text: StructureDoc(element),
                styleText: styleItalic!,
                styleIndice: styleIndice,
                withRound: withRound,
              )
            else
              textIndice(
                  text: StructureDoc(element),
                  styleText: styleLight,
                  styleIndice: styleIndice,
                  withRound: withRound,
                  isSubindice: isSubIndice),
        ]);
  }

  static pw.Widget textIndice({
    required String text,
    required pw.TextStyle styleText,
    required pw.TextStyle styleIndice,
    String nameIndice = "",
    bool withRound = false,
    bool isSubindice = false,
  }) {
    return pw.Padding(
      padding: pw.EdgeInsets.only(
          left: isSubindice
              ? 53.5
              : withRound
                  ? 17.5
                  : 28.5,
          bottom: isSubindice
              ? 2
              : withRound
                  ? 3.9
                  : 3.2),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: [
          isSubindice
              ? pw.Text("○       ", style: styleIndice)
              : withRound
                  ? pw.Text("●       ", style: styleIndice)
                  : pw.Text("-        ", style: styleIndice),
          pw.SizedBox(
            width: isSubindice
                ? 370
                : withRound
                    ? 406
                    : 395,
            child: pw.Text(
              text,
              style: styleText,
              overflow: pw.TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }

  static List<List<String>> generateDaysCotizacion(
      Cotizacion cotizacion, int index) {
    List<List<String>> dias = [];
    int days = DateTime.parse(cotizacion.fechaSalida!)
        .difference(DateTime.parse(cotizacion.fechaEntrada!))
        .inDays;

    for (int i = 0; i < days; i++) {
      List<String> diasFila = [];
      diasFila.add("${i + 1 + index}");
      diasFila.add(DateTime.parse(cotizacion.fechaEntrada!)
          .add(Duration(days: i))
          .toIso8601String()
          .substring(0, 10));
      diasFila.add("${cotizacion.adultos}");
      diasFila.add("${cotizacion.menores0a6}");
      diasFila.add("${cotizacion.menores7a12}");
      diasFila.add(Utility.formatterNumber(
          Utility.calculateTarifaDiaria(cotizacion: cotizacion)));
      if (cotizacion.esPreVenta!) {
        diasFila.add(Utility.formatterNumber(Utility.calculateTarifaDiaria(
            cotizacion: cotizacion, esPreventa: true)));
      }
      dias.add(diasFila);
    }

    return dias;
  }
}
