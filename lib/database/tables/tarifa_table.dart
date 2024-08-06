import 'package:drift/drift.dart';

class Tarifa extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get fecha => dateTime()();
  TextColumn get fechaInicio => text()();
  TextColumn get fechaFin => text()();
  TextColumn get tarifaRack => text()();
  RealColumn get tarifaPreventa => real().nullable()();
  RealColumn get porcentajeDescuento => real().nullable()();
  TextColumn get categoria => text()();
  IntColumn get nivel => integer()();
  IntColumn get tarifaRealId => integer()();
  IntColumn get responsableId => integer()();
}
