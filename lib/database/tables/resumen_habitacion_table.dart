import 'package:drift/drift.dart';

import 'categoria_table.dart';
import 'habitacion_table.dart';

class ResumenHabitacionTable extends Table {
  IntColumn get idInt => integer().autoIncrement()();
  TextColumn get id => text().nullable()();
  RealColumn get subtotal => real().withDefault(const Constant(0))();
  RealColumn get descuento => real().withDefault(const Constant(0))();
  RealColumn get impuestos => real().withDefault(const Constant(0))();
  RealColumn get total => real().withDefault(const Constant(0))();
  IntColumn get habitacionInt =>
      integer().nullable().references(HabitacionTable, #id)();
  TextColumn get habitacion => text().nullable()();
  IntColumn get categoriaInt =>
      integer().nullable().references(CategoriaTable, #id)();
  TextColumn get categoria => text().nullable()();
}
