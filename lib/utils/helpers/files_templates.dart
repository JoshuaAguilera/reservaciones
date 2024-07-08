import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/models/cotizacion_model.dart';
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
                ? 119
                : 177),
        child: pw.TableHelper.fromTextArray(
            border: pw.TableBorder.all(width: 0.9),
            headerStyle: styleHeader,
            columnWidths: {
              0: const pw.FixedColumnWidth(100),
              1: const pw.FixedColumnWidth(100),
              if (cotizaciones.any((element) => element.esPreVenta!))
                2: const pw.FixedColumnWidth(160)
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
    int days = Utility.getDifferenceInDays(cotizaciones: [cotizacion]);

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

  static String getHtmlCotizacion() {
    String HTML = "";
    HTML +=
        "<html><head><meta charset=\"utf-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">";
    HTML +=
        "<title>COTIZACIÓN DE RESERVA</title><title>FAVOR DE NO RESPONDER ESTE CORREO</title>";
    HTML +=
        "<link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css\" rel=\"stylesheet\" integrity=\"sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3\" crossorigin=\"anonymous\">";
    HTML += "</head>";
    HTML +=
        "<body><div id=\"divPapeleta\" class=\"container\"><div id=\"header\"><div id=\"div_logo\">";
    HTML += "<img src=\"cid:Logo.png\">";
    HTML +=
        "<div id=\"pleca_logo\" style=\"border-left: 1px solid #545454; height:100px;display:inline-block; margin:15px;display:none\"></div>";
    HTML +=
        "<img id=\"imgLogoProducto\" class=\"imglogodv\" style=\"width:150px; height:85px;margin-left:20px;margin-bottom:15px;display:none\"></div>";
    HTML += "<div id=\"div_header_info\">";
    HTML +=
        "<span id=\"lblTitleConfirmacion\" style=\"text-align:right;\">Confirmaci&oacute;n de <strong>Reservaci&oacute;n</strong>:</span><br>";
    HTML +=
        "<span id=\"lblTitleNum\">No. </span><span id=\"spnNumeroRes\" style=\"text-align:right;\">(*NUMRES*)</span><br>";
    HTML +=
        "<span id=\"divNewText\">Favor de imprimir este documento para presentar en su Check-in</span>";
    HTML += "</div>";
    HTML += "</div>";
    HTML += "<table class=\"table table-striped\">";
    HTML += "<tbody>";
    HTML += "<tr>";
    HTML +=
        "<th colspan=\"6\" scope=\"col\">INFORMACI&oacute;N DE HUESPEDES</th>";
    HTML += "</tr>";
    HTML +=
        "<tr style=\"vertical-align:top;line-height:11px; margin-top:10px;padding:10px;\">";
    HTML += "<td>";
    HTML += "<div id=\"dv_img_huesped\">";
    HTML += "<img id=\"img_huesped\" src=\"./person.png\">";
    HTML += "</div>";
    HTML += "</td>";
    HTML += "<td>";
    HTML += "<div class=\"info_huesped_group\">";
    HTML +=
        "<span id=\"lblTitleNombreHuespedes\" class=\"title\">Nombre de los hu&eacute;spedes:</span>";
    HTML +=
        "<span id=\"lblNombreHuespedes\" class=\"info\">(*NOMHUE*)<br></span>";
    HTML += "</div>";
    HTML += "</td>";
    HTML += "<td>";
    HTML += "<div class=\"info_huesped_group\">";
    HTML += "<span id=\"lblTitleEmail2\" class=\"title\">Cuartos:</span>";
    HTML +=
        "<a id=\"cuartos\" href=\"\" style=\"text-decoration:none;color:inherit;cursor:pointer\"><span class=\"info\">(*CTOS*)</span></a>";
    HTML += "</div>";
    HTML += "</td>";
    HTML += "</tr>";
    HTML += "<tr>";
    HTML +=
        "<th colspan=\"6\" scope=\"col\">INFORMACI&oacute;N DE RESERVA</th>";
    HTML += "</tr>";
    HTML += "<tr>";
    HTML += "<td>";
    HTML += "<div id=\"dv_img_airplane\">";
    HTML += "<img id=\"img_airplane\" src=\"./business-outline.png\">";
    HTML += "</div>";
    HTML += "</td>";
    HTML += "<td>";
    HTML += "<div class=\"info_rsva_group\">";
    HTML +=
        "<span id=\"lblTitleDestino\" class=\"title\">Su Destino/Resort:</span>";
    HTML += "<span class=\"info\">";
    HTML +=
        "<a href=\"javascript:void(0);\" id=\"lblDestino\" style=\"text-decoration:underline;color:inherit;cursor:pointer\">Hotel H & Resorts / Queen Beach Club</a>";
    HTML += "</span>";
    HTML += "</div>";
    HTML += "</td>";
    HTML += "<td>";
    HTML += "<div class=\"info_rsva_group\">";
    HTML += "<span id=\"lblTitleCheckIn\" class=\"title\">Check-In:</span>";
    HTML += "<span id=\"lblCheckIn\" class=\"info\">marzo 09, 2018</span>";
    HTML += "</div>";
    HTML += "</td>";
    HTML += "<td>";
    HTML += "<div class=\"info_rsva_group\">";
    HTML += "<span id=\"lblTitleCheckOut\" class=\"title\">Check-Out:</span>";
    HTML += "<span id=\"lblCheckOut\" class=\"info\">marzo 12, 2018</span>";
    HTML += "</div>";
    HTML += "</td>";
    HTML += "<td>";
    HTML += "<div class=\"info_rsva_group\">";
    HTML +=
        "<span id=\"lblTitleTipoHabitacion\" class=\"title\">Tipo de Habitaci&oacute;n:</span>";
    HTML += "<span id=\"divTipoHabitacion\" class=\"info\">JRS-JRS-S</span>";
    HTML += "</div>";
    HTML += "</td>";
    HTML += "<td>";
    HTML += "<div class=\"info_rsva_group\">";
    HTML +=
        "<span id=\"lblTitleCapacidad\" class=\"title\">Capacidad M&aacute;xima:</span>";
    HTML +=
        "<span id=\"divCapacidad\" class=\"info\">4 Adultos, 0 Niños </span>";
    HTML += "</div>";
    HTML += "</td>";
    HTML += "</tr>";
    HTML += "</tbody></table>";
    HTML += "<table class=\"table table-striped\">";
    HTML += "<tbody>";
    HTML += "<tr>";
    HTML +=
        "<th colspan=\"7\" scope=\"col\">INFORMACI&oacute;N DE LA TRANSACCI&oacute;N</th>";
    HTML += "</tr>";
    HTML += "<tr>";
    HTML += "<th scope=\"col\">Tipo de Habitaci&oacute;n:</th>";
    HTML += "<th scope=\"col\">Descripci&oacute;n:</th>";
    HTML += "<th scope=\"col\">No. de Noches:</th>";
    HTML += "<th scope=\"col\">Cr&eacute;ditos:</th>";
    HTML += "<th scope=\"col\">No. Adultos:</th>";
    HTML += "<th scope=\"col\">No. Menores:</th>";
    HTML += "<th scope=\"col\">Infantes:</th>";
    HTML += "</tr>";
    HTML +=
        "<tr><td class=\"first\">JRS-JRS-S</td><td>Junior Suite-Junior Suite-Saturday</td><td>3</td><td>0</td><td>2</td><td>0</td><td>0</td></tr>";
    HTML += "</tbody></table>";
    HTML += "<div id=\"notes-group\">";
    HTML += "<div id=\"trWaitList\" style=\"display:none\">";
    HTML +=
        "<span class=\"boldtxt\"><label id=\"lblWaitList\">lblWaitList</label></span>";
    HTML += "</div>";
    HTML += "<div id=\"div_notas\">";
    HTML += "<div id=\"trPrepagoNota\" class=\"\" style=\"display: none;\">";
    HTML +=
        "<label id=\"lblPrepagoNota\" style=\"background-color:Blue; color:#FFFFFF; font-weight:bold; font-size:14px;\"></label>";
    HTML += "</div>";
    HTML += "<p class=\"confirm-note\" id=\"pNota\">";
    HTML += "<span><label id=\"lblTitleNota\">Nota:</label></span>";
    HTML +=
        "<label id=\"lblNota\">Estancia cubre: 2 adultos 0 menores, 3 noches de la estancia, Total: 360.00 USD<br>En esta reserva se aplican cambio de tarifas por temporada.<br><b>Additional Info</b> (06/03/2018) VIAJAN 2 ADULTOS 60 USD POR NOCHE<br></label>";
    HTML += "</p>";
    HTML += "<label id=\"lblNotaOutlet\"></label>";
    HTML += "<label id=\"lblNotaRewards\"></label>";
    HTML += "</div>";
    HTML += "</div>";
    HTML += "<div id=\"div_contact\">";
    HTML += "<div id=\"dv_img_contact\">";
    HTML +=
        "<img style=\"width: 8%;\" id=\"contact_img\" src=\"cid:HotelH.jpg\">";
    HTML += "</div>";
    HTML += "<div id=\"dv_contacs\">";
    HTML += "<div class=\"contact-group\">";
    HTML +=
        "<label id=\"lblTitleAntesViaje\">Para atenci&oacute;n al cliente:</label><span></span>";
    HTML +=
        "<b><label id=\"lblTitleTelAntes\">958.583.40.25 958.583.40.22 958.583.40.30</label></b><span>&nbsp;|&nbsp;</span>";
    HTML += "<b><label id=\"lblTitleAntesViaje\">| WhatsApp: </label></b>";
    HTML += "<b><label> 9581868764 |</label></b>";
    HTML +=
        "<b><a id=\"ancla-correo-antes\" href=\"mailTo: reservas@hotelhhuatulco.com&nbsp;\" style=\"text-decoration:none;color:inherit;cursor:pointer\"><label id=\"lblTitleEmailAntes\" style=\"cursor:pointer\">reservas@hotelhhuatulco.com&nbsp;</label></a></b>";
    HTML += "</div>";
    HTML += "</div>";
    HTML += "</div>";
    HTML += "<div id=\"special-conditions\">";
    HTML +=
        "<span id=\"consideraciones\">Consideraciones Especiales para la seguridad de todos los hu&eacute;spedes y personal del hotel:</span>";
    HTML +=
        "<p id=\"derecho_admision\">El hotel se reserva el derecho de admisi&oacute;n a toda persona que sea sospechosa de padecer alg&uacute;n s&iacute;ntoma relacionado con el virus SARS-CoV-2 (Covid-19) as&iacute; como derivar a un sistema de salud local a cualquier hu&eacute;sped que presente durante su estancia s&iacute;ntomas causados por la presencia del padecimiento.<br> Al reservar, todos los hu&eacute;spedes est&aacute;n obligados a cumplir sin excepci&oacute;n el reglamento interno y las nuevas disposiciones sanitarias del hotel en el que se alojan. El hu&eacute;sped queda sujeto a las sanciones del hotel y del pa&iacute;s que visitan en caso de incumplimiento.</p>";
    HTML += "</div>";
    HTML += "<center>";
    HTML += "<div id=\"contenido_media\"></div>";
    HTML += "</center>";
    HTML += "<div>";
    HTML +=
        "<table id=\"tblImportante\" style=\"width:100%; text-align:justify; vertical-align:text-top;\">";
    HTML += "<tbody><tr id=\"trImportante\" style=\"display: none;\">";
    HTML += "<td>";
    HTML +=
        "<h4 class=\"notetitle\" style=\"color:red;\"><label id=\"lblTitleImportante\"></label></h4>";
    HTML +=
        "<table class=\"Importante\" id=\"tblInfoImportante\" style=\"width:100%; text-align:justify; vertical-align:text-top;\">";
    HTML += "<tbody><tr>";
    HTML +=
        "<td id=\"tdImportanteUno\" style=\"width:45%; text-align:justify; vertical-align:top;\"></td>";
    HTML += "</tr>";
    HTML += "<tr>";
    HTML +=
        "<td id=\"tdImportanteDos\" style=\"width:45%; text-align:justify; vertical-align:top;\"></td>";
    HTML += "</tr>";
    HTML += "</tbody></table>";
    HTML += "</td>";
    HTML += "</tr>";
    HTML += "</tbody></table>";
    HTML += "</div>";
    HTML += "<div id=\"avisos_y_condiciones\">";
    HTML +=
        "<table class=\"section-restriction\" style=\"background-color:transparent;\">";
    HTML += "<tbody><tr id=\"trInfoImportante\" style=\"display: block;\">";
    HTML += "<td>";
    HTML +=
        "<h4 class=\"notetitleInfoImportante\"><label id=\"lblTitleInfoImportante\">Informaci&oacute;n Importante del Resort:</label></h4>";
    HTML +=
        "<!--<div class=\"InfoImportante\" id=\"divInfoImportante\" style=\"width:100%; text-align:justify; font-size:11px; vertical-align:text-top;\">";
    HTML += "</div>-->";
    HTML +=
        "<table class=\"InfoImportante\" id=\"tblInfoImportante\" style=\"width:100%; text-align:justify; vertical-align:text-top; background-color:transparent;\">";
    HTML += "<tbody><tr>";
    HTML +=
        "<td id=\"tdInfoImportanteUno\" style=\"width:45%; text-align:justify; vertical-align:top;\">";
    HTML += "<ul>";
    HTML +=
        "<li>La hora entrada es a partir de las 15:00 horas, para la salida y desalojar las habitaciones se fija a las 12:00 horas de cada d&iacute;a. Si alg&uacute;n hu&eacute;sped permanece m&aacute;s tiempo se le cargar&aacute; \$100 por cada hora, sin tolerancia.</li>";
    HTML +=
        "<li>Est&aacute; prohibido usar la habitaci&oacute;n para ejecutar cualquier acto ilicito o fuera de la ley y sera remitido a las autoridades en su caso.</li>";
    HTML +=
        "<li>Ninguna persona tiene derecho a dar alojamiento a otra sin el consentimiento previo de la gerencia y hacer arreglos para su registro o cuota.</li>";
    HTML +=
        "<li>Unicamente el personal del hotel podra prestar servicio a los hu&eacute;spedes, en caso de tener personal particular a su servicio, ser&aacute;n considerados como hu&eacute;spedes a cargo de la habitaci&oacute;n del titular, quien se responsabiliza de la conducta de los mismos.</li>";
    HTML +=
        "<li>Esta prohibido a los usuarios realizar, durante su estancia, actos que falten a la moral, buenas costumbres o tranquilidad del resto de los hu&eacute;spedes.</li>";
    HTML +=
        "<li>El hu&eacute;sped deber&aacute; comportarse con decencia y moralidad dentro del establecimiento, qued&aacute;ndose prohibido alterar el orden, hacer ruidos que incomoden o molesten a los dem&aacute;s hu&eacute;spedes, el establecimiento podr&aacute; cancelar los servicios de hospedaje en estos supuestos.</li>";
    HTML +=
        "<li>El hotel se reserva el derecho de admisi&oacute;n de visitas acompañantes ocasionales a las instalaciones del hotel, en ning&uacute;n caso se permitir&aacute; el acceso de las mismas a las habitaciones. es una medida de seguridad tanto para el cliente como para el hotel.</li>";
    HTML +=
        "<li>El establecimiento proh&iacute;be estrictamente el uso de velas, inciensos, material peligroso o inflamable; as&iacute; como el uso de chocolates sin envolturas en nuestros blancos. hacer caso omiso de esta norma generar&aacute; una multa por la misma cantidad del costo de su habitaci&oacute;n.</li>";
    HTML +=
        "<li>El hotel no se har&aacute; responsable por dinero o valores olvidados en la habitaci&oacute;n o &aacute;reas p&uacute;blicas. Por lo que le recordamos que dentro del closet se encuentra la caja fuerte, apoyada de un instructivo para su uso o en su caso puede resguardar sus art&iacute;culos de valor, en la caja de seguridad de la administraci&oacute;n. Dirigi&eacute;ndose directamente a recepci&oacute;n.</li>";
    HTML +=
        "<li>Las s&aacute;banas, frazadas, cubre colchones, sobrecamas, toallas y alfombras de felpa que est&eacute;n sucias, rotas o manchadas (sangre o cualquier otro l&iacute;quido, o sustancia) el hu&eacute;sped es quien paga por el daño ocasionado. generando un gasto extra de \$1000.00 como m&iacute;nimo o el monto total de la prenda. pagos de este tipo se realizan inmediatamente y en efectivo.</li>";
    HTML +=
        "<li>El hotel tiene prohibido a sus clientes fumar en las habitaciones de acuerdo a la ley nacional anti-tabaco, el hecho causa deterioro de las mismas y se cobrara un 30% del total de la tarifa como costo de limpieza adicional en cada incidencia. Las habitaciones son libres de humo: &uacute;nicamente se podr&aacute; fumar en &aacute;reas de terraza. en caso de dejar impregnada la habitaci&oacute;n con olor a cigarro, se generar&aacute; un cargo por la cantidad de \$5,000.00 Para limpieza y purificaci&oacute;n de la habitaci&oacute;n. De acuerdo con la Ley Anti Tabaco, queda prohibido fumar en &aacute;rea cerradas, por lo que el Hotel les brinda un espacio abierto.</li>";
    HTML +=
        "<li>Esta prohibido introducir alimentos y bebidas externas en &aacute;reas p&uacute;blicas del hotel. Solo se admite el consumo dentro de su habitaci&oacute;n o en la zona de la palapa del Lobby.</li>";
    HTML +=
        "<li>Est&aacute; prohibido introducir alimentos o bebidas de cualquier tipo a las instalaciones del Hotel y/o Restaurante, alberca y playa, en caso de hacerlo el hu&eacute;sped tendra un cobro extra de acuerdo con el n&uacute;mero o cantidad de alimentos o bebidas introducidas.</li>";
    HTML +=
        "<li>El hotel se reserva el derecho de suspender el servicio de bebidas cuando el hu&eacute;sped est&eacute; en evidente estado de ebriedad. Lo anterior por seguridad de los hu&eacute;spedes y clientes del centro de consumo.</li>";
    HTML += "</ul>";
    HTML += "</td>";
    HTML += "<td style=\"width:2%\"></td>";
    HTML +=
        "<td id=\"tdInfoImportanteDos\" style=\"width:45%; text-align:justify; vertical-align:top;\">";
    HTML +=
        "<li>Las reservaciones se garantizan &uacute;nica y exclusivamente hasta al momento de proporcionar datos v&aacute;lidos de una Tarjeta de Cr&eacute;dito. Operadora Queen Beach S.A. de C.V. realizar&aacute; un cargo a su Tarjeta de Cr&eacute;dito por el valor TOTAL DE LA RESERVACION de la(s) habitaci&oacute;n(es) 15 d&iacute;as antes de su fecha de llegada; en caso de no contar con fondos suficientes o los datos de la tarjeta sean incorrectos la reservaci&oacute;n ser&aacute; cancelada.</li>";
    HTML +=
        "<li>Operadora Queen Beach S.A. de C.V. realizar&aacute; un cargo a su Tarjeta de Cr&eacute;dito por el valor total de la reservaci&oacute;n 15 d&iacute;as antes de su fecha de llegada; en caso de no contar con fondos suficientes o los datos de la tarjeta sean incorrectos la reservaci&oacute;n ser&aacute; cancelada sin responsabilidad para brindar hospedaje por parte del Hotel.</li>";
    HTML +=
        "<li>La penalizaci&oacute;n en caso de no-show, no llegada del hu&eacute;sped, ser&aacute; la no devoluci&oacute;n del valor total de la reservaci&oacute;n; y ser&aacute; cargada a la tarjeta de cr&eacute;dito del hu&eacute;sped o si se hizo UN dep&oacute;sito bancario no habr&aacute; devoluci&oacute;n. La &uacute;nica cuenta registrada por la empresa para recibir dep&oacute;sitos de hospedaje, alimentos y bebidas es BANORTE CUENTA: 1165714337 CLABE: 072 180 011 6571 43370. La empresa no se hace responsable por dep&oacute;sitos bancarios que no hayan sido a esta cuenta.</li>";
    HTML += "</td>";
    HTML += "</tr>";
    HTML += "</tbody></table>";
    HTML += "</td>";
    HTML += "</tr>";
    HTML += "</tbody></table>";
    HTML += "</div>";
    HTML +=
        "<div id=\"tblAvisoPrivacidad\" style=\"display: block;text-align: center;\">";
    HTML +=
        "<li>Las devoluciones al 100% se podr&aacute;n hacer 15 d&iacute;as antes de la fecha de llegada.</li>";
    HTML +=
        "GRACIAS POR ELEGIR EL HOTEL H PARA SU ESTANCIA EN BAHIAS DE HUATULCO.";
    HTML +=
        "SERA UN PLACER ATENDERLE, LE DESEAMOS FELIZ VIAJE, LO ESPERAMOS EN BAHIAS DE HUATULCO";
    HTML +=
        "<br><img style=\"width: 8%;\" src=\"./HotelH.jpg\" alt=\"\"></div>";
    HTML += "</div>";
    HTML += "</body>";
    HTML += "<style type=\"text/css\">";
    HTML += "html {";
    HTML += "    margin: 15px;";
    HTML += "    font-family: cursive;";
    HTML += "}";
    HTML += "th {";
    HTML += "    TEXT-ALIGN-LAST: CENTER;";
    HTML += "}";
    HTML += "</style>";
    HTML += "</html>";

    return HTML;
  }

  static String getHTML() {
    const String emailHtmlPart1 = '''
        <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html dir="ltr" xmlns="http://www.w3.org/1999/xhtml" xmlns:o="urn:schemas-microsoft-com:office:office" lang="es"><head><meta charset="UTF-8"><meta content="width=device-width, initial-scale=1" name="viewport"><meta name="x-apple-disable-message-reformatting"><meta http-equiv="X-UA-Compatible" content="IE=edge"><meta content="telephone=no" name="format-detection"><title>New Message</title> <!--[if (mso 16)]><style type="text/css">     a {text-decoration: none;}     </style><![endif]--> <!--[if gte mso 9]><style>sup { font-size: 100% !important; }</style><![endif]--> <!--[if gte mso 9]><xml> <o:OfficeDocumentSettings> <o:AllowPNG></o:AllowPNG> <o:PixelsPerInch>96</o:PixelsPerInch> </o:OfficeDocumentSettings> </xml>
<![endif]--><style type="text/css">#outlook a { padding:0;}.es-button { mso-style-priority:100!important; text-decoration:none!important;}a[x-apple-data-detectors] { color:inherit!important; text-decoration:none!important; font-size:inherit!important; font-family:inherit!important; font-weight:inherit!important; line-height:inherit!important;}.es-desk-hidden { display:none; float:left; overflow:hidden; width:0; max-height:0; line-height:0; mso-hide:all;}@media only screen and (max-width:600px) {p, ul li, ol li, a { line-height:150%!important } h1, h2, h3, h1 a, h2 a, h3 a { line-height:120% } h1 { font-size:36px!important; text-align:left } h2 { font-size:26px!important; text-align:left } h3 { font-size:20px!important; text-align:left } .es-header-body h1 a, .es-content-body h1 a, .es-footer-body h1 a { font-size:36px!important; text-align:left }
 .es-header-body h2 a, .es-content-body h2 a, .es-footer-body h2 a { font-size:26px!important; text-align:left } .es-header-body h3 a, .es-content-body h3 a, .es-footer-body h3 a { font-size:20px!important; text-align:left } .es-menu td a { font-size:12px!important } .es-header-body p, .es-header-body ul li, .es-header-body ol li, .es-header-body a { font-size:14px!important } .es-content-body p, .es-content-body ul li, .es-content-body ol li, .es-content-body a { font-size:16px!important } .es-footer-body p, .es-footer-body ul li, .es-footer-body ol li, .es-footer-body a { font-size:14px!important } .es-infoblock p, .es-infoblock ul li, .es-infoblock ol li, .es-infoblock a { font-size:12px!important } *[class="gmail-fix"] { display:none!important } .es-m-txt-c, .es-m-txt-c h1, .es-m-txt-c h2, .es-m-txt-c h3 { text-align:center!important } .es-m-txt-r, .es-m-txt-r h1, .es-m-txt-r h2, .es-m-txt-r h3 { text-align:right!important }
 .es-m-txt-l, .es-m-txt-l h1, .es-m-txt-l h2, .es-m-txt-l h3 { text-align:left!important } .es-m-txt-r img, .es-m-txt-c img, .es-m-txt-l img { display:inline!important } .es-button-border { display:inline-block!important } a.es-button, button.es-button { font-size:20px!important; display:inline-block!important } .es-adaptive table, .es-left, .es-right { width:100%!important } .es-content table, .es-header table, .es-footer table, .es-content, .es-footer, .es-header { width:100%!important; max-width:600px!important } .es-adapt-td { display:block!important; width:100%!important } .adapt-img { width:100%!important; height:auto!important } .es-m-p0 { padding:0!important } .es-m-p0r { padding-right:0!important } .es-m-p0l { padding-left:0!important } .es-m-p0t { padding-top:0!important } .es-m-p0b { padding-bottom:0!important } .es-m-p20b { padding-bottom:20px!important } .es-mobile-hidden, .es-hidden { display:none!important }
 tr.es-desk-hidden, td.es-desk-hidden, table.es-desk-hidden { width:auto!important; overflow:visible!important; float:none!important; max-height:inherit!important; line-height:inherit!important } tr.es-desk-hidden { display:table-row!important } table.es-desk-hidden { display:table!important } td.es-desk-menu-hidden { display:table-cell!important } .es-menu td { width:1%!important } table.es-table-not-adapt, .esd-block-html table { width:auto!important } table.es-social { display:inline-block!important } table.es-social td { display:inline-block!important } .es-m-p5 { padding:5px!important } .es-m-p5t { padding-top:5px!important } .es-m-p5b { padding-bottom:5px!important } .es-m-p5r { padding-right:5px!important } .es-m-p5l { padding-left:5px!important } .es-m-p10 { padding:10px!important } .es-m-p10t { padding-top:10px!important } .es-m-p10b { padding-bottom:10px!important } .es-m-p10r { padding-right:10px!important }
 .es-m-p10l { padding-left:10px!important } .es-m-p15 { padding:15px!important } .es-m-p15t { padding-top:15px!important } .es-m-p15b { padding-bottom:15px!important } .es-m-p15r { padding-right:15px!important } .es-m-p15l { padding-left:15px!important } .es-m-p20 { padding:20px!important } .es-m-p20t { padding-top:20px!important } .es-m-p20r { padding-right:20px!important } .es-m-p20l { padding-left:20px!important } .es-m-p25 { padding:25px!important } .es-m-p25t { padding-top:25px!important } .es-m-p25b { padding-bottom:25px!important } .es-m-p25r { padding-right:25px!important } .es-m-p25l { padding-left:25px!important } .es-m-p30 { padding:30px!important } .es-m-p30t { padding-top:30px!important } .es-m-p30b { padding-bottom:30px!important } .es-m-p30r { padding-right:30px!important } .es-m-p30l { padding-left:30px!important } .es-m-p35 { padding:35px!important } .es-m-p35t { padding-top:35px!important }
 .es-m-p35b { padding-bottom:35px!important } .es-m-p35r { padding-right:35px!important } .es-m-p35l { padding-left:35px!important } .es-m-p40 { padding:40px!important } .es-m-p40t { padding-top:40px!important } .es-m-p40b { padding-bottom:40px!important } .es-m-p40r { padding-right:40px!important } .es-m-p40l { padding-left:40px!important } .es-desk-hidden { display:table-row!important; width:auto!important; overflow:visible!important; max-height:inherit!important } }@media screen and (max-width:384px) {.mail-message-content { width:414px!important } }</style>
 </head> <body style="width:100%;font-family:arial, 'helvetica neue', helvetica, sans-serif;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%;padding:0;Margin:0"><div dir="ltr" class="es-wrapper-color" lang="es" style="background-color:#FAFAFA"> <!--[if gte mso 9]><v:background xmlns:v="urn:schemas-microsoft-com:vml" fill="t"> <v:fill type="tile" color="#fafafa"></v:fill> </v:background><![endif]--><table class="es-wrapper" width="100%" cellspacing="0" cellpadding="0" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;padding:0;Margin:0;width:100%;height:100%;background-repeat:repeat;background-position:center top;background-color:#FAFAFA"><tr>
<td valign="top" style="padding:0;Margin:0"><table cellpadding="0" cellspacing="0" class="es-content" align="center" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;table-layout:fixed !important;width:100%"><tr><td class="es-info-area" align="center" style="padding:0;Margin:0"><table class="es-content-body" align="center" cellpadding="0" cellspacing="0" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;background-color:transparent;width:600px" bgcolor="#FFFFFF" role="none"><tr><td align="left" style="padding:20px;Margin:0"><table cellpadding="0" cellspacing="0" width="100%" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"><tr>
<td align="center" valign="top" style="padding:0;Margin:0;width:560px"><table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"><tr><td align="center" class="es-infoblock" style="padding:0;Margin:0;line-height:14px;font-size:12px;color:#CCCCCC"><p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:14px;Margin-bottom:15px;color:#CCCCCC;font-size:12px"><a target="_blank" href="" style="-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;text-decoration:underline;color:#CCCCCC;font-size:12px">View online version</a></p> </td></tr></table></td></tr></table></td></tr></table></td></tr></table>
 <table cellpadding="0" cellspacing="0" class="es-header" align="center" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;table-layout:fixed !important;width:100%;background-color:transparent;background-repeat:repeat;background-position:center top"><tr><td align="center" style="padding:0;Margin:0"><table bgcolor="#ffffff" class="es-header-body" align="center" cellpadding="0" cellspacing="0" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;background-color:transparent;width:600px"><tr><td align="left" style="Margin:0;padding-top:10px;padding-bottom:10px;padding-left:20px;padding-right:20px"><table cellpadding="0" cellspacing="0" width="100%" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"><tr>
<td class="es-m-p0r" valign="top" align="center" style="padding:0;Margin:0;width:560px"><table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"><tr><td align="center" style="padding:0;Margin:0;padding-bottom:20px;font-size:0px"><img src="https://static.wixstatic.com/media/a3b865_4b8bfc78b79f49d88ea4c24fb9084d98~mv2.png/v1/fill/w_289,h_77,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/logohdazul.png" alt="Logo" style="display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic;font-size:12px" width="200" title="Logo" height="53"></td> </tr></table></td></tr></table></td></tr></table></td></tr></table>
 <table cellpadding="0" cellspacing="0" class="es-content" align="center" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;table-layout:fixed !important;width:100%"><tr><td align="center" style="padding:0;Margin:0"><table bgcolor="#ffffff" class="es-content-body" align="center" cellpadding="0" cellspacing="0" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;background-color:#FFFFFF;width:600px"><tr><td align="left" style="Margin:0;padding-bottom:20px;padding-left:20px;padding-right:20px;padding-top:30px"><table cellpadding="0" cellspacing="0" width="100%" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"><tr>
<td align="center" valign="top" style="padding:0;Margin:0;width:560px"><table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"><tr><td align="left" class="es-m-txt-l" style="padding:0;Margin:0;padding-bottom:10px"><h1 style="Margin:0;line-height:46px;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;font-size:46px;font-style:normal;font-weight:bold;color:#333333">Cotización de reservación</h1> </td></tr><tr><td align="left" style="padding:0;Margin:0;padding-top:5px;padding-bottom:5px"><p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#333333;font-size:14px">Estamado *|FNAME|*!</p>
<p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#333333;font-size:14px">Sera un placer recibirles en Coral Blue Hotels &amp; Resorts ubicado en Bahí­as de Huatulco.<br>Por medio de la presente, tenemos el agrado de presentar la cotización de su reserva acorde a los siguientes datos:&nbsp;</p>
 <p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#333333;font-size:14px">No. de cotización: <b>10633</b><br>Día de llegada: <b>06/07/2024&nbsp;</b><br>Día de salida: <b>10/07/2024&nbsp;</b><br>Cantidad de noches: <b>4&nbsp;</b><br>Alojamiento: <b>1 (DBLVV) 2 CAMAS MATRI VISTA VERDE&nbsp;</b><br>Cantidad de personas: <b>2 Adultos / 1 Niños.</b><br>Plan: <b>(PLANTDI) TODO INCLUIDO</b>&nbsp;</p></td></tr> <tr>
<td align="left" style="padding:0;Margin:0;padding-top:5px;padding-bottom:5px"><p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#333333;font-size:14px">Para poder realizar su reservación le solicitamos el depósito de la primera noche, el resto de su estancia lo paga a su llegada.</p>
 <p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#333333;font-size:14px">Al check in a todo huésped se le requiere dejar en garantía \$1,000 MXN (que puede ser en efectivo o tarjeta de crédito mediante la creación de un voucher abierto) que servirá para cubrir alguna penalidad en caso de perdida o extravio de llaves, toallas o alguna amenidad dentro de la habitación. La garantía de pago será devuelta al huésped al momento de hacer check out (salida de su reservación) y previa revisión al cuarto ocupado sin haber hallado algo roto, dañado, manchado o extraviado.</p>
 <p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#333333;font-size:14px">Tarifas exclusivas de preventa, sujetas a cambio sin previo aviso.&nbsp;<br>&nbsp;Depósito de garantía no es reembolsable. (Sujeto a cambios de fecha)&nbsp;<br>Esperamos poder atenderle como usted se merece.</p></td></tr><tr><td align="center" style="padding:0;Margin:0;padding-top:10px;padding-bottom:10px;font-size:0px"><img class="adapt-img" src="https://static.wixstatic.com/media/a3b865_0b4cc1234bfd47848941afac73418b13~mv2.jpg" alt style="display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic" width="385" height="267"></td></tr> <tr>
<td align="center" style="padding:0;Margin:0;padding-top:10px;padding-bottom:10px"><span class="es-button-border" style="border-style:solid;border-color:#fafafb;background:#5ae4c0;border-width:2px;display:inline-block;border-radius:5px;width:auto"><a href="https://www.coralbluehuatulco.mx/" class="es-button" target="_blank" style="mso-style-priority:100 !important;text-decoration:none;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;color:#FFFFFF;font-size:20px;padding:10px 30px 10px 30px;display:inline-block;background:#5ae4c0;border-radius:5px;font-family:arial, 'helvetica neue', helvetica, sans-serif;font-weight:normal;font-style:normal;line-height:24px;width:auto;text-align:center;mso-padding-alt:0;mso-border-alt:10px solid #5ae4c0;padding-left:30px;padding-right:30px">Visitar Sitio Web</a></span></td></tr></table></td></tr></table></td></tr> <tr>
<td align="left" style="padding:0;Margin:0;padding-top:20px;padding-left:20px;padding-right:20px"><table cellpadding="0" cellspacing="0" width="100%" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"><tr><td align="center" valign="top" style="padding:0;Margin:0;width:560px"><table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"><tr><td align="center" class="es-m-txt-c" style="padding:0;Margin:0;padding-bottom:10px"><p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:26px;Margin-bottom:15px;color:#333333;font-size:26px"><b>Consideraciones:</b></p></td></tr></table></td></tr></table></td></tr> <tr>
<td class="esdev-adapt-off" align="left" style="Margin:0;padding-top:10px;padding-bottom:10px;padding-left:20px;padding-right:20px"><table cellpadding="0" cellspacing="0" class="esdev-mso-table" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;width:560px"><tr><td class="esdev-mso-td" valign="top" style="padding:0;Margin:0"><table cellpadding="0" cellspacing="0" class="es-left" align="left" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:left"><tr><td align="left" style="padding:0;Margin:0;width:30px"><table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"><tr>
<td align="center" style="padding:0;Margin:0;font-size:0px"><img class="adapt-img" src="https://enbrtfn.stripocdn.email/content/guids/CABINET_3d0df4c18b0cea2cd3d10f772261e0b3/images/2851617878322771.png" alt style="display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic" width="25" height="27"></td> </tr></table></td></tr></table></td><td style="padding:0;Margin:0;width:20px"></td> <td class="esdev-mso-td" valign="top" style="padding:0;Margin:0"><table cellpadding="0" cellspacing="0" class="es-left" align="left" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:left"><tr><td align="left" style="padding:0;Margin:0;width:220px"><table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"><tr>
<td align="left" style="padding:0;Margin:0"><p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#333333;font-size:14px">*El total de la estancia puede tener variaciones en la tarifa diaria.</p></td></tr></table></td></tr></table></td> <td style="padding:0;Margin:0;width:20px"></td><td class="esdev-mso-td" valign="top" style="padding:0;Margin:0"><table cellpadding="0" cellspacing="0" class="es-left" align="left" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:left"><tr><td align="left" style="padding:0;Margin:0;width:30px"><table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"><tr>
<td align="center" style="padding:0;Margin:0;font-size:0px"><img class="adapt-img" src="https://enbrtfn.stripocdn.email/content/guids/CABINET_3d0df4c18b0cea2cd3d10f772261e0b3/images/2851617878322771.png" alt style="display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic" width="25" height="27"></td></tr></table></td></tr></table></td> <td style="padding:0;Margin:0;width:20px"></td><td class="esdev-mso-td" valign="top" style="padding:0;Margin:0"><table cellpadding="0" cellspacing="0" class="es-right" align="right" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:right"><tr><td align="left" style="padding:0;Margin:0;width:220px"><table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"><tr>
<td align="left" style="padding:0;Margin:0"><p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#333333;font-size:14px">*Nuestras habitaciones son máximo para 4 personas sean adultos o menores.<br></p></td></tr></table></td></tr> </table></td></tr></table></td></tr> <tr><td class="esdev-adapt-off" align="left" style="Margin:0;padding-top:10px;padding-bottom:10px;padding-left:20px;padding-right:20px"><table cellpadding="0" cellspacing="0" class="esdev-mso-table" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;width:560px"><tr>
<td class="esdev-mso-td" valign="top" style="padding:0;Margin:0"><table cellpadding="0" cellspacing="0" class="es-left" align="left" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:left"><tr><td align="left" style="padding:0;Margin:0;width:30px"><table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"><tr><td align="center" style="padding:0;Margin:0;font-size:0px"><img class="adapt-img" src="https://enbrtfn.stripocdn.email/content/guids/CABINET_3d0df4c18b0cea2cd3d10f772261e0b3/images/2851617878322771.png" alt style="display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic" width="25" height="27"></td> </tr></table></td></tr></table></td><td style="padding:0;Margin:0;width:20px"></td>
<td class="esdev-mso-td" valign="top" style="padding:0;Margin:0"><table cellpadding="0" cellspacing="0" class="es-left" align="left" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:left"><tr><td align="left" style="padding:0;Margin:0;width:220px"><table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"><tr><td align="left" style="padding:0;Margin:0"><p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#333333;font-size:14px">*Todas nuestras tarifas ya incluyen impuestos.</p></td></tr> </table></td></tr></table></td><td style="padding:0;Margin:0;width:20px"></td>
<td class="esdev-mso-td" valign="top" style="padding:0;Margin:0"><table cellpadding="0" cellspacing="0" class="es-left" align="left" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:left"><tr><td align="left" style="padding:0;Margin:0;width:30px"><table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"><tr><td align="center" style="padding:0;Margin:0;font-size:0px"><img class="adapt-img" src="https://enbrtfn.stripocdn.email/content/guids/CABINET_3d0df4c18b0cea2cd3d10f772261e0b3/images/2851617878322771.png" alt style="display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic" width="25" height="27"></td></tr> </table></td></tr></table></td><td style="padding:0;Margin:0;width:20px"></td>
 <td class="esdev-mso-td" valign="top" style="padding:0;Margin:0"><table cellpadding="0" cellspacing="0" class="es-right" align="right" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:right"><tr><td align="left" style="padding:0;Margin:0;width:220px"><table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"><tr><td align="left" style="padding:0;Margin:0"><p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#333333;font-size:14px">*Los menores de 0 a 6 años son gratis, menores de 7 a 12 años tienen costo extra por noche, a partir de 13 años ya son considerados como adultos y están incluidos en la cotización final.</p>
 </td></tr></table></td></tr></table></td></tr></table></td></tr> <tr><td class="esdev-adapt-off" align="left" style="Margin:0;padding-top:10px;padding-left:20px;padding-right:20px;padding-bottom:30px"><table cellpadding="0" cellspacing="0" class="esdev-mso-table" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;width:560px"><tr><td class="esdev-mso-td" valign="top" style="padding:0;Margin:0"><table cellpadding="0" cellspacing="0" class="es-left" align="left" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:left"><tr><td align="left" style="padding:0;Margin:0;width:30px"><table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"><tr>
<td align="center" style="padding:0;Margin:0;font-size:0px"><img class="adapt-img" src="https://enbrtfn.stripocdn.email/content/guids/CABINET_3d0df4c18b0cea2cd3d10f772261e0b3/images/2851617878322771.png" alt style="display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic" width="25" height="27"></td> </tr></table></td></tr></table></td><td style="padding:0;Margin:0;width:20px"></td><td class="esdev-mso-td" valign="top" style="padding:0;Margin:0"><table cellpadding="0" cellspacing="0" class="es-left" align="left" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:left"><tr><td align="left" style="padding:0;Margin:0;width:220px"><table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"><tr>
<td align="left" style="padding:0;Margin:0"><p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#333333;font-size:14px">*Cotizacion vigente 5 dias.</p></td></tr></table></td> </tr></table></td><td style="padding:0;Margin:0;width:20px"></td><td class="esdev-mso-td" valign="top" style="padding:0;Margin:0"><table cellpadding="0" cellspacing="0" class="es-left" align="left" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:left"><tr><td align="left" style="padding:0;Margin:0;width:30px"><table cellpadding="0" cellspacing="0" width="100%" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"><tr><td align="center" style="padding:0;Margin:0;display:none"></td></tr></table></td>
</tr></table></td><td style="padding:0;Margin:0;width:20px"></td> <td class="esdev-mso-td" valign="top" style="padding:0;Margin:0"><table cellpadding="0" cellspacing="0" class="es-right" align="right" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:right"><tr><td align="left" style="padding:0;Margin:0;width:220px"><table cellpadding="0" cellspacing="0" width="100%" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"><tr><td align="center" style="padding:0;Margin:0;display:none"></td></tr></table></td></tr></table></td></tr></table></td></tr></table></td></tr></table>
 <table cellpadding="0" cellspacing="0" class="es-footer" align="center" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;table-layout:fixed !important;width:100%;background-color:transparent;background-repeat:repeat;background-position:center top"><tr><td align="center" style="padding:0;Margin:0"><table class="es-footer-body" align="center" cellpadding="0" cellspacing="0" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;background-color:transparent;width:640px" role="none"><tr><td align="left" style="Margin:0;padding-top:20px;padding-bottom:20px;padding-left:20px;padding-right:20px"><table cellpadding="0" cellspacing="0" width="100%" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"><tr>
<td align="left" style="padding:0;Margin:0;width:600px"><table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"><tr><td align="center" style="padding:0;Margin:0;padding-top:15px;padding-bottom:15px;font-size:0"><table cellpadding="0" cellspacing="0" class="es-table-not-adapt es-social" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"><tr><td align="center" valign="top" style="padding:0;Margin:0;padding-right:40px"><img title="Facebook" src="https://enbrtfn.stripocdn.email/content/assets/img/social-icons/logo-black/facebook-logo-black.png" alt="Fb" width="32" height="32" style="display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic"></td>
 <td align="center" valign="top" style="padding:0;Margin:0;padding-right:40px"><img title="Twitter" src="https://enbrtfn.stripocdn.email/content/assets/img/social-icons/logo-black/twitter-logo-black.png" alt="Tw" width="32" height="32" style="display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic"></td><td align="center" valign="top" style="padding:0;Margin:0;padding-right:40px"><img title="Instagram" src="https://enbrtfn.stripocdn.email/content/assets/img/social-icons/logo-black/instagram-logo-black.png" alt="Inst" width="32" height="32" style="display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic"></td>
 <td align="center" valign="top" style="padding:0;Margin:0"><img title="Youtube" src="https://enbrtfn.stripocdn.email/content/assets/img/social-icons/logo-black/youtube-logo-black.png" alt="Yt" width="32" height="32" style="display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic"></td></tr></table></td></tr><tr><td align="center" style="padding:0;Margin:0;padding-bottom:35px"><p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:18px;Margin-bottom:15px;color:#333333;font-size:12px">Style Casual&nbsp;© 2021 Style Casual, Inc. All Rights Reserved.</p>
 <p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:18px;Margin-bottom:15px;color:#333333;font-size:12px">4562 Hazy Panda Limits, Chair Crossing, Kentucky, US, 607898</p></td></tr> <tr><td style="padding:0;Margin:0"><table cellpadding="0" cellspacing="0" width="100%" class="es-menu" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"><tr class="links"><td align="center" valign="top" width="33.33%" style="Margin:0;padding-left:5px;padding-right:5px;padding-top:5px;padding-bottom:5px;border:0"><a target="_blank" href="" style="-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;text-decoration:none;display:block;font-family:arial, 'helvetica neue', helvetica, sans-serif;color:#999999;font-size:12px">Visit Us </a></td>
 <td align="center" valign="top" width="33.33%" style="Margin:0;padding-left:5px;padding-right:5px;padding-top:5px;padding-bottom:5px;border:0;border-left:1px solid #cccccc"><a target="_blank" href="" style="-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;text-decoration:none;display:block;font-family:arial, 'helvetica neue', helvetica, sans-serif;color:#999999;font-size:12px">Privacy Policy</a></td><td align="center" valign="top" width="33.33%" style="Margin:0;padding-left:5px;padding-right:5px;padding-top:5px;padding-bottom:5px;border:0;border-left:1px solid #cccccc"><a target="_blank" href="" style="-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;text-decoration:none;display:block;font-family:arial, 'helvetica neue', helvetica, sans-serif;color:#999999;font-size:12px">Terms of Use</a></td></tr></table></td></tr></table></td></tr> </table></td></tr></table>
</td></tr></table> <table cellpadding="0" cellspacing="0" class="es-content" align="center" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;table-layout:fixed !important;width:100%"><tr><td class="es-info-area" align="center" style="padding:0;Margin:0"><table class="es-content-body" align="center" cellpadding="0" cellspacing="0" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;background-color:transparent;width:600px" bgcolor="#FFFFFF" role="none"><tr><td align="left" style="padding:20px;Margin:0"><table cellpadding="0" cellspacing="0" width="100%" role="none" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"><tr>
<td align="center" valign="top" style="padding:0;Margin:0;width:560px"><table cellpadding="0" cellspacing="0" width="100%" role="presentation" style="mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px"><tr>
<td align="center" class="es-infoblock" style="padding:0;Margin:0;line-height:14px;font-size:12px;color:#CCCCCC"><p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:14px;Margin-bottom:15px;color:#CCCCCC;font-size:12px"><a target="_blank" href="" style="-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;text-decoration:underline;color:#CCCCCC;font-size:12px"></a>No longer want to receive these emails?&nbsp;<a href="" target="_blank" style="-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;text-decoration:underline;color:#CCCCCC;font-size:12px">Unsubscribe</a>.<a target="_blank" href="" style="-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;text-decoration:underline;color:#CCCCCC;font-size:12px"></a></p> </td>
// </tr></table></td></tr></table></td></tr></table></td></tr></table></td></tr></table></div></body></html>
      ''';
    return emailHtmlPart1;
  }
}
