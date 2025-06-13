import 'package:drift/drift.dart';

import 'cliente_table.dart';
import 'usuario_table.dart';

class CotizacionTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get folioPrincipal => text().nullable()();
  DateTimeColumn get fecha => dateTime().nullable()();
  DateTimeColumn get fechaLimite => dateTime().nullable()();
  BoolColumn get esGrupo => boolean().nullable()();
  BoolColumn get esConcretado => boolean().nullable()();
  TextColumn get habitaciones => text().nullable()();
  IntColumn get usuarioID => integer().nullable().references(UsuarioTable, #id)();
  IntColumn get clienteID => integer().nullable().references(ClienteTable, #id)();
  TextColumn get username => text().nullable()();
}
