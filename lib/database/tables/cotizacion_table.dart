import 'package:drift/drift.dart';

import 'cliente_table.dart';
import 'usuario_table.dart';

class CotizacionTable extends Table {
  IntColumn get idInt => integer().autoIncrement()();
  TextColumn get folio => text().nullable()();
  TextColumn get id => text().nullable()();
  IntColumn get clienteInt =>
      integer().nullable().references(ClienteTable, #id)();
  TextColumn get cliente => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime).nullable()();
  DateTimeColumn get fechaLimite => dateTime().nullable()();
  TextColumn get estatus => text().nullable()();
  BoolColumn get esGrupo => boolean().nullable()();
  IntColumn get creadoPorInt =>
      integer().nullable().references(UsuarioTable, #id)();
  TextColumn get creadoPor => text().nullable()();
  IntColumn get cerradoPorInt =>
      integer().nullable().references(UsuarioTable, #id)();
  TextColumn get cerradoPor => text().nullable()();
  RealColumn get subtotal => real().withDefault(const Constant(0))();
  RealColumn get descuento => real().withDefault(const Constant(0))();
  RealColumn get impuestos => real().withDefault(const Constant(0))();
  RealColumn get total => real().withDefault(const Constant(0))();
  TextColumn get comentarios => text().nullable()();
  IntColumn get cotizacionInt =>
      integer().nullable().references(CotizacionTable, #id)();
  TextColumn get cotizacion => text().nullable()();
}
