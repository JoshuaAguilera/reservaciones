import 'package:flutter/services.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/cotizacion_model.dart';
import 'package:generador_formato/models/registro_tarifa_model.dart';
import 'package:generador_formato/res/helpers/constants.dart';
import 'package:generador_formato/res/helpers/utility.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class FilesTemplate {
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
        return "En Hotel Coral Blue Huatulco contamos con 2 categorías de habitación, por favor elija la que más le agrade.";
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
        return "3 días sin penalidad, 2 días genera el cargo de una noche, no show pago total, salidas anticipadas cargo total de estancia.";
      case 13:
        return "5 días sin penalidad, 4 días genera el cargo de una noche, no show pago total, salidas anticipadas cargo total de estancia.";
      case 14:
        return "15 días sin penalidad, 14 días genera el cargo de una noche, no show pago total, salidas anticipadas cargo total de estancia.";
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
        return "servido en el área de restaurante en horario de 8:00 – 11:30 hrs.";
      case 36:
        return "disponibles en la zona del restaurante en horario de 13:00 – 17:00 hrs.";
      case 37:
        return "abierto de 12:00 – 22:30 hrs. Barra libre en bebidas nacionales para todo incluido.";
      case 38:
        return "en horario de 19:00 – 22:00 hrs., código de vestimenta para el horario de cena: casual – playa, (no traje de baño, no salidas de baño)";
      case 39:
        return "Cena de especialidades: ";
      case 40:
        return "Lunes: Mar y Tierra";
      case 41:
        return "Martes: Oaxaqueño";
      case 42:
        return "Miércoles: Italiano";
      case 43:
        return "Jueves: Tour por Mexico";
      case 44:
        return "Viernes: Italiano";
      case 45:
        return "Sábado: Oaxaqueño";
      case 46:
        return "Domingo: Internacional";
      case 47:
        return "Los alimentos quedan sujeto a ocupación para ser montados en tipo buffet, o bien el cliente podrá tener la opción de elegir de los menús estipulados por el hotel, con previa reservación, garantizando así otorgar el plan todo incluido (para quien reserveen dicho plan) dentro de los horarios previamente mencionados, pero no obligado a montar buffet como parte del servicio.";
      case 48:
        return "de 12:00 – 21:00 hrs. (cargo extra del 20%)";
      case 50:
        return "abierta de 8:00 – 21:00 hrs.";
      case 51:
        return "abierta de 8:00 – 21:00 hrs.";
      case 52:
        return "acuáticas no motorizadas incluidas. (sujetas a disponibilidad)";
      case 53:
        return "disponible de 18:00 – 22:00 hrs.";
      case 54:
        return "disponible de 07:00 – 22:00 hrs.";
      case 55:
        return "área de trabajo con acceso ilimitado a WIFI.";
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
      case 62:
        return "El hotel Coral Blue Huatulco puede albergar de acuerdo con su disponibilidad un total de 326 adultos y hasta 119 menores. Cada habitacion tiene un sofá cama para su mejor distribución con un total de 445 personas entre adultos y menores";
      case 63:
        return "Menores de 0 a 6 años son gratis y menores de 13 años en adelante pagan como adultos. ";
      case 64:
        return "Para realizará el bloqueo de sus habitaciones se requiere un depósito inicial de \$10,000.00 pesos NO REEMBOLSABLES, posteriormente se realizará un programa de pagos hasta cubrir el total de su estancia, mínimo 10 días antes de su llegada.";
      case 65:
        return "Tarifa en MXN, por ocupación, por noche. Precios sujetos a cambios sin previo aviso ";
      case 66:
        return "Favor de evitar realizar cualquier pago antes de realizar su reservación.";
      case 67:
        return "Por cada 15 habitaciones se otorga 1 en cortesía. ";
      case 68:
        return "cotización vigente 15 días";
      case 69:
        return "CAMBIOS DE FECHA: ";
      case 70:
        return "Deberá ser solicitado al departamento de ventas con mínimo 30 días antes de su llegada, de lo contrario se realizará un cargo del 50% del total de la estancia. Se aplicará la tarifa de las nuevas fechas.";
      case 71:
        return "CANCELACION: ";
      case 72:
        return "Deberá solicitarlo al departamento de ventas con mínimo 45 días antes de su llegada, de lo contrario se realizará un cargo del 50% del total de la estancia";
      case 73:
        return "NO SHOW: ";
      case 74:
        return "No presentarse al hotel tendrá penalidad del cargo del 100% del total de la estancia. ";
      case 75:
        return "El coordinador del grupo deberá dejar en garantía \$15,000 MXN (que puede ser en efectivo o tarjeta de crédito mediante la creación de un voucher abierto) que servirá para cubrir alguna penalidad en caso de perdida o extravio de llaves, toallas o alguna amenidad dentro de las habitaciones. La garantía de pago será devuelta al huésped al momento de hacer check out (salida de su reservación) y previa revisión al cuarto ocupado sin haber hallado algo roto, dañado, manchado o extraviado.";
      case 76:
        return "En caso de requerir una salida posterior o una llegada previa a la hora marcada generará un cargo de early check in o late check out, sujeto a disponibilidad del hotel.";
      case 120:
        return "Temporada baja: ";
      case 130:
        return "Temporada media: ";
      case 140:
        return "Temporada alta: ";
      case 149:
        return "Desayuno ";
      case 136:
        return "Comidas ";
      case 137:
        return "Bar Tortuga ";
      case 138:
        return "Cenas ";
      case 148:
        return "Room service ";
      case 150:
        return "Alberca adultos ";
      case 151:
        return "Parque acuático para niños ";
      case 152:
        return "Actividades ";
      case 153:
        return "Área de juegos ";
      case 154:
        return "GYM ";
      case 155:
        return "La Octava ";
      default:
        return "Not found";
    }
  }

  static pw.Widget getTablesCotIndiv({
    required List<Habitacion> habitaciones,
    required String nameTable,
    required pw.TextStyle styleGeneral,
    required pw.TextStyle styleHeader,
    required pw.TextStyle styleBold,
    bool requiredPreventa = false,
    String? colorHeader,
    required String typeRoom,
    int numRooms = 0,
  }) {
    List<List<String>> contenido = [];

    contenido = [
      <String>[
        'DIA',
        '    FECHAS\nDE ESTANCIA',
        'ADULTOS',
        ' MENORES\n0 A 6 AÑOS',
        '  MENORES\n7 A 12 AÑOS',
        '      TARIFA DIARIA      ',
        // '       TARIFA REAL       ',
        // if (cotizaciones.any((element) => element.esPreventa!))
        //   'TARIFA DE PREVENTA\nOFERTA POR TIEMPO LIMITADO',
      ]
    ];

    for (var element in habitaciones) {
      int index = contenido.length - 1;
      contenido.addAll(generateDaysCotizacion(element, index, typeRoom));
    }

    return pw.Column(children: [
      if (numRooms > 1)
        pw.TableHelper.fromTextArray(
          border: pw.TableBorder.all(width: 1),
          headerStyle: styleHeader,
          headerCellDecoration: pw.BoxDecoration(
              color: PdfColor.fromHex(colorHeader ?? "#009999")),
          cellPadding: const pw.EdgeInsets.all(4),
          headers: [Utility.getOcupattionMessage(habitaciones.first)],
          data: [],
        ),
      pw.TableHelper.fromTextArray(
        border: pw.TableBorder.all(width: 1),
        headerStyle: styleHeader,
        cellPadding: const pw.EdgeInsets.all(4),
        headers: [nameTable],
        data: [],
      ),
      pw.TableHelper.fromTextArray(
        cellStyle: styleGeneral,
        cellAlignment: pw.Alignment.center,
        headerAlignment: pw.Alignment.center,
        border: pw.TableBorder.all(width: 1),
        headerCellDecoration: pw.BoxDecoration(
          color: PdfColor.fromHex(colorHeader ?? "#009999"),
        ),
        headerStyle: styleBold,
        cellPadding: const pw.EdgeInsets.symmetric(horizontal: 3, vertical: 4),
        headerPadding: const pw.EdgeInsets.fromLTRB(1.5, 3.5, 1.5, 2),
        columnWidths: {
          0: const pw.FixedColumnWidth(10),
          1: const pw.FixedColumnWidth(40),
          2: const pw.FixedColumnWidth(30),
          3: const pw.FixedColumnWidth(30),
          4: const pw.FixedColumnWidth(30),
          5: const pw.FixedColumnWidth(60),
        },
        headers: contenido.first,
        data: contenido.sublist(1),
      ),
      pw.Padding(
        padding: const pw.EdgeInsets.only(left: 177),
        child: pw.TableHelper.fromTextArray(
          // border: pw.TableBorder.all(width: 0.9),
          border: pw.TableBorder.all(width: 1),
          headerStyle: styleHeader,
          cellStyle: styleHeader,
          columnWidths: {
            0: const pw.FixedColumnWidth(100),
            1: const pw.FixedColumnWidth(100),
            // if (cotizaciones.any((element) => element.esPreventa!))
            //   2: const pw.FixedColumnWidth(160)
          },
          cellPadding:
              const pw.EdgeInsets.symmetric(horizontal: 2, vertical: 3),
          headerCellDecoration: pw.BoxDecoration(
              color: PdfColor.fromHex(colorHeader ?? "#009999")),
          cellDecoration: (index, data, rowNum) => pw.BoxDecoration(
              color: PdfColor.fromHex(colorHeader ?? "#009999")),
          cellAlignment: pw.Alignment.center,
          headers: [
            "TOTAL DE ${habitaciones.first.count > 1 ? "HABITACIÓN" : "ESTANCIA"}",
            Utility.formatterNumber(
              (typeRoom == tipoHabitacion.first
                      ? habitaciones.first.totalVR
                      : habitaciones.first.totalVPM) ??
                  0,
            ),
          ],
          data: [
            if (habitaciones.first.count > 1)
              <String>[
                "TOTAL DE ESTANCIA (x${habitaciones.first.count} rooms)",
                Utility.formatterNumber(
                  ((typeRoom == tipoHabitacion.first
                              ? habitaciones.first.totalVR
                              : habitaciones.first.totalVPM) ??
                          0) *
                      habitaciones.first.count,
                ),
              ],
          ],
        ),
      )
    ]);
  }

  static pw.Widget getTablesCotGroup({
    required Habitacion habitacion,
    required String nameTable,
    required pw.TextStyle styleGeneral,
    required pw.TextStyle styleHeader,
    required pw.TextStyle styleBold,
    bool requiredPreventa = false,
    String? colorHeader,
  }) {
    List<pw.Widget> headers = [
      pw.Text(
        'CATEGORIA DE HABITACION',
        style: styleBold,
      ),
      pw.Text(
        '1 O 2 ADULTOS',
        style: styleBold,
      ),
      pw.Text(
        '3 ADULTOS',
        style: styleBold,
      ),
      pw.Text(
        '4 ADULTOS',
        style: styleBold,
      ),
      pw.Text(
        'MENORES\n7 A 12 AÑOS',
        style: styleBold,
        textAlign: pw.TextAlign.center,
      ),
    ];

    List<List<pw.Widget>> contenido = [];

    double descuentoTarifa =
        habitacion.tarifaXDia?.first.descuentoProvisional ??
            habitacion.tarifaXDia?.first.temporadaSelect?.porcentajePromocion ??
            0;

    TarifaData? tariffVR = habitacion.tarifaXDia?.first.tarifas
        ?.where((element) => element.categoria == tipoHabitacion.first)
        .firstOrNull;

    TarifaData? tariffVPM = habitacion.tarifaXDia?.first.tarifas
        ?.where((element) => element.categoria == tipoHabitacion.last)
        .firstOrNull;

    contenido = [
      <pw.Widget>[
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Text(tipoHabitacion.first, style: styleGeneral),
        ),
        pw.Text(
            Utility.formatterNumber(
              Utility.calculatePromotion(
                (tariffVR?.tarifaAdultoSGLoDBL ?? 0).toString(),
                descuentoTarifa,
                returnDouble: true,
                rounded: !(habitacion.tarifaXDia?.first.modificado ?? false),
              ),
            ),
            style: styleBold),
        pw.Text(
            Utility.formatterNumber(
              Utility.calculatePromotion(
                (tariffVR?.tarifaAdultoTPL ?? 0).toString(),
                descuentoTarifa,
                returnDouble: true,
                rounded: !(habitacion.tarifaXDia?.first.modificado ?? false),
              ),
            ),
            style: styleBold),
        pw.Text(
            Utility.formatterNumber(
              Utility.calculatePromotion(
                (tariffVR?.tarifaAdultoCPLE ?? 0).toString(),
                descuentoTarifa,
                returnDouble: true,
                rounded: !(habitacion.tarifaXDia?.first.modificado ?? false),
              ),
            ),
            style: styleBold),
        pw.Text(
            Utility.formatterNumber(
              Utility.calculatePromotion(
                (tariffVR?.tarifaMenores7a12 ?? 0).toString(),
                descuentoTarifa,
                returnDouble: true,
                rounded: !(habitacion.tarifaXDia?.first.modificado ?? false),
              ),
            ),
            style: styleBold),
      ],
      <pw.Widget>[
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Text(tipoHabitacion.last, style: styleGeneral),
        ),
        pw.Text(
            Utility.formatterNumber(
              Utility.calculatePromotion(
                (tariffVPM?.tarifaAdultoSGLoDBL ?? 0).toString(),
                descuentoTarifa,
                returnDouble: true,
                rounded: !(habitacion.tarifaXDia?.first.modificado ?? false),
              ),
            ),
            style: styleBold),
        pw.Text(
            Utility.formatterNumber(
              Utility.calculatePromotion(
                (tariffVPM?.tarifaAdultoTPL ?? 0).toString(),
                descuentoTarifa,
                returnDouble: true,
                rounded: !(habitacion.tarifaXDia?.first.modificado ?? false),
              ),
            ),
            style: styleBold),
        pw.Text(
            Utility.formatterNumber(
              Utility.calculatePromotion(
                (tariffVPM?.tarifaAdultoCPLE ?? 0).toString(),
                descuentoTarifa,
                returnDouble: true,
                rounded: !(habitacion.tarifaXDia?.first.modificado ?? false),
              ),
            ),
            style: styleBold),
        pw.Text(
            Utility.formatterNumber(
              Utility.calculatePromotion(
                (tariffVPM?.tarifaMenores7a12 ?? 0).toString(),
                descuentoTarifa,
                returnDouble: true,
                rounded: !(habitacion.tarifaXDia?.first.modificado ?? false),
              ),
            ),
            style: styleBold),
      ],
    ];

    return pw.Column(children: [
      pw.TableHelper.fromTextArray(
        border: pw.TableBorder.all(width: 1.5),
        headerStyle: styleBold,
        cellPadding: const pw.EdgeInsets.all(4),
        headers: [nameTable],
        data: [],
      ),
      pw.TableHelper.fromTextArray(
        border: pw.TableBorder.all(width: 1.5),
        headerAlignment: pw.Alignment.center,
        headerHeight: 25,
        headers: headers,
        headerStyle: styleBold,
        cellStyle: styleGeneral,
        headerCellDecoration:
            pw.BoxDecoration(color: PdfColor.fromHex(colorHeader ?? "#33CCCC")),
        cellPadding: const pw.EdgeInsets.symmetric(horizontal: 1, vertical: 1),
        headerPadding: const pw.EdgeInsets.fromLTRB(1.5, 0.5, 1.5, 0.5),
        cellHeight: 23.5,
        cellAlignment: pw.Alignment.center,
        columnWidths: {
          0: const pw.FixedColumnWidth(55),
          1: const pw.FixedColumnWidth(25),
          2: const pw.FixedColumnWidth(25),
          3: const pw.FixedColumnWidth(25),
          4: const pw.FixedColumnWidth(25),
        },
        data: contenido,
      ),
      pw.SizedBox(height: 10),
    ]);
  }

  static pw.Column getListDocument({
    pw.TextStyle? styleItalic,
    required pw.TextStyle styleLight,
    required pw.TextStyle styleIndice,
    required List<int> idsText,
    bool withRound = false,
    bool isSubIndice = false,
    List<pw.Widget>? widgets,
    bool widgetFirst = false,
  }) {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          if (widgets != null && widgetFirst)
            for (pw.Widget widg in widgets)
              textIndice(
                  text: "",
                  styleText: styleLight,
                  styleIndice: styleIndice,
                  withRound: withRound,
                  isSubindice: isSubIndice,
                  widget: widg),
          for (var element in idsText)
            if (element == 39 || element == 64 || element == 65)
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
          if (widgets != null && !widgetFirst)
            for (pw.Widget widg in widgets)
              textIndice(
                  text: "",
                  styleText: styleLight,
                  styleIndice: styleIndice,
                  withRound: withRound,
                  isSubindice: isSubIndice,
                  widget: widg),
        ]);
  }

  static pw.Widget textIndice({
    required String text,
    required pw.TextStyle styleText,
    required pw.TextStyle styleIndice,
    String nameIndice = "",
    bool withRound = false,
    bool isSubindice = false,
    pw.Widget? widget,
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
            child: widget ??
                pw.Text(
                  text,
                  style: styleText,
                  overflow: pw.TextOverflow.clip,
                ),
          ),
        ],
      ),
    );
  }

  static pw.Widget footerPage(
      {required pw.TextStyle styleFooter, required pw.Image whatsAppIcon}) {
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
                whatsAppIcon,
                pw.Text(" 958 186 8767", style: styleFooter)
              ],
            ),
          ),
          pw.Text("Teléfono:  958 525 2061 Ext. 708", style: styleFooter)
        ],
      ),
    );
  }

  static List<List<String>> generateDaysCotizacion(
      Habitacion habitacion, int index, String typeRoom) {
    List<List<String>> dias = [];
    int days = Utility.getDifferenceInDays(habitaciones: [habitacion]);

    for (int i = 0; i < days; i++) {
      double totalAdulto = Utility.calculateTotalTariffRoom(
        RegistroTarifa(
            temporadas: habitacion.tarifaXDia![i].temporadas,
            tarifas: habitacion.tarifaXDia![i].tarifas),
        habitacion,
        habitacion.tarifaXDia!.length,
        descuentoProvisional: habitacion.tarifaXDia![i].descuentoProvisional,
        onlyTariffVR: typeRoom == tipoHabitacion.first,
        onlyTariffVPM: typeRoom == tipoHabitacion.last,
        useCashSeason: habitacion.useCashSeason ?? false,
        applyRoundFormat: !(habitacion.tarifaXDia?[i].modificado ?? false),
      );

      double totalMenores = Utility.calculateTotalTariffRoom(
        RegistroTarifa(
            temporadas: habitacion.tarifaXDia![i].temporadas,
            tarifas: habitacion.tarifaXDia![i].tarifas),
        habitacion,
        habitacion.tarifaXDia!.length,
        descuentoProvisional: habitacion.tarifaXDia![i].descuentoProvisional,
        onlyTariffVR: typeRoom == tipoHabitacion.first,
        onlyTariffVPM: typeRoom == tipoHabitacion.last,
        isCalculateChildren: true,
        useCashSeason: habitacion.useCashSeason ?? false,
        applyRoundFormat: !(habitacion.tarifaXDia?[i].modificado ?? false),
      );

      DateTime now = DateTime.parse(habitacion.fechaCheckIn!);

      List<String> diasFila = [];
      diasFila.add("${i + 1 + index}");
      diasFila.add("${now.day + i}/${now.month}/${now.year}");
      diasFila.add("${habitacion.adultos}");
      diasFila.add("${habitacion.menores0a6}");
      diasFila.add("${habitacion.menores7a12}");
      diasFila.add(Utility.formatterNumber(totalMenores + totalAdulto));
      // if (cotizacion.esPreventa!) {
      //   diasFila.add(Utility.formatterNumber(Utility.calculateTarifaDiaria(
      //       cotizacion: cotizacion, esPreventa: true)));
      // }
      dias.add(diasFila);
    }

    return dias;
  }

  static Future<String> getHTMLMail(
      Cotizacion cotizacion, List<Habitacion> habitaciones) async {
    String mailHTML = "";

    List<Habitacion> rooms =
        habitaciones.where((element) => !element.isFree).toList();

    try {
      String contenidoHtml = await rootBundle.loadString(
          "assets/file/${!(cotizacion.esGrupo ?? false) ? "xsx" : "quote_send_mail_group"}.html");
      String preMailHTML = "";

      if (!(cotizacion.esGrupo ?? false)) {
        preMailHTML = contenidoHtml
            .replaceAll(r'FNAMECUSTOMER', cotizacion.nombreHuesped ?? '')
            .replaceAll(r'FFOLIOQUOTE', "${cotizacion.folioPrincipal}");

        Map<String, List<Habitacion>> quoteFilters = {};

        for (var element in rooms) {
          String selectDates =
              "${element.fechaCheckIn}/${element.fechaCheckOut}";

          if (quoteFilters.containsKey(selectDates)) {
            quoteFilters[selectDates]!.add(element);
          } else {
            final item = {
              selectDates: [element]
            };
            quoteFilters.addEntries(item.entries);
          }
        }

        String contentMail = "";

        for (var roomList in quoteFilters.values) {
          contentMail +=
              '''<p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#131313;font-size:14px"><strong>Plan Todo Incluido</strong><br>Estancia:<strong>FTIMESTATE</strong><br>Noches:<strong>FNUMNIGHT</strong></p>''';

          contentMail = contentMail
              .replaceAll(
                  r'FTIMESTATE', Utility.getPeriodReservation([roomList.first]))
              .replaceAll(r'FNUMNIGHT', "${roomList.first.tarifaXDia!.length}");

          contentMail +=
              '''<p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#131313;font-size:14px"><b>Habitación Deluxe doble, vista a la reserva 🏞️</b></p>''';

          contentMail +=
              '''<p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#131313;font-size:14px"><strong></strong></p>''';
          for (var element in roomList) {
            contentMail +=
                '''<p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#131313;font-size:14px">
                 <u>${Utility.getOcupattionMessage(element)}</u><br><strong>Total por noche ${Utility.formatterNumber(((element.totalVR ?? 1) / (element.tarifaXDia?.length ?? 1)))}&nbsp;&nbsp;<br>Total por ${element.count > 1 ? "habitación" : "estancia"} ${Utility.formatterNumber(element.totalVR ?? 0)}${element.count > 1 ? "&nbsp;&nbsp;<br>Total por estancia ${Utility.formatterNumber((element.totalVR ?? 0) * element.count)}</strong></p>" : "</strong></p>"}''';
          }

          contentMail +=
              '''<p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#131313;font-size:14px"><b>Habitación Deluxe doble o King size, vista parcial al océano 🌊</b></p>''';

          for (var element in roomList) {
            contentMail +=
                '''<p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#131313;font-size:14px">
                 <u>${Utility.getOcupattionMessage(element)}</u><br><strong>Total por noche ${Utility.formatterNumber(((element.totalVPM ?? 1) / (element.tarifaXDia?.length ?? 1)))}&nbsp;&nbsp;<br>Total por ${element.count > 1 ? "habitación" : "estancia"} ${Utility.formatterNumber(element.totalVPM ?? 0)}${element.count > 1 ? "&nbsp;&nbsp;<br>Total por estancia ${Utility.formatterNumber((element.totalVPM ?? 0) * element.count)}</strong></p>" : "</strong></p>"}''';
          }

          contentMail +=
              ''' <p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#131313;font-size:14px">
                                                                        <strong></strong><br></p>''';
        }

        mailHTML = preMailHTML.replaceAll(r'LISTROOMSINSERT', contentMail);
      } else {
        preMailHTML = contenidoHtml.replaceAll(
            r'FNAMECUSTOMER', cotizacion.nombreHuesped ?? '');
        mailHTML = preMailHTML;
      }
    } catch (e) {
      print("Error al cargar el archivo HTML: $e");
    }

    return mailHTML;
  }
}
