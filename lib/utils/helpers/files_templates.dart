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

    /*
                <img src="cid:Logo.png">
                <div id="pleca_logo" style="border-left: 1px solid #545454; height:100px;display:inline-block; margin:15px;display:none">

                </div>
                <img id="imgLogoProducto" class="imglogodv" style="width:150px; height:85px;margin-left:20px;margin-bottom:15px;display:none">
            </div>
            <div id="div_header_info">
                <span id="lblTitleConfirmacion" style="text-align:right;">Confirmaci&oacute;n de <strong>Reservaci&oacute;n</strong>:</span><br>
                <span id="lblTitleNum">No. </span><span id="spnNumeroRes" style="text-align:right;">(*NUMRES*)</span><br>
                <span id="divNewText">Favor de imprimir este documento para presentar en su Check-in</span>
            </div>

        </div>
        <table class="table table-striped">
            <tbody>
            <tr>
                <th colspan="6" scope="col">
			INFORMACI&oacute;N DE HUESPEDES
                </th>
            </tr>
            <tr style="vertical-align:top;line-height:11px; margin-top:10px;padding:10px;">
                <td>
                    <div id="dv_img_huesped">
                        <img id="img_huesped" src="./person.png">
                    </div>
                </td>
                <td>
                    <div class="info_huesped_group">
                        <span id="lblTitleNombreHuespedes" class="title">Nombre de los hu&eacute;spedes:</span>
                        <span id="lblNombreHuespedes" class="info">(*NOMHUE*)<br></span>
                    </div>
                </td>
                <td>
                    <div class="info_huesped_group">
                        <span id="lblTitleEmail2" class="title">Cuartos:</span>
                        <a id="cuartos" href="" style="text-decoration:none;color:inherit;cursor:pointer"><span  class="info">(*CTOS*)</span></a>
                    </div>
                </td>
            </tr>

            <tr>
                <th colspan="6" scope="col">
			INFORMACI&oacute;N DE RESERVA
                </th>
                </tr>
               <tr>
                    <td>
                        <div id="dv_img_airplane">
                            <img id="img_airplane" src="./business-outline.png">

                        </div>
                    </td>
                    <td>
                        <div class="info_rsva_group">
                            <span id="lblTitleDestino" class="title">Su Destino/Resort:</span>
                            <span class="info">
                                <a href="javascript:void(0);" id="lblDestino" style="text-decoration:underline;color:inherit;cursor:pointer" >Hotel H & Resorts / Queen Beach Club</a>
                            </span>

                        </div>
                    </td>
                    <td>
                        <div class="info_rsva_group">
                            <span id="lblTitleCheckIn" class="title">Check-In:</span>
                            <span id="lblCheckIn" class="info">marzo 09, 2018</span>
                        </div>
                    </td>
                    <td>
                        <div class="info_rsva_group">
                            <span id="lblTitleCheckOut" class="title">Check-Out:</span>
                            <span id="lblCheckOut" class="info">marzo 12, 2018</span>
                        </div>
                    </td>
                    <td>
                        <div class="info_rsva_group">
                            <span id="lblTitleTipoHabitacion" class="title">Tipo de Habitaci&oacute;n:</span>
                            <span id="divTipoHabitacion" class="info">JRS-JRS-S</span>
                        </div>
                    </td>
                    <td>
                        <div class="info_rsva_group">
                            <span id="lblTitleCapacidad" class="title">Capacidad M&aacute;xima:</span>
                            <span id="divCapacidad" class="info">4 Adultos, 0 Niños </span>
                        </div>
                    </td>
                </tr>
            </tr>
        </tbody></table>


        <table class="table table-striped">
            <tbody><tr>
                <th colspan="7" scope="col">
                    INFORMACI&oacute;N DE LA TRANSACCI&oacute;N
                </th>
                </tr>
                <tr>
                    <th scope="col">Tipo de Habitaci&oacute;n:</th>
                    <th scope="col">Descripci&oacute;n:</th>
                    <th scope="col">No. de Noches:</th>
                    <th scope="col">Cr&eacute;ditos:</th>
                    <th scope="col">No. Adultos:</th>
                    <th scope="col">No. Menores:</th>
                    <th scope="col">Infantes:</th>
                </tr>
                <tr><td class="first">JRS-JRS-S</td><td>Junior Suite-Junior Suite-Saturday</td><td>3</td><td>0</td><td>2</td><td>0</td><td>0</td></tr>
        </tbody></table>


        <div id="notes-group">
            <div id="trWaitList" style="display:none">
                <span class="boldtxt"><label id="lblWaitList">lblWaitList</label></span>
            </div>
            <div id="div_notas">
                <!--Nota para Argentinos-->
                <div id="trPrepagoNota" class="" style="display: none;">
                    <label id="lblPrepagoNota" style="background-color:Blue; color:#FFFFFF; font-weight:bold; font-size:14px;"></label>
                </div>
                <!-- Nota de la transaccion -->
                <p class="confirm-note" id="pNota">
                    <span><label id="lblTitleNota">Nota:</label></span>
                    <label id="lblNota">Estancia cubre: 2 adultos 0 menores, 3 noches de la estancia, Total: 360.00 USD<br>En esta reserva se aplican cambio de tarifas por temporada.<br><b>Additional Info</b> (06/03/2018) VIAJAN 2 ADULTOS 60 USD POR NOCHE<br></label>
                </p>


                <!-- Nota de las reservaciones outlet -->
                <label id="lblNotaOutlet"></label>
                <!-- Nota para Rewards -->
                <label id="lblNotaRewards"></label>
            </div>
        </div>



        <div id="div_contact">
            <!-- Datos de contacto  -->
            <div id="dv_img_contact">
                <img style="width: 8%;" id="contact_img" src="cid:HotelH.jpg">
            </div>
            <div id="dv_contacs">
                <div class="contact-group">
                    <label id="lblTitleAntesViaje">Para atenci&oacute;n al cliente:</label><span></span>
                    <b><label id="lblTitleTelAntes">958.583.40.25   958.583.40.22    958.583.40.30</label></b><span>&nbsp;|&nbsp;</span>
                    <b><label id="lblTitleAntesViaje">| WhatsApp: </label></b>
                    <b><label> 9581868764 |</label></b>
                    <b><a id="ancla-correo-antes" href="mailTo: reservas@hotelhhuatulco.com&nbsp;" style="text-decoration:none;color:inherit;cursor:pointer"><label id="lblTitleEmailAntes" style="cursor:pointer">reservas@hotelhhuatulco.com&nbsp;</label></a></b>
                </div>
            </div>


        </div>


        <div id="special-conditions">
            <span id="consideraciones">Consideraciones Especiales para la seguridad de todos los hu&eacute;spedes y personal del hotel:</span>

            <p id="derecho_admision">El hotel se reserva el derecho de admisi&oacute;n a toda persona que sea sospechosa de padecer alg&uacute;n s&iacute;ntoma relacionado con el virus SARS-CoV-2 (Covid-19) as&iacute; como derivar a un sistema de salud local a cualquier hu&eacute;sped que presente durante su estancia s&iacute;ntomas causados por la presencia del padecimiento.<br> Al reservar, todos los hu&eacute;spedes est&aacute;n obligados a cumplir sin excepci&oacute;n el reglamento interno y las nuevas disposiciones sanitarias del hotel en el que se alojan. El hu&eacute;sped queda sujeto a las sanciones del hotel y del pa&iacute;s que visitan en caso de incumplimiento.</p>

        </div>
        <center>
            <div id="contenido_media"></div>
        </center>
        <div>
            <table id="tblImportante" style="width:100%; text-align:justify;  vertical-align:text-top;">
                <tbody><tr id="trImportante" style="display: none;">
                    <td>
                        <h4 class="notetitle" style="color:red;"><label id="lblTitleImportante"></label></h4>
                        <table class="Importante" id="tblInfoImportante" style="width:100%; text-align:justify; vertical-align:text-top;">
                            <tbody><tr>
                                <td id="tdImportanteUno" style="width:45%; text-align:justify; vertical-align:top;"></td>

                            </tr>
                            <tr>
                                <td id="tdImportanteDos" style="width:45%; text-align:justify; vertical-align:top;"></td>
                            </tr>
                        </tbody></table>
                    </td>
                </tr>
            </tbody></table>
        </div>
        <div id="avisos_y_condiciones">
            <!-- Seccion de avisos y restricciones -->
            <table class="section-restriction" style="background-color:transparent;">
                <tbody><tr id="trInfoImportante" style="display: block;">
                    <td>
                        <h4 class="notetitleInfoImportante"><label id="lblTitleInfoImportante">Informaci&oacute;n Importante del Resort:</label></h4>
                        <!--<div class="InfoImportante" id="divInfoImportante" style="width:100%; text-align:justify; font-size:11px; vertical-align:text-top;">
                        </div>-->
                        <table class="InfoImportante" id="tblInfoImportante" style="width:100%; text-align:justify;  vertical-align:text-top; background-color:transparent;">
                            <tbody><tr>
                                <td id="tdInfoImportanteUno" style="width:45%; text-align:justify;  vertical-align:top;"> <ul> <li>	La hora entrada es a partir de las 15:00 horas, para la salida y desalojar las habitaciones se fija a las 12:00 horas de cada d&iacute;a. Si alg&uacute;n hu&eacute;sped permanece m&aacute;s tiempo se le cargar&aacute; $100 por cada hora, sin tolerancia. 
                                    </li><li>	Est&aacute; prohibido usar la habitaci&oacute;n para ejecutar cualquier acto ilicito o fuera de la ley y sera remitido a las autoridades en su caso.
                                    </li><li>	Ninguna persona tiene derecho a dar alojamiento a otra sin el consentimiento previo de la gerencia y hacer arreglos para su registro o cuota. 
                                    </li><li>	Unicamente el personal del hotel podra prestar servicio a los hu&eacute;spedes, en caso de  tener personal particular a su servicio, ser&aacute;n considerados como hu&eacute;spedes a cargo de la habitaci&oacute;n del titular, quien se responsabiliza de la conducta de los mismos.
                                    </li><li>	Esta prohibido a los usuarios realizar, durante su estancia, actos que falten a la moral, buenas costumbres o tranquilidad del resto de los hu&eacute;spedes. 
                                    </li><li>	El hu&eacute;sped deber&aacute; comportarse con decencia y moralidad dentro del establecimiento, qued&aacute;ndose prohibido alterar el orden, hacer ruidos que incomoden o molesten a los dem&aacute;s hu&eacute;spedes, el establecimiento podr&aacute; cancelar los servicios de hospedaje en estos supuestos.
                                    </li><li>	El hotel se reserva el derecho de admisi&oacute;n de visitas acompañantes ocasionales a las instalaciones del hotel, en ning&uacute;n caso se permitir&aacute; el acceso de las mismas a las habitaciones. es una medida de seguridad tanto para el cliente como para el hotel.
                                    </li><li>	El establecimiento proh&iacute;be estrictamente el uso de velas, inciensos, material peligroso o inflamable; as&iacute; como el uso de chocolates sin envolturas en nuestros blancos. hacer caso omiso de esta norma generar&aacute; una multa por la misma cantidad del costo de su habitaci&oacute;n.
                                    </li><li>	El hotel no se har&aacute; responsable por dinero o valores olvidados en la habitaci&oacute;n o &aacute;reas p&uacute;blicas. Por lo que le recordamos que dentro del closet se encuentra la caja fuerte, apoyada de un instructivo para su uso o en su caso puede resguardar sus art&iacute;culos de valor, en la caja de seguridad de la administraci&oacute;n. Dirigi&eacute;ndose directamente a recepci&oacute;n.
                                    </li><li>	Las s&aacute;banas, frazadas, cubre colchones, sobrecamas, toallas y alfombras de felpa que est&eacute;n sucias, rotas o manchadas (sangre o cualquier otro l&iacute;quido, o sustancia) el hu&eacute;sped es quien paga por el daño ocasionado. generando un gasto extra de $1000.00 como m&iacute;nimo o el monto total de la prenda. pagos de este tipo se realizan inmediatamente y en efectivo.
                                    </li><li>	El hotel tiene prohibido a sus clientes fumar en las habitaciones de acuerdo a la ley nacional anti-tabaco, el hecho causa deterioro de las mismas y se cobrara un 30% del total de la tarifa como costo de limpieza adicional en cada incidencia. Las habitaciones son libres de humo: &uacute;nicamente se podr&aacute; fumar en &aacute;reas de terraza. en caso de dejar impregnada la habitaci&oacute;n con olor a cigarro, se generar&aacute; un cargo por  la cantidad de $ 5,000.00 Para limpieza y purificaci&oacute;n de la habitaci&oacute;n. De acuerdo con la Ley Anti Tabaco, queda prohibido fumar en &aacute;rea cerradas, por lo que el Hotel les brinda un espacio abierto.
                                    </li><li>	Esta prohibido introducir alimentos y bebidas externas en &aacute;reas p&uacute;blicas del hotel. Solo se admite el consumo dentro de su habitaci&oacute;n o en la zona de la palapa del Lobby.
                                    </li><li>	Est&aacute; prohibido introducir alimentos o bebidas de cualquier tipo a las instalaciones del Hotel y/o Restaurante, alberca y playa, en caso de hacerlo el hu&eacute;sped tendra un cobro extra de acuerdo con el n&uacute;mero o cantidad de alimentos o bebidas introducidas.
                                    </li><li>	El hotel se reserva el derecho de suspender el servicio de bebidas cuando el hu&eacute;sped est&eacute; en evidente estado de ebriedad. Lo anterior por seguridad de los hu&eacute;spedes y clientes del centro de consumo.</li>
                                </ul>
                                </td>
                                <td style="width:2%"></td>
                                <td id="tdInfoImportanteDos" style="width:45%; text-align:justify;  vertical-align:top;">
                                    <li>  Las reservaciones se garantizan &uacute;nica y exclusivamente hasta al momento de proporcionar datos v&aacute;lidos de una Tarjeta de Cr&eacute;dito . Operadora Queen Beach S.A. de C.V. realizar&aacute; un cargo a su Tarjeta de Cr&eacute;dito por el valor TOTAL DE LA RESERVACION de la(s) habitaci&oacute;n(es) 15 d&iacute;as antes de su fecha de llegada; en caso de no contar con fondos suficientes o los datos de la tarjeta sean incorrectos la reservaci&oacute;n ser&aacute; cancelada.
                                    </li><li>  Operadora Queen Beach S.A. de C.V. realizar&aacute; un cargo a su Tarjeta de Cr&eacute;dito por el valor total de la reservaci&oacute;n 15 d&iacute;as antes de su fecha de llegada; en caso de no contar con fondos suficientes o los datos de la tarjeta sean incorrectos la reservaci&oacute;n ser&aacute; cancelada sin responsabilidad para brindar hospedaje por parte del Hotel.
                                    </li><li> La penalizaci&oacute;n en caso de no-show, no llegada del hu&eacute;sped ,  ser&aacute; la no devoluci&oacute;n del valor total de la reservaci&oacute;n; y ser&aacute; cargada a la tarjeta de cr&eacute;dito del hu&eacute;sped o si se hizo UN dep&oacute;sito bancario no habr&aacute; devoluci&oacute;n . La &uacute;nica cuenta registrada por la empresa para recibir dep&oacute;sitos de hospedaje, alimentos y bebidas es BANORTE CUENTA: 1165714337  CLABE: 072 180 011 6571 43370. La empresa no se hace responsable por dep&oacute;sitos bancarios que no hayan sido a esta cuenta. 
                                    </li>
                                    </td>
                            </tr>
                        </tbody></table>
                    </td>
                </tr>
                        </tbody></table>
                    </td>
                </tr>

            </tbody></table>
        </div>

        <div id="tblAvisoPrivacidad" style="display: block;text-align: center;"><li>Las devoluciones al 100% se podr&aacute;n hacer 15 d&iacute;as antes de la fecha de llegada.</li> 
            GRACIAS POR ELEGIR EL HOTEL H PARA SU ESTANCIA EN BAHIAS DE HUATULCO.
            SERA UN PLACER ATENDERLE, LE DESEAMOS FELIZ VIAJE, LO ESPERAMOS EN BAHIAS DE HUATULCO
        <br><img style="width: 8%;" src="./HotelH.jpg" alt=""></div>
    </div>



</body>
<style type="text/css">
	html {
    		margin: 15px;
    		font-family: cursive;
	}
	th {
	    TEXT-ALIGN-LAST: CENTER;
	}
</style>
</html>";
*/
    return HTML;
  }
}
