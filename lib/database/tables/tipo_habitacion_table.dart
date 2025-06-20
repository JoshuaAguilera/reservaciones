import 'package:drift/drift.dart';

class TipoHabitacionTable extends Table {
  IntColumn get idInt => integer().autoIncrement()();
  TextColumn get id => text().nullable()();
  TextColumn get nombre => text().nullable()();
  TextColumn get descripcion => text().nullable()();
}
