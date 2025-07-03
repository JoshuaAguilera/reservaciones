import 'dart:io';
import 'dart:typed_data';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/src/widgets/document.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/categoria_model.dart';
import '../../models/cotizacion_model.dart';
import '../../models/habitacion_model.dart';
import '../../res/helpers/date_helpers.dart';
import '../../res/helpers/files_templates.dart';
import '../../res/helpers/utility.dart';
import '../../utils/encrypt/encrypter.dart';
import 'base_service.dart';

class SendQuoteService extends BaseService {
  Future<String> sendQuoteMail(
    Document comprobantePDF,
    Cotizacion receiptQuotePresent,
    List<Habitacion> quotesPresent,
    List<Categoria> categorias, {
    String? newMail,
  }) async {
    String messageSent = "";
    String passMail = EncrypterTool.decryptData(passwordMail, null);

    final smtpServer = SmtpServer(
      mailServer,
      username: mail,
      password: passMail,
      port: portSMTP,
      ssl: applySSL,
      ignoreBadCertificate: ignoreBadCertificate,
    );

    try {
      // Convertir el PDF a bytes
      final Uint8List pdfBytes = await comprobantePDF.save();

      final tempDir = await getTemporaryDirectory();

      File file =
          await File('${tempDir.path}/example$userId$userName.pdf').create();

      file.writeAsBytesSync(pdfBytes);

      final message = Message()
        ..from = Address(mail, "$firstName $lastName")
        ..recipients
            .add(newMail ?? receiptQuotePresent.cliente?.correoElectronico)
        ..subject =
            'Cotización de Reserva ${receiptQuotePresent.folio} : ${DateTime.now().toString().substring(0, 10)}'
        ..html = await FilesTemplate.getHTMLMail(
          receiptQuotePresent,
          quotesPresent,
          categorias,
        )
        ..attachments = [
          FileAttachment(file, fileName: "cotizacion.pdf", contentType: "pdf")
        ];

      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        messageSent += 'Problem: ${p.code}: ${p.msg}\n';
        print(messageSent);
      }
    }

    var connection = PersistentConnection(smtpServer);
    await connection.close();
    return messageSent;
  }

  Future<String> generateMessageWhatsApp(
    Cotizacion comprobante,
    List<Categoria> categorias,
  ) async {
    final rooms =
        comprobante.habitaciones?.where((h) => !h.esCortesia).toList() ?? [];

    final cliente = comprobante.cliente?.nombres ?? "";
    final buffer = StringBuffer();

    // Encabezado
    buffer.writeln("*Estimad@ $cliente*,");
    buffer.writeln("De antemano disculpe la demora de respuesta.");
    buffer.writeln(
      "Agradecemos su interés en nuestro hotel CORAL BLUE HUATULCO, de acuerdo con su amable solicitud, me complace en presentarle la siguiente cotización.\n",
    );

    // Agrupar habitaciones por rango de fechas
    final Map<String, List<Habitacion>> grouped = {};
    for (var room in rooms) {
      final key = "${room.checkIn}/${room.checkOut}";
      grouped.putIfAbsent(key, () => []).add(room);
    }

    for (var roomList in grouped.values) {
      final first = roomList.first;
      final noches = first.tarifasXHabitacion?.length ?? 0;

      buffer.writeln("*Plan Todo Incluido*");
      buffer
          .writeln("*Estancia: ${DateHelpers.getPeriodReservation([first])}*");
      buffer.writeln("*Noches: $noches*");

      for (var room in roomList) {
        buffer.writeln();
        buffer.writeln("*${Utility.getOcupattionMessage(room)}*");

        for (final resumen in room.resumenes ?? []) {
          final categoria = categorias.firstWhere(
            (c) => c.idInt == resumen.categoria?.idInt,
            orElse: () => Categoria(nombre: "Sin categoría"),
          );

          final total = resumen.total ?? 0.0;
          final precioNoche = total / (room.tarifasXHabitacion?.length ?? 1);
          final isMultiple = room.count > 1;

          buffer.writeln();
          buffer.writeln("*${categoria.nombre}*");
          buffer.writeln(
              "*Total por noche:* ${Utility.formatterNumber(precioNoche)}");
          buffer.writeln(
              "*Total de ${isMultiple ? 'habitación' : 'estancia'}:* ${Utility.formatterNumber(total)}");
          if (isMultiple) {
            final totalEstancia = total * room.count;
            buffer.writeln(
                "*Total de estancia:* ${Utility.formatterNumber(totalEstancia)}");
          }
        }
      }

      buffer.writeln("\n");
    }

    // Condiciones y políticas
    buffer
      ..writeln(
          "*El total de la estancia puede tener variaciones en la tarifa diaria.\n")
      ..writeln("*Todas nuestras tarifas ya incluyen impuestos.\n")
      ..writeln("*Cotización vigente 5 días.\n")
      ..writeln(
          "*Nuestras habitaciones son máximo para 4 personas sean adultos o menores.\n")
      ..writeln(
        "Para poder realizar su reservación le solicitamos el depósito de la primera noche, el resto de su estancia lo paga a su llegada.\n",
      )
      ..writeln(
        "*Los menores de 0 a 6 años son gratis, menores de 7 a 12 años tienen costo extra por noche, a partir de 13 años ya son considerados como adultos y están incluidos en la cotización final.\n",
      )
      ..writeln(
        "Al check in a todo huésped se le requiere dejar en garantía \$1,000 MXN (que puede ser en efectivo o tarjeta de crédito mediante la creación de un voucher abierto)...",
      )
      ..writeln(
        "Tarifas exclusivas de preventa, sujetas a cambio sin previo aviso.\nDepósito de garantía no es reembolsable. (Sujeto a cambios de fecha)\nEsperamos poder atenderle como usted se merece.",
      );

    return buffer.toString();
  }

  Future<String> generateMessageWhatsAppGroup(Cotizacion comprobante) async {
    var message = "*Estimad@ ${comprobante.cliente?.nombres}*," + "\n";
    message +=
        "Le comparto por este medio la cotización que amablemente solicitó a Hotel Coral Blue Huatulco, esperando esta sea de su agrado y podamos ser beneficiados por su preferencia, en caso de requerir alguna solicitud especial que no está especificada en esta cotización favor de mencionarla para poder enviarla a la brevedad posible.";
    message += "\n\n";
    message += "*Quedamos a sus órdenes.*";

    return message;
  }

  Future<bool> sendQuoteWhatsApp(String message) async {
    bool status = false;

    var url =
        "https://wa.me/+52$phone/?text=${Uri.encodeQueryComponent(message)}";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
      status = true;
    } else {
      throw 'Could not launch $url';
    }

    return status;
  }
}
