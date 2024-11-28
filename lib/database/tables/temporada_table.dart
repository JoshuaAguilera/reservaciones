import 'package:drift/drift.dart';

class Temporada extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text()();
  TextColumn get nombre => text()();
  DateTimeColumn get fecha => dateTime().nullable()();
  IntColumn get estanciaMinima => integer().nullable()();
  RealColumn get porcentajePromocion => real().nullable()();
  TextColumn get codeTarifa => text().nullable()();
  BoolColumn get forGroup => boolean().nullable()();
  TextColumn get tarifaJSON => text().nullable()();
}
