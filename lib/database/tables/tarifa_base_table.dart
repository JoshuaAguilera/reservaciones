import 'package:drift/drift.dart';

import 'usuario_table.dart';

class TarifaBaseTable extends Table {
  IntColumn get idInt => integer().autoIncrement()();
  TextColumn get id => text().nullable()();
  TextColumn get codigo => text().nullable()();
  TextColumn get nombre => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime).nullable()();
  RealColumn get aumentoIntegrado => real().nullable()();
  BoolColumn get conAutocalculacion => boolean().nullable()();
  RealColumn get upgradeCategoria => real().nullable()();
  RealColumn get upgradeMenor => real().nullable()();
  RealColumn get upgradePaxAdic => real().nullable()();
  IntColumn get tarifaBaseInt =>
      integer().nullable().references(TarifaBaseTable, #idInt)();
  TextColumn get tarifaBase => text().nullable()();
  IntColumn get creadoPorInt =>
      integer().nullable().references(UsuarioTable, #idInt)();
  TextColumn get creadoPor => text().nullable()();
}
