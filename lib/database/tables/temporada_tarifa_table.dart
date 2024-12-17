import 'package:drift/drift.dart';
import 'package:generador_formato/database/tables/tarifa_table.dart';
import 'package:generador_formato/database/tables/temporada_table.dart';

class TemporadaTarifa extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get temporadaId => integer().nullable().references(Temporada, #id)();
  IntColumn get TarifaId => integer().nullable().references(Tarifa, #id)();
}
