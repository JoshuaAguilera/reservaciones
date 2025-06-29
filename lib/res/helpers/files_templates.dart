import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../models/categoria_model.dart';
import '../../models/cotizacion_model.dart';
import '../../models/estructura_documento.dart';
import '../../models/habitacion_model.dart';
import '../../models/registro_tarifa_model.dart';
import '../../models/tarifa_model.dart';
import '../../models/tarifa_x_dia_model.dart';
import '../../models/tarifa_x_habitacion_model.dart';
import 'calculator_helpers.dart';
import 'constants.dart';
import 'utility.dart';

class FilesTemplate {
  static Future<pw.Font> fontLightGoogle() async {
    return PdfGoogleFonts.poppinsLight();
  }

  static Future<pw.Font> fontBoldGoogle() async {
    return PdfGoogleFonts.poppinsMedium();
  }

  static String StructureDoc(int id) {
    String structure = EstructuraDocumento().getMensaje(id);
    return structure;
  }

  static pw.Widget getTablesCotIndiv({
    required String tipoHab,
    required Habitacion room,
    required Categoria categoria,
    required pw.TextStyle styleGeneral,
    required pw.TextStyle styleHeader,
    required pw.TextStyle styleBold,
    bool requiredPreventa = false,
    String? colorHeader,
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

    var total = room.resumenes
            ?.where((element) =>
                (element.categoria?.idInt == categoria.idInt) &&
                (element.categoria?.tipoHabitacion?.codigo == tipoHab))
            .firstOrNull
            ?.total ??
        0;

    int index = contenido.length - 1;
    contenido.addAll(generateDaysCotizacion(room, index, tipoHab, categoria));

    return pw.Column(children: [
      if (numRooms > 1)
        pw.TableHelper.fromTextArray(
          border: pw.TableBorder.all(width: 1),
          headerStyle: styleHeader,
          headerCellDecoration: pw.BoxDecoration(
              color: PdfColor.fromHex(colorHeader ?? "#009999")),
          cellPadding: const pw.EdgeInsets.all(4),
          headers: [Utility.getOcupattionMessage(room)],
          data: [],
        ),
      pw.TableHelper.fromTextArray(
        border: pw.TableBorder.all(width: 1),
        headerStyle: styleHeader,
        cellPadding: const pw.EdgeInsets.all(4),
        headers: [categoria.nombre],
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
            "TOTAL DE ${room.count > 1 ? "HABITACIÓN" : "ESTANCIA"}",
            Utility.formatterNumber(total),
          ],
          data: [
            if (room.count > 1)
              <String>[
                "TOTAL DE ESTANCIA (x${room.count} rooms)",
                Utility.formatterNumber(total * room.count),
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

    TarifaXDia? tarifaXDia = habitacion.tarifasXHabitacion
        ?.where((element) => element.esGrupal == true)
        .firstOrNull
        ?.tarifaXDia;

    double descuentoTarifa = tarifaXDia?.descIntegrado ??
        tarifaXDia?.temporadaSelect?.descuento ??
        0;

    contenido = [
      for (var tarifa
          in tarifaXDia?.tarifaRack?.tarifas ?? List<Tarifa>.empty())
        <pw.Widget>[
          pw.Align(
            alignment: pw.Alignment.centerLeft,
            child: pw.Text(
              tarifa.categoria?.nombre ?? 'Unknow',
              style: styleGeneral,
            ),
          ),
          pw.Text(
              Utility.formatterNumber(
                Utility.calculatePromotion(
                  (tarifa.tarifaAdulto1a2 ?? 0).toString(),
                  descuentoTarifa,
                  returnDouble: true,
                  rounded: !(tarifaXDia?.modificado ?? false),
                ),
              ),
              style: styleBold),
          pw.Text(
              Utility.formatterNumber(
                Utility.calculatePromotion(
                  (tarifa.tarifaAdulto3 ?? 0).toString(),
                  descuentoTarifa,
                  returnDouble: true,
                  rounded: !(tarifaXDia?.modificado ?? false),
                ),
              ),
              style: styleBold),
          pw.Text(
              Utility.formatterNumber(
                Utility.calculatePromotion(
                  (tarifa.tarifaAdulto4 ?? 0).toString(),
                  descuentoTarifa,
                  returnDouble: true,
                  rounded: !(tarifaXDia?.modificado ?? false),
                ),
              ),
              style: styleBold),
          pw.Text(
              Utility.formatterNumber(
                Utility.calculatePromotion(
                  (tarifa.tarifaMenores7a12 ?? 0).toString(),
                  descuentoTarifa,
                  returnDouble: true,
                  rounded: !(tarifaXDia?.modificado ?? false),
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
    Habitacion habitacion,
    int index,
    String typeRoom,
    Categoria categoria,
  ) {
    List<List<String>> dias = [];
    int days = Utility.getDifferenceInDays(habitaciones: [habitacion]);
    int i = 0;

    for (var tarifaRoom
        in habitacion.tarifasXHabitacion ?? List<TarifaXHabitacion>.empty()) {
      double totalAdulto = CalculatorHelpers.calculateTarifa(
        habitacion,
        habitacion.tarifasXHabitacion?.length ?? 0,
        categoria,
        tarifaHab: tarifaRoom,
        descuentoProvisional: tarifaRoom.tarifaXDia?.descIntegrado,
        applyRoundFormat: !(tarifaRoom.tarifaXDia?.modificado ?? false),
      );

      double totalMenores = CalculatorHelpers.calculateTarifa(
        habitacion,
        habitacion.tarifasXHabitacion?.length ?? 0,
        categoria,
        tarifaHab: tarifaRoom,
        descuentoProvisional: tarifaRoom.tarifaXDia?.descIntegrado,
        isCalculateChildren: true,
        applyRoundFormat: !(tarifaRoom.tarifaXDia?.modificado ?? false),
      );

      DateTime now = habitacion.checkIn ?? DateTime.now();

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
      i++;
    }

    return dias;
  }

  static Future<String> getHTMLMail(
      Cotizacion cotizacion, List<Habitacion> habitaciones) async {
    String mailHTML = "";

    List<Habitacion> rooms =
        habitaciones.where((element) => !element.esCortesia).toList();

    try {
      String contenidoHtml = await rootBundle.loadString(
          "assets/file/${!(cotizacion.esGrupo ?? false) ? "xsx" : "quote_send_mail_group"}.html");
      String preMailHTML = "";

      if (!(cotizacion.esGrupo ?? false)) {
        preMailHTML = contenidoHtml
            .replaceAll(r'FNAMECUSTOMER', cotizacion.cliente?.nombres ?? '')
            .replaceAll(r'FFOLIOQUOTE', "${cotizacion.folio}");

        Map<String, List<Habitacion>> quoteFilters = {};

        for (var element in rooms) {
          String selectDates = "${element.checkIn}/${element.checkOut}";

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
              .replaceAll(
                  r'FNUMNIGHT', "${roomList.first.tarifasXHabitacion!.length}");

          contentMail +=
              '''<p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#131313;font-size:14px"><b>Habitación Deluxe doble, vista a la reserva 🏞️</b></p>''';

          contentMail +=
              '''<p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#131313;font-size:14px"><strong></strong></p>''';
          for (var element in roomList) {
            contentMail +=
                '''<p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#131313;font-size:14px">
                 <u>${Utility.getOcupattionMessage(element)}</u><br><strong>Total por noche ${Utility.formatterNumber(((element.totalVR ?? 1) / (element.tarifasXHabitacion?.length ?? 1)))}&nbsp;&nbsp;<br>Total por ${element.count > 1 ? "habitación" : "estancia"} ${Utility.formatterNumber(element.totalVR ?? 0)}${element.count > 1 ? "&nbsp;&nbsp;<br>Total por estancia ${Utility.formatterNumber((element.totalVR ?? 0) * element.count)}</strong></p>" : "</strong></p>"}''';
          }

          contentMail +=
              '''<p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#131313;font-size:14px"><b>Habitación Deluxe doble o King size, vista parcial al océano 🌊</b></p>''';

          for (var element in roomList) {
            contentMail +=
                '''<p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#131313;font-size:14px">
                 <u>${Utility.getOcupattionMessage(element)}</u><br><strong>Total por noche ${Utility.formatterNumber(((element.totalVPM ?? 1) / (element.tarifasXHabitacion?.length ?? 1)))}&nbsp;&nbsp;<br>Total por ${element.count > 1 ? "habitación" : "estancia"} ${Utility.formatterNumber(element.totalVPM ?? 0)}${element.count > 1 ? "&nbsp;&nbsp;<br>Total por estancia ${Utility.formatterNumber((element.totalVPM ?? 0) * element.count)}</strong></p>" : "</strong></p>"}''';
          }

          contentMail +=
              ''' <p style="Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;Margin-bottom:15px;color:#131313;font-size:14px">
                                                                        <strong></strong><br></p>''';
        }

        mailHTML = preMailHTML.replaceAll(r'LISTROOMSINSERT', contentMail);
      } else {
        preMailHTML = contenidoHtml.replaceAll(
            r'FNAMECUSTOMER', cotizacion.cliente?.nombres ?? '');
        mailHTML = preMailHTML;
      }
    } catch (e) {
      print("Error al cargar el archivo HTML: $e");
    }

    return mailHTML;
  }
}
