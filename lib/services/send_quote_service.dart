import 'dart:io';
import 'dart:typed_data';
import 'package:generador_formato/models/cotizacion_model.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/utils/helpers/files_templates.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/src/widgets/document.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/shared_preferences/preferences.dart';
import 'base_service.dart';

class SendQuoteService extends BaseService {
  var mailUser = Preferences.mail;
  var passwordUser = Preferences.passwordMail;
  var phoneUser = Preferences.phone;
  var username = Preferences.username;

  Future<bool> sendQuoteMail(
    Document comprobantePDF,
    Cotizacion receiptQuotePresent,
    List<Habitacion> quotesPresent,
  ) async {
    bool isSent = false;

    String username = 'sys2@coralbluehuatulco.mx';
    String password = 'Sys2024CB';

    final smtpServer = SmtpServer(
      "mail.coralbluehuatulco.mx",
      username: username,
      password: password,
      port: 465,
      ssl: true,
      ignoreBadCertificate: true,
    );

    // Convertir el PDF a bytes
    final Uint8List pdfBytes = await comprobantePDF.save();

    final tempDir = await getTemporaryDirectory();

    File file = await File('${tempDir.path}/example.pdf').create();

    file.writeAsBytesSync(pdfBytes);

    final message = Message()
      ..from = Address(username, username)
      ..recipients.add(receiptQuotePresent.correoElectronico)
      ..subject =
          'Cotización de Reserva ${quotesPresent.first.categoria ?? ''} : ${DateTime.now().toString().substring(0, 10)}'
      ..html = FilesTemplate.getHTML(receiptQuotePresent, quotesPresent)
      ..attachments = [
        FileAttachment(file, fileName: "cotizacion.pdf", contentType: "pdf")
      ];

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      isSent = true;
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }

    var connection = PersistentConnection(smtpServer);
    await connection.close();
    return isSent;
  }

  Future<bool> sendQuoteWhatsApp(
      Cotizacion comprobante, List<Habitacion> cotizaciones) async {
    bool status = false;
    var phone = comprobante.numeroTelefonico;

    var message = "Estimad@ ${comprobante.nombreHuesped}," + "\n";
    message += "De antemano disculpe la demora de respuesta.\n";
    message +=
        "Agradecemos su interés en nuestro hotel CORAL BLUE HUATULCO, de acuerdo con su amable solicitud, me complace en presentarle la siguiente cotización.";
    message += "\n\n";
    message += "Ocupación: ${Utility.getOcupattionMessage(cotizaciones.first)}";
    message += "\n";
    message += "Estancia: ${Utility.getPeriodReservation(cotizaciones)}";
    message += "\n";
    message +=
        "Noches: ${Utility.getDifferenceInDays(cotizaciones: cotizaciones)}";
    message += "\n\n";
    message += "Habitación Deluxe doble, vista a la reserva";
    message += "\n\n";
    message += "Plan todo incluido: Total de estancia \$20,781.00";
    message += "\n\n";
    message += "Habitación Deluxe doble o King size, vista parcial al océano";
    message += "\n\n";
    message += "Plan todo incluido: Total de estancia \$24,432.00";
    message += "\n\n";
    message +=
        "*El total de la estancia puede tener variaciones en la tarifa diaria.";
    message += "\n\n";
    message += "*Todas nuestras tarifas ya incluyen impuestos.";
    message += "\n\n";
    message += "*Cotizacion vigente 5 dias.";
    message += "\n\n";
    message +=
        "*Nuestras habitaciones son máximo para 4 personas sean adultos o menores.";
    message += "\n\n";
    message +=
        "Para poder realizar su reservación le solicitamos el depósito de la primera noche, el resto de su estancia lo paga a su llegada.";
    message += "\n\n";
    message +=
        "*Los menores de 0 a 6 años son gratis, menores de 7 a 12 años tienen costo extra por noche, a partir de 13 años ya son considerados como adultos y están incluidos en la cotización final.";
    message += "\n\n";
    message +=
        "Al check in a todo huésped se le requiere dejar en garantía \$1,000 MXN (que puede ser en efectivo o tarjeta de crédito mediante la creación de un voucher abierto) que servirá para cubrir alguna penalidad en caso de perdida o extravio de llaves, toallas o alguna amenidad dentro de la habitación. La garantía de pago será devuelta al huésped al momento de hacer check out (salida de su reservación) y previa revisión al cuarto ocupado sin haber hallado algo roto, dañado, manchado o extraviado.";
    message += "\n\n";
    message +=
        "Tarifas exclusivas de preventa, sujetas a cambio sin previo aviso. \n Depósito de garantía no es reembolsable. (Sujeto a cambios de fecha) \nEsperamos poder atenderle como usted se merece.";

    var url = "https://wa.me/$phone/?text=${Uri.encodeQueryComponent(message)}";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
      status = true;
    } else {
      throw 'Could not launch $url';
    }

    return status;
  }
}
