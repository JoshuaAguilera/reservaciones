import 'package:drift/drift.dart';

class Habitacion extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get subfolio => text()();
  TextColumn get categoria => text()();
  TextColumn get fechaCheckIn => text()();
  TextColumn get fechaCheckOut => text()();
  DateTimeColumn get fecha => dateTime()();
  IntColumn get adultos => integer().nullable()();
  IntColumn get menores0a6 => integer().nullable()();
  IntColumn get menores7a12 => integer().nullable()();
  IntColumn get paxAdic => integer().nullable()();
}
