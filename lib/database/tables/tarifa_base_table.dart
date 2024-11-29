import 'package:drift/drift.dart';

class TarifaBase extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text().nullable()();
  TextColumn get nombre => text().nullable()();
  RealColumn get descIntegrado => real().nullable()();
  RealColumn get upgradeCategoria => real().nullable()();
  RealColumn get upgradeMenor => real().nullable()();
  RealColumn get upgradePaxAdic => real().nullable()();
  IntColumn get tarifaPadreId => integer().nullable().references(TarifaBase, #id)();
}
