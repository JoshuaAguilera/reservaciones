import 'package:drift/drift.dart';

class Politicas extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get fechaActualizacion => dateTime().nullable()();
  IntColumn get intervaloHabitacionGratuita => integer().nullable()();
  IntColumn get limiteHabitacionCotizacion => integer().nullable()();
}
