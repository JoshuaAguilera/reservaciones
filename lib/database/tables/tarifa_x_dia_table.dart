import 'package:drift/drift.dart';

import 'tarifa_rack_table.dart';

class TarifaXDiaTable extends Table {
  IntColumn get idInt => integer().autoIncrement()();
  TextColumn get id => text().nullable()();
  IntColumn get tarifaRackInt =>
      integer().nullable().references(TarifaRackTable, #id)();
  TextColumn get tarifaRack => text().nullable()();
  RealColumn get descIntegreado => real().nullable()();
  BoolColumn get esLibre => boolean().nullable()();
  TextColumn get tarifaRackJson => text().nullable()();
}
