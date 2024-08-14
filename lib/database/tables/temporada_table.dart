import 'package:drift/drift.dart';

class Temporada extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text()();
  DateTimeColumn get fecha => dateTime().nullable()();
  TextColumn get fechaInicio => text().nullable()();
  TextColumn get fechaFin => text().nullable()();
  IntColumn get estanciaMinima => integer().nullable()();
  RealColumn get porcentajeDescuento => real().nullable()();
  BoolColumn get enAdelante => boolean().nullable()();
  TextColumn get codeTarifa => text().nullable()();
}
