import 'package:drift/drift.dart';
import 'package:generador_formato/database/tables/images_table.dart';

class Usuario extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().unique()();
  TextColumn get password => text().nullable()();
  TextColumn get rol => text().nullable()();
  TextColumn get status => text().nullable()();
  TextColumn get correoElectronico => text().nullable()();
  TextColumn get passwordCorreo => text().nullable()();
  TextColumn get telefono => text().nullable()();
  TextColumn get fechaNacimiento => text().nullable()();
  TextColumn get nombre => text().nullable()();
  TextColumn get apellido => text().nullable()();
  IntColumn get numCotizaciones => integer().withDefault(const Constant(0)).nullable()();
  IntColumn get imageId => integer().nullable().references(ImagesTable, #id)();
}
