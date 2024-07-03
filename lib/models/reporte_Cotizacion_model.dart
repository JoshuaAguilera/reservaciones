class ReporteCotizacion {
  String? dia;
  int numCotizacionesIndividual;
  int numCotizacionesGrupales;
  int numCotizacionesIndividualPreventa;
  int numCotizacionesGrupalesPreventa;

  ReporteCotizacion({
    this.dia,
    required this.numCotizacionesIndividual,
    required this.numCotizacionesGrupales,
    required this.numCotizacionesGrupalesPreventa,
    required this.numCotizacionesIndividualPreventa,
  });
}
