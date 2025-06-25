import 'package:drift/drift.dart';
import 'package:generador_formato/database/tables/cotizacion_table.dart';

import 'usuario_table.dart';

class ReservacionTable extends Table {
  IntColumn get idInt => integer().autoIncrement()();
  TextColumn get id => text().nullable()();
  IntColumn get cotizacionInt =>
      integer().nullable().references(CotizacionTable, #id)();
  TextColumn get cotizacion => text().nullable()();
  TextColumn get sku => text().nullable()();
  TextColumn get folio => text().nullable()();
  TextColumn get estatus => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime).nullable()();
  TextColumn get reservacionZabiaId => text().nullable()();
  RealColumn get deposito => real().nullable()();
  IntColumn get creadoPorInt =>
      integer().nullable().references(UsuarioTable, #id)();
  TextColumn get creadoPor => text().nullable()();
}

class ReservacionBrazaleteTable extends Table {
  IntColumn get reservacionInt =>
      integer().nullable().references(ReservacionTable, #id)();
  TextColumn get reservacion => text().nullable()();
  TextColumn get codigo => text().nullable()();
  TextColumn get folioReservacion => text().nullable()();
}
