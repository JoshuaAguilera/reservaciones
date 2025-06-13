import 'package:drift/drift.dart';
import 'package:generador_formato/database/tables/tarifa_table.dart';
import 'package:generador_formato/database/tables/temporada_table.dart';

class TemporadaTarifaTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get temporadaId => integer().nullable().references(TemporadaTable, #id)();
  IntColumn get TarifaId => integer().nullable().references(TarifaTable, #id)();
}
