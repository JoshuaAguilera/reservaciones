import 'package:drift/drift.dart';

class Tarifa extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tarifaPadreId => integer().nullable()();
  RealColumn get descIntegrado => real().nullable()();
  TextColumn get code => text().nullable()();
  DateTimeColumn get fecha => dateTime().nullable()();
  TextColumn get categoria => text().nullable()();
  RealColumn get tarifaAdultoSGLoDBL => real().nullable()();
  RealColumn get tarifaAdultoTPL => real().nullable()();
  RealColumn get tarifaAdultoCPLE => real().nullable()();
  RealColumn get tarifaMenores7a12 => real().nullable()();
  RealColumn get tarifaPaxAdicional => real().nullable()();
}
