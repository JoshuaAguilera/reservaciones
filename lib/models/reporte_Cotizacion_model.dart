class ReporteCotizacion {
  String? dia;
  int numCotizacionesIndividual;
  int numCotizacionesGrupales;
  int numReservacionesIndividual;
  int numReservacionesGrupales;

  ReporteCotizacion({
    this.dia,
    required this.numCotizacionesIndividual,
    required this.numCotizacionesGrupales,
    required this.numReservacionesGrupales,
    required this.numReservacionesIndividual,
  });
}
