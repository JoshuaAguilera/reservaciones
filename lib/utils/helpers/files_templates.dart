import 'package:generador_formato/models/cotizacion_model.dart';
import 'package:generador_formato/models/registro_tarifa_model.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
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
        '       TARIFA REAL       ',
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
            "TOTAL DE ESTANCIA",
            Utility.formatterNumber(
              (typeRoom == tipoHabitacion.first
                      ? habitaciones.first.totalVR
                      : habitaciones.first.totalVPM) ??
                  0,
            ),
          ],
          data: [],
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

    contenido = [
      <pw.Widget>[
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Text(tipoHabitacion.first, style: styleGeneral),
        ),
        pw.Text(
            Utility.formatterNumber(
              Utility.calculatePromotion(
                (habitacion.tarifaXDia?.first.tarifas?.first
                            .tarifaAdultoSGLoDBL ??
                        0)
                    .toString(),
                descuentoTarifa,
                returnDouble: true,
              ),
            ),
            style: styleBold),
        pw.Text(
            Utility.formatterNumber(
              Utility.calculatePromotion(
                (habitacion.tarifaXDia?.first.tarifas?.first.tarifaAdultoTPL ??
                        0)
                    .toString(),
                descuentoTarifa,
                returnDouble: true,
              ),
            ),
            style: styleBold),
        pw.Text(
            Utility.formatterNumber(
              Utility.calculatePromotion(
                (habitacion.tarifaXDia?.first.tarifas?.first.tarifaAdultoCPLE ??
                        0)
                    .toString(),
                descuentoTarifa,
                returnDouble: true,
              ),
            ),
            style: styleBold),
        pw.Text(
            Utility.formatterNumber(
              Utility.calculatePromotion(
                (habitacion.tarifaXDia?.first.tarifas?.first
                            .tarifaMenores7a12 ??
                        0)
                    .toString(),
                descuentoTarifa,
                returnDouble: true,
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
                (habitacion.tarifaXDia?.first.tarifas?.last
                            .tarifaAdultoSGLoDBL ??
                        0)
                    .toString(),
                descuentoTarifa,
                returnDouble: true,
              ),
            ),
            style: styleBold),
        pw.Text(
            Utility.formatterNumber(
              Utility.calculatePromotion(
                (habitacion.tarifaXDia?.first.tarifas?.last.tarifaAdultoTPL ??
                        0)
                    .toString(),
                descuentoTarifa,
                returnDouble: true,
              ),
            ),
            style: styleBold),
        pw.Text(
            Utility.formatterNumber(
              Utility.calculatePromotion(
                (habitacion.tarifaXDia?.first.tarifas?.last.tarifaAdultoCPLE ??
                        0)
                    .toString(),
                descuentoTarifa,
                returnDouble: true,
              ),
            ),
            style: styleBold),
        pw.Text(
            Utility.formatterNumber(
              Utility.calculatePromotion(
                (habitacion.tarifaXDia?.first.tarifas?.last.tarifaMenores7a12 ??
                        0)
                    .toString(),
                descuentoTarifa,
                returnDouble: true,
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

  static String getHTML(
      Cotizacion receiptQuotePresent, List<Habitacion> quotesPresent) {
    String emailHtmlPart1 = '''
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> <html dir="ltr" xmlns="http://www.w3.org/1999/xhtml" xmlns:o="urn:schemas-microsoft-com:office:office" lang="es"> <head> <meta charset="UTF-8"> <meta content="width=device-width, initial-scale=1" name="viewport"> <meta name="x-apple-disable-message-reformatting"> <meta http-equiv="X-UA-Compatible" content="IE=edge"> <meta content="telephone=no" name="format-detection"> <title>New Message</title> <!--[if (mso 16)]><style type="text/css"> a {text-decoration: none;}  </style><![endif]--> <!--[if gte mso 9]><style>sup { font-size: 100% !important; }</style><![endif]--> <!--[if gte mso 9]><noscript> <xml> <o:OfficeDocumentSettings> <o:AllowPNG></o:AllowPNG> <o:PixelsPerInch>96</o:PixelsPerInch> </o:OfficeDocumentSettings> </xml> </noscript>
<![endif]--> <style type="text/css">#outlook a { padding:0;}.es-button { mso-style-priority:100!important; text-decoration:none!important;}a[x-apple-data-detectors] { color:inherit!important; text-decoration:none!important; font-size:inherit!important; font-family:inherit!important; font-weight:inherit!important; line-height:inherit!important;}.es-desk-hidden { display:none; float:left; overflow:hidden; width:0; max-height:0; line-height:0; mso-hide:all;}@media only screen and (max-width:600px) {p, ul li, ol li, a { line-height:150%!important } h1, h2, h3, h1 a, h2 a, h3 a { line-height:120% } h1 { font-size:36px!important; text-align:left } h2 { font-size:26px!important; text-align:left } h3 { font-size:20px!important; text-align:left } .es-header-body h1 a, .es-content-body h1 a, .es-footer-body h1 a { font-size:36px!important; text-align:left }
 .es-header-body h2 a, .es-content-body h2 a, .es-footer-body h2 a { font-size:26px!important; text-align:left } .es-header-body h3 a, .es-content-body h3 a, .es-footer-body h3 a { font-size:20px!important; text-align:left } .es-menu td a { font-size:12px!important } .es-header-body p, .es-header-body ul li, .es-header-body ol li, .es-header-body a { font-size:14px!important } .es-content-body p, .es-content-body ul li, .es-content-body ol li, .es-content-body a { font-size:16px!important } .es-footer-body p, .es-footer-body ul li, .es-footer-body ol li, .es-footer-body a { font-size:14px!important } .es-infoblock p, .es-infoblock ul li, .es-infoblock ol li, .es-infoblock a { font-size:12px!important } *[class="gmail-fix"] { display:none!important } .es-m-txt-c, .es-m-txt-c h1, .es-m-txt-c h2, .es-m-txt-c h3 { text-align:center!important } .es-m-txt-r, .es-m-txt-r h1, .es-m-txt-r h2, .es-m-txt-r h3 { text-align:right!important }
 .es-m-txt-l, .es-m-txt-l h1, .es-m-txt-l h2, .es-m-txt-l h3 { text-align:left!important } .es-m-txt-r img, .es-m-txt-c img, .es-m-txt-l img { display:inline!important } .es-button-border { display:inline-block!important } a.es-button, button.es-button { font-size:20px!important; display:inline-block!important } .es-adaptive table, .es-left, .es-right { width:100%!important } .es-content table, .es-header table, .es-footer table, .es-content, .es-footer, .es-header { width:100%!important; max-width:600px!important } .es-adapt-td { display:block!important; width:100%!important } .adapt-img { width:100%!important; height:auto!important } .es-m-p0 { padding:0!important } .es-m-p0r { padding-right:0!important } .es-m-p0l { padding-left:0!important } .es-m-p0t { padding-top:0!important } .es-m-p0b { padding-bottom:0!important } .es-m-p20b { padding-bottom:20px!important } .es-mobile-hidden, .es-hidden { display:none!important }
 tr.es-desk-hidden, td.es-desk-hidden, table.es-desk-hidden { width:auto!important; overflow:visible!important; float:none!important; max-height:inherit!important; line-height:inherit!important } tr.es-desk-hidden { display:table-row!important } table.es-desk-hidden { display:table!important } td.es-desk-menu-hidden { display:table-cell!important } .es-menu td { width:1%!important } table.es-table-not-adapt, .esd-block-html table { width:auto!important } table.es-social { display:inline-block!important } table.es-social td { display:inline-block!important } .es-m-p5 { padding:5px!important } .es-m-p5t { padding-top:5px!important } .es-m-p5b { padding-bottom:5px!important } .es-m-p5r { padding-right:5px!important } .es-m-p5l { padding-left:5px!important } .es-m-p10 { padding:10px!important } .es-m-p10t { padding-top:10px!important } .es-m-p10b { padding-bottom:10px!important } .es-m-p10r { padding-right:10px!important }
 .es-m-p10l { padding-left:10px!important } .es-m-p15 { padding:15px!important } .es-m-p15t { padding-top:15px!important } .es-m-p15b { padding-bottom:15px!important } .es-m-p15r { padding-right:15px!important } .es-m-p15l { padding-left:15px!important } .es-m-p20 { padding:20px!important } .es-m-p20t { padding-top:20px!important } .es-m-p20r { padding-right:20px!important } .es-m-p20l { padding-left:20px!important } .es-m-p25 { padding:25px!important } .es-m-p25t { padding-top:25px!important } .es-m-p25b { padding-bottom:25px!important } .es-m-p25r { padding-right:25px!important } .es-m-p25l { padding-left:25px!important } .es-m-p30 { padding:30px!important } .es-m-p30t { padding-top:30px!important } .es-m-p30b { padding-bottom:30px!important } .es-m-p30r { padding-right:30px!important } .es-m-p30l { padding-left:30px!important } .es-m-p35 { padding:35px!important } .es-m-p35t { padding-top:35px!important }
 .es-m-p35b { padding-bottom:35px!important } .es-m-p35r { padding-right:35px!important } .es-m-p35l { padding-left:35px!important } .es-m-p40 { padding:40px!important } .es-m-p40t { padding-top:40px!important } .es-m-p40b { padding-bottom:40px!important } .es-m-p40r { padding-right:40px!important } .es-m-p40l { padding-left:40px!important } .es-desk-hidden { display:table-row!important; width:auto!important; overflow:visible!important; max-height:inherit!important } }@media screen and (max-width:384px) {.mail-message-content { width:414px!important } }</style>
 </head>
 <body style="width:100%;font-family:arial, 'helvetica neue', helvetica, sans-serif;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%;padding:0;Margin:0"> <div dir="ltr" class="es-wrapper-color" lang="es" style="background-color:#FAFAFA"> <!--[if gte mso 9]><v:background xmlns:v="urn:schemas-microsoft-com:vml" fill="t"> <v:fill type="tile" color="#fafafa"></v:fill> </v:background><![endif]--> <table class="es-wrapper" width="100%" cellspacing="0" cellpadding="0" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;padding:0;Margin:0;width:100%;height:100%;background-repeat:repeat;background-position:center top;background-color:#FAFAFA"> <tbody> <tr> <td valign="top" style="padding:0;Margin:0"> <table cellpadding="0" cellspacing="0" class="es-header" align="center" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;table-layout:fixed !important;width:100%;background-color:transparent;background-repeat:repeat;background-position:center top"> <tbody> <tr> <td align="center" bgcolor="#edecec" style="padding:0;Margin:0;background-color:#edecec"> <table bgcolor="#ffffff" class="es-header-body" align="center" cellpadding="0" cellspacing="0" data-darkreader-inline-bgcolor style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;background-color:transparent;width:600px" role="none"> <tbody> <tr> <td align="left" style="Margin:0;padding-top:10px;padding-bottom:10px;padding-left:20px;padding-right:20px"> <table cellpadding="0" cellspacing="0" width="100%" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"> <tbody> <tr> <td class="es-m-p0r" valign="top" align="center" style="padding:0;Margin:0;width:560px"> <table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"> <tbody> <tr> <td align="center" style="padding:0;Margin:0;padding-top:10px;padding-bottom:20px;font-size:0px"><img src="https://static.wixstatic.com/media/a3b865_4b8bfc78b79f49d88ea4c24fb9084d98~mv2.png/v1/fill/w_289,h_77,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/logohdazul.png" alt="Logo" style="display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic;font-size:12px" title="Logo" width="204" height="54"></td>
 </tr> </tbody> </table></td> </tr> </tbody> </table></td> </tr> </tbody> </table></td> </tr> </tbody> </table>
 <table cellpadding="0" cellspacing="0" class="es-content" align="center" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;table-layout:fixed !important;width:100%"> <tbody> <tr> <td align="center" bgcolor="#cac9c9" style="padding:0;Margin:0;background-color:#cac9c9"> <table bgcolor="#ffffff" class="es-content-body" align="center" cellpadding="0" cellspacing="0" data-darkreader-inline-bgcolor style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;background-color:#FFFFFF;width:600px" role="none"> <tbody> <tr> <td align="left" style="padding:20px;Margin:0"> <table cellpadding="0" cellspacing="0" width="100%" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"> <tbody> <tr> <td align="center" valign="top" style="padding:0;Margin:0;width:560px"> <table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"> <tbody> <tr> <td align="left" class="es-m-txt-l" style="padding:0;Margin:0;padding-bottom:10px;padding-left:20px;padding-right:20px"><h1 style="Margin:0;line-height:46px;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;font-size:46px;font-style:normal;font-weight:bold;color:#333333">Cotización de reservación</h1>
</td> </tr> <tr> <td align="left" style="padding:0;Margin:0;padding-bottom:10px;padding-left:20px;padding-top:40px"><p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#131313;font-size:14px">Estimad@ ${receiptQuotePresent.nombreHuesped!}</strong></p><p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#131313;font-size:14px">De antemano disculpe la demora de respuesta.<br>Agradecemos su interés en nuestro hotel CORAL BLUE HUATULCO, de acuerdo con su amable solicitud, me complace en presentarle la siguiente cotización:</p>
 <p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#131313;font-size:14px">No. de cotización: <strong>${receiptQuotePresent.folioPrincipal!}</strong></p><p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#131313;font-size:14px"><strong>Plan Todo Incluido</strong><br>Estancia: <strong>${Utility.getPeriodReservation(quotesPresent)}</strong><br>Noches: <strong>${quotesPresent.first.tarifaXDia!.length}</strong></p>
 

 
 <p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#131313;font-size:14px"><b>Habitación Deluxe doble, vista a la reserva 🏞️</b></p>
 
 <p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#131313;font-size:14px"><u>${Utility.getOcupattionMessage(quotesPresent.first)}</u><br><strong>Total por noche \$${(quotesPresent.first.totalVR ?? 1) / (quotesPresent.first.tarifaXDia?.length ?? 1)}&nbsp;&nbsp;<br>Total por estancia \$${quotesPresent.first.totalVR}</strong></p>
 
 <p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#131313;font-size:14px"><b>Habitación Deluxe doble o King size, vista parcial al océano 🌊</b></p>
 
 <p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#131313;font-size:14px"><u>${Utility.getOcupattionMessage(quotesPresent.first)}</u><br><strong>Total por noche \$${(quotesPresent.first.totalVPM ?? 1) / (quotesPresent.first.tarifaXDia?.length ?? 1)}&nbsp;&nbsp;<br>Total por estancia \$${quotesPresent.first.totalVPM}</strong></p>
 


 </td> </tr> <tr> <td align="center" style="padding:0;Margin:0;padding-top:10px;padding-bottom:10px;font-size:0px"><img class="adapt-img" src="https://static.wixstatic.com/media/a3b865_0b4cc1234bfd47848941afac73418b13~mv2.jpg" alt="" style="display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic" width="435" height="302"></td> </tr>
 <tr> <td align="center" style="padding:0;Margin:0;padding-top:10px;padding-bottom:10px"><span class="es-button-border" style="border-style:solid;border-color:#fafafb;background:#2fb08e;border-width:2px;display:inline-block;border-radius:5px;width:auto" data-darkreader-inline-border-top data-darkreader-inline-border-right data-darkreader-inline-border-bottom data-darkreader-inline-border-left data-darkreader-inline-bgimage data-darkreader-inline-bgcolor><a href="https://www.coralbluehuatulco.mx/" class="es-button" target="_blank" style="mso-style-priority:100 !important;text-decoration:none;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;color:#FFFFFF;font-size:20px;padding:10px 30px 10px 30px;display:inline-block;background:#2fb08e;border-radius:5px;font-family:arial, 'helvetica neue', helvetica, sans-serif;font-weight:normal;font-style:normal;line-height:24px;width:auto;text-align:center;mso-padding-alt:0;mso-border-alt:10px solid #2fb08e;padding-left:30px;padding-right:30px" data-darkreader-inline-bgimage data-darkreader-inline-bgcolor>Visitar Sitio Web</a>
 </span></td> </tr> </tbody> </table></td> </tr> </tbody> </table></td> </tr> <tr> <td align="left" style="padding:0;Margin:0;padding-top:20px;padding-left:20px;padding-right:20px"> <table cellpadding="0" cellspacing="0" width="100%" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"> <tbody> <tr> <td align="center" valign="top" style="padding:0;Margin:0;width:560px"> <table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"> <tbody> <tr> <td align="center" class="es-m-txt-c" style="padding:0;Margin:0;padding-bottom:10px"><p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:26px;Margin-bottom:15px;color:#333333;font-size:26px"><b>Consideraciones:</b></p>
</td> </tr> </tbody> </table></td> </tr> </tbody> </table></td> </tr>
 <tr> <td class="esdev-adapt-off" align="left" style="Margin:0;padding-top:10px;padding-bottom:10px;padding-left:20px;padding-right:20px"> <table cellpadding="0" cellspacing="0" class="esdev-mso-table" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;width:560px"> <tbody> <tr> <td class="esdev-mso-td" valign="top" style="padding:0;Margin:0"> <table cellpadding="0" cellspacing="0" class="es-left" align="left" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:left"> <tbody> <tr> <td align="left" style="padding:0;Margin:0;width:30px"> <table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"> <tbody> <tr> <td align="center" style="padding:0;Margin:0;font-size:0px"><img class="adapt-img" src="https://enbrtfn.stripocdn.email/content/guids/cab_pub_7cbbc409ec990f19c78c75bd1e06f215/images/Check_Mark_Blue3.png" alt="" style="display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic" width="25" height="25"></td>
 </tr> </tbody> </table></td> </tr> </tbody> </table></td> <td style="padding:0;Margin:0;width:20px"></td>
 <td class="esdev-mso-td" valign="top" style="padding:0;Margin:0"> <table cellpadding="0" cellspacing="0" class="es-left" align="left" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:left"> <tbody> <tr> <td align="left" style="padding:0;Margin:0;width:220px"> <table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"> <tbody> <tr> <td align="left" style="padding:0;Margin:0"><p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#333333;font-size:14px">*El total de la estancia puede tener variaciones en la tarifa diaria.</p></td> </tr> </tbody> </table></td> </tr> </tbody> </table></td>
 <td style="padding:0;Margin:0;width:20px"></td> <td class="esdev-mso-td" valign="top" style="padding:0;Margin:0"> <table cellpadding="0" cellspacing="0" class="es-left" align="left" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:left"> <tbody> <tr> <td align="left" style="padding:0;Margin:0;width:30px"> <table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"> <tbody> <tr> <td align="center" style="padding:0;Margin:0;font-size:0px"><img class="adapt-img" src="https://enbrtfn.stripocdn.email/content/guids/cab_pub_7cbbc409ec990f19c78c75bd1e06f215/images/Check_Mark_Blue3.png" alt="" style="display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic" width="25" height="25"></td> </tr> </tbody> </table></td> </tr> </tbody> </table></td>
 <td style="padding:0;Margin:0;width:20px"></td> <td class="esdev-mso-td" valign="top" style="padding:0;Margin:0"> <table cellpadding="0" cellspacing="0" class="es-right" align="right" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:right"> <tbody> <tr> <td align="left" style="padding:0;Margin:0;width:220px"> <table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"> <tbody> <tr> <td align="left" style="padding:0;Margin:0"><p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#333333;font-size:14px">*Nuestras habitaciones son máximo para 4 personas sean adultos o menores.<br></p></td> </tr> </tbody> </table></td> </tr>
 </tbody> </table></td> </tr> </tbody> </table></td> </tr>
 <tr> <td class="esdev-adapt-off" align="left" style="Margin:0;padding-top:10px;padding-bottom:10px;padding-left:20px;padding-right:20px"> <table cellpadding="0" cellspacing="0" class="esdev-mso-table" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;width:560px"> <tbody> <tr> <td class="esdev-mso-td" valign="top" style="padding:0;Margin:0"> <table cellpadding="0" cellspacing="0" class="es-left" align="left" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:left"> <tbody> <tr> <td align="left" style="padding:0;Margin:0;width:30px"> <table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"> <tbody> <tr> <td align="center" style="padding:0;Margin:0;font-size:0px"><img class="adapt-img" src="https://enbrtfn.stripocdn.email/content/guids/cab_pub_7cbbc409ec990f19c78c75bd1e06f215/images/Check_Mark_Blue3.png" alt="" style="display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic" width="25" height="25"></td>
 </tr> </tbody> </table></td> </tr> </tbody> </table></td> <td style="padding:0;Margin:0;width:20px"></td> <td class="esdev-mso-td" valign="top" style="padding:0;Margin:0"> <table cellpadding="0" cellspacing="0" class="es-left" align="left" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:left"> <tbody> <tr> <td align="left" style="padding:0;Margin:0;width:220px"> <table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"> <tbody> <tr> <td align="left" style="padding:0;Margin:0"><p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#333333;font-size:14px">*Todas nuestras tarifas ya incluyen impuestos.</p></td> </tr>
 </tbody> </table></td> </tr> </tbody> </table></td> <td style="padding:0;Margin:0;width:20px"></td> <td class="esdev-mso-td" valign="top" style="padding:0;Margin:0"> <table cellpadding="0" cellspacing="0" class="es-left" align="left" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:left"> <tbody> <tr> <td align="left" style="padding:0;Margin:0;width:30px"> <table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"> <tbody> <tr> <td align="center" style="padding:0;Margin:0;font-size:0px"><img class="adapt-img" src="https://enbrtfn.stripocdn.email/content/guids/cab_pub_7cbbc409ec990f19c78c75bd1e06f215/images/Check_Mark_Blue3.png" alt="" style="display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic" width="25" height="25"></td> </tr>
 </tbody> </table></td> </tr> </tbody> </table></td> <td style="padding:0;Margin:0;width:20px"></td> <td class="esdev-mso-td" valign="top" style="padding:0;Margin:0"> <table cellpadding="0" cellspacing="0" class="es-right" align="right" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:right"> <tbody> <tr> <td align="left" style="padding:0;Margin:0;width:220px"> <table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"> <tbody> <tr> <td align="left" style="padding:0;Margin:0"><p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#333333;font-size:14px">*Cotizacion vigente 5 dias.</p></td> </tr> </tbody> </table></td>
 </tr> </tbody> </table></td> </tr> </tbody> </table></td> </tr>
 <tr> <td class="esdev-adapt-off" align="left" style="Margin:0;padding-top:10px;padding-bottom:20px;padding-left:20px;padding-right:20px"> <table cellpadding="0" cellspacing="0" class="esdev-mso-table" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;width:560px"> <tbody> <tr> <td class="esdev-mso-td" valign="top" style="padding:0;Margin:0"> <table cellpadding="0" cellspacing="0" class="es-left" align="left" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:left"> <tbody> <tr> <td align="left" style="padding:0;Margin:0;width:30px"> <table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"> <tbody> <tr> <td align="center" style="padding:0;Margin:0;font-size:0px"><img class="adapt-img" src="https://enbrtfn.stripocdn.email/content/guids/cab_pub_7cbbc409ec990f19c78c75bd1e06f215/images/Check_Mark_Blue3.png" alt="" style="display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic" width="25" height="25"></td>
 </tr> </tbody> </table></td> </tr> </tbody> </table></td> <td style="padding:0;Margin:0;width:20px"></td>
 <td class="esdev-mso-td" valign="top" style="padding:0;Margin:0"> <table cellpadding="0" cellspacing="0" class="es-left" align="left" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:left"> <tbody> <tr> <td align="left" style="padding:0;Margin:0;width:220px"> <table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"> <tbody> <tr> <td align="left" style="padding:0;Margin:0"><p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#333333;font-size:14px">Para poder realizar su reservación le solicitamos el depósito de la primera noche, el resto de su estancia lo paga a su llegada.</p></td> </tr> </tbody> </table></td> </tr>
 </tbody> </table></td> <td style="padding:0;Margin:0;width:20px"></td> <td class="esdev-mso-td" valign="top" style="padding:0;Margin:0"> <table cellpadding="0" cellspacing="0" class="es-left" align="left" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:left"> <tbody> <tr> <td align="left" style="padding:0;Margin:0;width:30px"> <table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"> <tbody> <tr> <td align="center" style="padding:0;Margin:0;font-size:0px"><img class="adapt-img" src="https://enbrtfn.stripocdn.email/content/guids/cab_pub_7cbbc409ec990f19c78c75bd1e06f215/images/Check_Mark_Blue3.png" alt="" style="display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic" width="25" height="25"></td> </tr> </tbody> </table></td> </tr>
 </tbody> </table></td> <td style="padding:0;Margin:0;width:20px"></td>
 <td class="esdev-mso-td" valign="top" style="padding:0;Margin:0"> <table cellpadding="0" cellspacing="0" class="es-right" align="right" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:right"> <tbody> <tr> <td align="left" style="padding:0;Margin:0;width:220px"> <table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"> <tbody> <tr> <td align="left" style="padding:0;Margin:0"><p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#333333;font-size:14px">*Los menores de 0 a 6 años son gratis, menores de 7 a 12 años tienen costo extra por noche, a partir de 13 años ya son considerados como adultos y están incluidos en la cotización final.</p>
</td> </tr> </tbody> </table></td> </tr> </tbody> </table></td> </tr> </tbody> </table></td> </tr>
 <tr> <td class="esdev-adapt-off" align="left" style="Margin:0;padding-top:10px;padding-left:20px;padding-right:20px;padding-bottom:30px"> <table cellpadding="0" cellspacing="0" width="100%" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"> <tbody> <tr> <td align="left" style="padding:0;Margin:0;width:560px"> <table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"> <tbody> <tr> <td style="Margin:0;padding-top:5px;padding-bottom:5px;padding-left:35px;padding-right:35px"><p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#333333;font-size:14px;text-align:justify">Para poder realizar su reservación le solicitamos el depósito de la primera noche, el resto de su estancia lo paga a su llegada.</p>
 <p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#333333;font-size:14px;text-align:justify">Al check in a todo huésped se le requiere dejar en garantía \$1,000 MXN (que puede ser en efectivo o tarjeta de crédito mediante la creación de un voucher abierto) que servirá para cubrir alguna penalidad en caso de perdida o extravio de llaves, toallas o alguna amenidad dentro de la habitación. La garantía de pago será devuelta al huésped al momento de hacer check out (salida de su reservación) y previa revisión al cuarto ocupado sin haber hallado algo roto, dañado, manchado o extraviado.</p>
 <p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#333333;font-size:14px;text-align:justify">Tarifas exclusivas de preventa, sujetas a cambio sin previo aviso.<br>Depósito de garantía no es reembolsable. (Sujeto a cambios de fecha)&nbsp;</p><p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#333333;font-size:14px;text-align:justify"><br><br>Esperamos poder atenderle como usted se merece.</p></td> </tr> </tbody> </table></td> </tr> </tbody> </table></td> </tr> </tbody> </table></td> </tr> </tbody> </table>
 <table cellpadding="0" cellspacing="0" class="es-footer" align="center" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;table-layout:fixed !important;width:100%;background-color:transparent;background-repeat:repeat;background-position:center top"> <tbody> <tr> <td align="center" style="padding:0;Margin:0"> <table class="es-footer-body" align="center" cellpadding="0" cellspacing="0" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;background-color:transparent;width:640px" data-darkreader-inline-bgcolor role="none"> <tbody> <tr> <td align="left" style="Margin:0;padding-top:20px;padding-bottom:20px;padding-left:20px;padding-right:20px"> <table cellpadding="0" cellspacing="0" width="100%" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"> <tbody> <tr> <td align="left" style="padding:0;Margin:0;width:600px"> <table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"> <tbody> <tr> <td align="center" class="es-m-txt-c" style="padding:0;Margin:0;padding-top:15px;padding-bottom:15px;font-size:0"> <table cellpadding="0" cellspacing="0" class="es-table-not-adapt es-social" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"> <tbody> <tr> <td align="center" valign="top" style="padding:0;Margin:0;padding-right:40px"><a target="_blank" href="https://www.facebook.com/HotelCoralBlue/" style="-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;text-decoration:underline;color:#333333;font-size:12px"><img title="Facebook" src="https://enbrtfn.stripocdn.email/content/assets/img/social-icons/logo-black/facebook-logo-black.png" alt="Fb" width="32" height="32" style="display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic"></a>
</td> <td align="center" valign="top" style="padding:0;Margin:0;padding-right:40px"><a target="_blank" href="https://www.instagram.com/coralbluehuatulco/" style="-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;text-decoration:underline;color:#333333;font-size:12px"><img title="Instagram" src="https://enbrtfn.stripocdn.email/content/assets/img/social-icons/logo-black/instagram-logo-black.png" alt="Inst" width="32" height="32" style="display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic"></a></td>
 <td align="center" valign="top" style="padding:0;Margin:0;padding-right:40px"><a target="_blank" href="https://api.whatsapp.com/message/YOPGMHHJHA6RM1?autoload=1&app_absent=0" style="-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;text-decoration:underline;color:#333333;font-size:12px"><img title="Whatsapp" src="https://enbrtfn.stripocdn.email/content/assets/img/messenger-icons/logo-black/whatsapp-logo-black.png" alt="Whatsapp" width="32" height="32" style="display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic"></a></td>
 <td align="center" valign="top" style="padding:0;Margin:0;padding-right:40px"><a target="_blank" href="tel:9585252061" style="-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;text-decoration:underline;color:#333333;font-size:12px"><img title="Phone" src="https://enbrtfn.stripocdn.email/content/assets/img/other-icons/logo-black/phone-logo-black.png" alt="Phone" width="32" height="32" style="display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic"></a></td>
 <td align="center" valign="top" style="padding:0;Margin:0;padding-right:40px"><a target="_blank" href="mailto:reservas@coralbluehuatulco.mx?subject=Hola%20vengo%20de%20la%20pagina%20web,%20me%20apoyas%20con%20una%20reservaci%C3%B3n%20por%20favor." style="-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;text-decoration:underline;color:#333333;font-size:12px"><img title="Email" src="https://enbrtfn.stripocdn.email/content/assets/img/other-icons/logo-black/mail-logo-black.png" alt="Email" width="32" height="32" style="display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic"></a></td>
 <td align="center" valign="top" style="padding:0;Margin:0"><a target="_blank" href="https://www.pinterest.com.mx/reservascoralblue/" style="-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;text-decoration:underline;color:#333333;font-size:12px"><img title="Pinterest" src="https://enbrtfn.stripocdn.email/content/assets/img/social-icons/logo-black/pinterest-logo-black.png" alt="P" width="32" height="32" style="display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic"></a></td> </tr> </tbody> </table></td> </tr> <tr> <td align="center" style="padding:0;Margin:0;padding-bottom:5px"><p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:18px;Margin-bottom:15px;color:#333333;font-size:12px">Coral Blue Hotels &amp; Resorts © 2024</p>
 <p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:18px;Margin-bottom:15px;color:#333333;font-size:12px">Manzana 8 lote 3,&nbsp;Bahía Arrocito, CP 70988 Bahias de Huatulco, Oax</p></td> </tr>
 <tr> <td style="padding:0;Margin:0"> <table cellpadding="0" cellspacing="0" width="100%" class="es-menu" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"> <tbody> <tr class="links"> <td align="center" valign="top" width="50%" style="Margin:0;padding-left:5px;padding-right:5px;padding-top:5px;padding-bottom:5px;border:0"><a target="_blank" href="https://www.coralbluehuatulco.mx" style="-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;text-decoration:none;display:block;font-family:arial, 'helvetica neue', helvetica, sans-serif;color:#999999;font-size:12px" data-darkreader-inline-color>Visitanos</a></td>
 <td align="center" valign="top" width="50%" style="Margin:0;padding-left:5px;padding-right:5px;padding-top:5px;padding-bottom:5px;border:0;border-left:1px solid #cccccc" data-darkreader-inline-border-left><a target="_blank" href="https://www.coralbluehuatulco.mx/about" style="-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;text-decoration:none;display:block;font-family:arial, 'helvetica neue', helvetica, sans-serif;color:#999999;font-size:12px" data-darkreader-inline-color>Políticas de privacidad</a></td> </tr> </tbody> </table></td> </tr> </tbody> </table></td> </tr> </tbody> </table></td> </tr> </tbody> </table></td> </tr> </tbody> </table></td> </tr> </tbody> </table> </div> </body> </html>
      ''';

    return emailHtmlPart1;
  }
}
