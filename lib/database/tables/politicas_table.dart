import 'package:drift/drift.dart';

class PoliticaTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get fechaActualizacion => dateTime().nullable()();
  IntColumn get intervaloHabitacionGratuita => integer().nullable()();
  IntColumn get limiteHabitacionCotizacion => integer().nullable()();
  IntColumn get diasVigenciaCotInd => integer().nullable()();
  IntColumn get diasVigenciaCotGroup => integer().nullable()();
}
