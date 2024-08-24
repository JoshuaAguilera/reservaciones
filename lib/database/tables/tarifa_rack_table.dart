import 'package:drift/drift.dart';

class TarifaRack extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text()();
  DateTimeColumn get fecha => dateTime().nullable()();
  TextColumn get nombreRack => text().nullable()();
  TextColumn get colorIdentificacion => text().nullable()();
  TextColumn get codeTemporada => text().nullable()();
  TextColumn get codePeriodo => text().nullable()();
  IntColumn get usuarioId => integer().nullable()();
}
