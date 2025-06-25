import 'package:drift/drift.dart';

import 'imagen_table.dart';
import 'rol_table.dart';

class UsuarioTable extends Table {
  IntColumn get idInt => integer().autoIncrement()();
  TextColumn get id => text().nullable()();
  TextColumn get username => text().nullable()();
  TextColumn get password => text().nullable()();
  TextColumn get estatus =>
      text().withDefault(const Variable("registrado")).nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime).nullable()();
  TextColumn get correoElectronico => text().nullable()();
  TextColumn get telefono => text().nullable()();
  DateTimeColumn get fechaNacimiento => dateTime().nullable()();
  TextColumn get nombre => text().nullable()();
  TextColumn get apellido => text().nullable()();
  IntColumn get imagenInt => integer().nullable().references(ImagenTable, #id)();
  TextColumn get imagen => text().nullable()();
  IntColumn get rolInt => integer().nullable().references(RolTable, #id)();
  TextColumn get rol => text().nullable()();
}
