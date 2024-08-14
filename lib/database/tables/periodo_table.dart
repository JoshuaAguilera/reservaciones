import 'package:drift/drift.dart';

class Periodo extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text()();
  DateTimeColumn get fecha => dateTime().nullable()();
  TextColumn get nombreRack => text().nullable()();
  TextColumn get nivel => text().nullable()();
  TextColumn get colorIdentificacion => text().nullable()();
  TextColumn get codeTemporada => text().nullable()();
  IntColumn get usuarioId => integer().nullable()();
}
