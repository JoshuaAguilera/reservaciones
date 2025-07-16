import 'package:drift/drift.dart';

import 'categoria_table.dart';
import 'tarifa_base_table.dart';
import 'tarifa_rack_table.dart';

class TarifaTable extends Table {
  IntColumn get idInt => integer().autoIncrement()();
  TextColumn get id => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime).nullable()();
  IntColumn get categoriaInt =>
      integer().nullable().references(CategoriaTable, #idInt)();
  TextColumn get categoria => text().nullable()();
  RealColumn get tarifaAdulto1a2 => real().nullable()();
  RealColumn get tarifaAdulto3 => real().nullable()();
  RealColumn get tarifaAdulto4 => real().nullable()();
  RealColumn get tarifaMenores7a12 => real().nullable()();
  RealColumn get tarifaMenores0a6 => real().nullable()();
  RealColumn get tarifaPaxAdicional => real().nullable()();
  IntColumn get tarifaBaseInt =>
      integer().nullable().references(TarifaBaseTable, #id)();
  TextColumn get tarifaBase => text().nullable()();
}

class RegistroTarifaTable extends Table {
  IntColumn get idInt => integer().autoIncrement()();
  TextColumn get id => text().nullable()();
  BoolColumn get esOriginal => boolean().withDefault(const Constant(false))();
  IntColumn get tarifaInt =>
      integer().nullable().references(TarifaTable, #id)();
  TextColumn get tarifa => text().nullable()();
  IntColumn get tarifaRackInt =>
      integer().nullable().references(TarifaRackTable, #id)();
  TextColumn get tarifaRack => text().nullable()();
}
