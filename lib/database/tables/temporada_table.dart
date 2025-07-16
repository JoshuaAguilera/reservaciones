import 'package:drift/drift.dart';

import 'tarifa_rack_table.dart';

class TemporadaTable extends Table {
  IntColumn get idInt => integer().autoIncrement()();
  TextColumn get id => text().nullable()();
  TextColumn get tipo => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime).nullable()();
  TextColumn get nombre => text()();
  IntColumn get estanciaMinima => integer().nullable()();
  RealColumn get descuento => real().nullable()();
  RealColumn get ocupMin => real().nullable()();
  RealColumn get ocupMax => real().nullable()();
  IntColumn get tarifaRackInt =>
      integer().nullable().references(TarifaRackTable, #idInt)();
  TextColumn get tarifaRack => text().nullable()();
}
