import 'package:drift/drift.dart';

import 'tarifa_rack_table.dart';

class TarifaXDiaTable extends Table {
  IntColumn get idInt => integer().autoIncrement()();
  TextColumn get id => text().nullable()();
  IntColumn get tarifaRackInt =>
      integer().nullable().references(TarifaRackTable, #idInt)();
  TextColumn get tarifaRack => text().nullable()();
  RealColumn get descIntegrado => real().nullable()();
  BoolColumn get esLibre => boolean().nullable()();
  BoolColumn get modificado => boolean().nullable()();
  TextColumn get tarifaRackJson => text().nullable()();
  TextColumn get temporadaJson => text().nullable()();
  TextColumn get periodoJson => text().nullable()();
}
