import 'package:drift/drift.dart';

import 'cliente_table.dart';
import 'usuario_table.dart';

class Cotizacion extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get folioPrincipal => text().nullable()();
  DateTimeColumn get fecha => dateTime().nullable()();
  DateTimeColumn get fechaLimite => dateTime().nullable()();
  BoolColumn get esGrupo => boolean().nullable()();
  BoolColumn get esConcretado => boolean().nullable()();
  TextColumn get habitaciones => text().nullable()();
  IntColumn get usuarioID => integer().nullable().references(Usuario, #id)();
  IntColumn get clienteID => integer().nullable().references(Cliente, #id)();
  TextColumn get username => text().nullable()();
}
