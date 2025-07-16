import 'package:drift/drift.dart';

import 'tipo_habitacion_table.dart';
import 'usuario_table.dart';

class CategoriaTable extends Table {
  IntColumn get idInt => integer().autoIncrement()();
  TextColumn get id => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime).nullable()();
  TextColumn get nombre => text().nullable()();
  TextColumn get color => text().nullable()();
  TextColumn get descripcion => text().nullable()();
  IntColumn get tipoHabitacionInt =>
      integer().nullable().references(TipoHabitacionTable, #idInt)();
  TextColumn get tipoHabitacion => text().nullable()();
  IntColumn get creadoPorInt =>
      integer().nullable().references(UsuarioTable, #idInt)();
  TextColumn get creadoPor => text().nullable()();
}
