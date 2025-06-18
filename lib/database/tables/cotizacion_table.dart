import 'package:drift/drift.dart';

import 'cliente_table.dart';
import 'usuario_table.dart';

class CotizacionTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get cotId => text().nullable()();
  TextColumn get folioPrincipal => text().nullable()();
  DateTimeColumn get fechaLimite => dateTime().nullable()();
  BoolColumn get esGrupo => boolean().nullable()();
  BoolColumn get esConcretado => boolean().nullable()();
  TextColumn get habitaciones => text().nullable()();
  IntColumn get creadoPor =>
      integer().nullable().references(UsuarioTable, #id)();
  IntColumn get cerradoPor =>
      integer().nullable().references(UsuarioTable, #id)();
  IntColumn get cliente => integer().nullable().references(ClienteTable, #id)();
  TextColumn get comentarios => text().nullable()();
  IntColumn get cotizacionOriginal =>
      integer().nullable().references(ClienteTable, #id)();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime).nullable()();
}
