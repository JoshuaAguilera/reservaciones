import 'package:drift/drift.dart';
import 'package:generador_formato/database/tables/usuario_table.dart';

class Cotizacion extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get folioPrincipal => text().nullable()();
  TextColumn get nombreHuesped => text().nullable()();
  TextColumn get numeroTelefonico => text().nullable()();
  TextColumn get correoElectrico => text().nullable()();
  DateTimeColumn get fecha => dateTime().nullable()();
  BoolColumn get esGrupo => boolean().nullable()();
  BoolColumn get esConcretado => boolean().nullable()();
  TextColumn get habitaciones => text().nullable()();
  IntColumn get usuarioID => integer().nullable().references(Usuario, #id)();
  TextColumn get username => text().nullable()();
}
