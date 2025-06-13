import 'package:drift/drift.dart';
import 'package:generador_formato/database/tables/tarifa_base_table.dart';

class TarifaTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text().nullable()();
  DateTimeColumn get fecha => dateTime().nullable()();
  TextColumn get categoria => text().nullable()();
  RealColumn get tarifaAdultoSGLoDBL => real().nullable()();
  RealColumn get tarifaAdultoTPL => real().nullable()();
  RealColumn get tarifaAdultoCPLE => real().nullable()();
  RealColumn get tarifaMenores7a12 => real().nullable()();
  RealColumn get tarifaPaxAdicional => real().nullable()();
  IntColumn get tarifaPadreId =>
      integer().nullable().references(TarifaBaseTable, #id)();
}
