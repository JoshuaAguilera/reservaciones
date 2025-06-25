import 'package:drift/drift.dart';

import 'usuario_table.dart';

class PoliticaTarifarioTable extends Table {
  IntColumn get idInt => integer().autoIncrement()();
  TextColumn get id => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime).nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  TextColumn get clave => text().nullable()();
  TextColumn get valor => text().nullable()();
  TextColumn get descripcion => text().nullable()();
  IntColumn get creadoPorInt =>
      integer().nullable().references(UsuarioTable, #id)();
  TextColumn get creadoPor => text().nullable()();
}
