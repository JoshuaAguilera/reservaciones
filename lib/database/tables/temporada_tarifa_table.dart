import 'package:drift/drift.dart';

import 'tarifa_table.dart';
import 'temporada_table.dart';

class TarifaTemporadaTable extends Table {
  IntColumn get idInt => integer().autoIncrement()();
  TextColumn get id => text().nullable()();
  IntColumn get temporadaInt =>
      integer().nullable().references(TemporadaTable, #id)();
  TextColumn get temporada => text().nullable()();
  IntColumn get tarifaInt =>
      integer().nullable().references(TarifaTable, #id)();
  TextColumn get tarifa => text().nullable()();
}
