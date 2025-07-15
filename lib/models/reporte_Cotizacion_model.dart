import 'usuario_model.dart';

class ReporteCotizacion {
  String? dia;
  int numCotizacionesIndividual;
  int numCotizacionesGrupales;
  int numReservacionesIndividual;
  int numReservacionesGrupales;
  Usuario? usuario;

  ReporteCotizacion({
    this.dia,
    required this.numCotizacionesIndividual,
    required this.numCotizacionesGrupales,
    required this.numReservacionesGrupales,
    required this.numReservacionesIndividual,
    this.usuario,
  });
}
