import 'package:drift/drift.dart';

class TarifaReal extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get fecha => dateTime()();
  TextColumn get tipoHuesped => text().nullable()();
  RealColumn get tarifa => real().nullable()();
}
