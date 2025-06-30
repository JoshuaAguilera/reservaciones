import 'package:drift/drift.dart';

import 'habitacion_table.dart';
import 'tarifa_x_dia_table.dart';

class TarifaXHabitacionTable extends Table {
  IntColumn get idInt => integer().autoIncrement()();
  TextColumn get id => text().nullable()();
  TextColumn get subcode => text().nullable()();
  IntColumn get habitacionInt =>
      integer().nullable().references(HabitacionTable, #id)();
  TextColumn get habitacion => text().nullable()();
  IntColumn get tarifaXDiaInt =>
      integer().nullable().references(TarifaXDiaTable, #id)();
  TextColumn get tarifaXDia => text().nullable()();
  IntColumn get dia => integer().nullable()();
  DateTimeColumn get fecha => dateTime().nullable()();
  BoolColumn get esGrupal => boolean().nullable()();
}
