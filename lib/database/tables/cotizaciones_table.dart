import 'package:drift/drift.dart';

class Cotizacion extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get folioPrincipal => text().nullable()();
  TextColumn get nombreHuesped => text().nullable()();
  TextColumn get numeroTelefonico => text().nullable()();
  TextColumn get correoElectrico => text().nullable()();
  // TextColumn get tipo => text().nullable()();
  DateTimeColumn get fecha => dateTime()();
  IntColumn get usuarioID => integer().nullable()();
  BoolColumn get esGrupo => boolean().nullable()();
  BoolColumn get esConcretado => boolean().nullable()();
  TextColumn get habitaciones => text().nullable()();
}
