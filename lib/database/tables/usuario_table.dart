import 'package:drift/drift.dart';

import 'images_table.dart';

class UsuarioTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().nullable()();
  TextColumn get password => text().nullable()();
  TextColumn get rol => text().nullable()();
  TextColumn get estatus =>
      text().withDefault(const Variable("registrado")).nullable()();
  TextColumn get correoElectronico => text().nullable()();
  TextColumn get telefono => text().nullable()();
  TextColumn get fechaNacimiento => text().nullable()();
  TextColumn get nombre => text().nullable()();
  TextColumn get apellido => text().nullable()();
  IntColumn get imageId => integer().nullable().references(ImageTable, #id)();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime).nullable()();
}
