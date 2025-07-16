import 'package:drift/drift.dart';

import 'cliente_table.dart';
import 'usuario_table.dart';

class CotizacionTable extends Table {
  IntColumn get idInt => integer().autoIncrement()();
  TextColumn get id => text().nullable()();
  TextColumn get folio => text().nullable()();
  IntColumn get clienteInt =>
      integer().nullable().references(ClienteTable, #idInt)();
  TextColumn get cliente => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime).nullable()();
  DateTimeColumn get fechaLimite => dateTime().nullable()();
  TextColumn get estatus => text().withDefault(const Constant("cotizado"))();
  BoolColumn get esGrupo => boolean().withDefault(const Constant(false))();
  IntColumn get creadoPorInt =>
      integer().nullable().references(UsuarioTable, #idInt)();
  TextColumn get creadoPor => text().nullable()();
  IntColumn get cerradoPorInt =>
      integer().nullable().references(UsuarioTable, #idInt)();
  TextColumn get cerradoPor => text().nullable()();
  RealColumn get subtotal => real().withDefault(const Constant(0))();
  RealColumn get descuento => real().withDefault(const Constant(0))();
  RealColumn get impuestos => real().withDefault(const Constant(0))();
  RealColumn get total => real().withDefault(const Constant(0))();
  TextColumn get comentarios => text().nullable()();
  IntColumn get cotizacionInt =>
      integer().nullable().references(CotizacionTable, #idInt)();
  TextColumn get cotizacion => text().nullable()();
}
