import 'package:drift/drift.dart';

import 'cotizacion_table.dart';

class HabitacionTable extends Table {
  IntColumn get idInt => integer().autoIncrement()();
  TextColumn get id => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime).nullable()();
  IntColumn get cotizacionInt =>
      integer().nullable().references(CotizacionTable, #id)();
  TextColumn get cotizacion => text().nullable()();
  DateTimeColumn get checkIn => dateTime().nullable()();
  DateTimeColumn get checkOut => dateTime().nullable()();
  IntColumn get adultos => integer().nullable()();
  IntColumn get menores0a6 => integer().nullable()();
  IntColumn get menores7a12 => integer().nullable()();
  IntColumn get paxAdic => integer().nullable()();
  IntColumn get count => integer().nullable()();
  BoolColumn get esCortesia => boolean().nullable()();
}
