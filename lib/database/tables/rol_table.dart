import 'package:drift/drift.dart';

class RolTable extends Table {
  IntColumn get idInt => integer().autoIncrement()();
  TextColumn get id => text().nullable()();
  TextColumn get nombre => text().nullable()();
  TextColumn get color => text().nullable()();
  TextColumn get descripcion => text().nullable()();
  TextColumn get permisos => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
