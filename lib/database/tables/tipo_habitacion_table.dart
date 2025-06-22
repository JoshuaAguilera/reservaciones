import 'package:drift/drift.dart';

class TipoHabitacionTable extends Table {
  IntColumn get idInt => integer().autoIncrement()();
  TextColumn get id => text().nullable()();
  TextColumn get codigo => text().nullable()();
  IntColumn get orden => integer().nullable()();
  TextColumn get descripcion => text().nullable()();
}
