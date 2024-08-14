import 'package:drift/drift.dart';

class TarifaXDia extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get subfolio => text().nullable()();
  IntColumn get dia => integer().nullable()();
  DateTimeColumn get fecha => dateTime()();
  RealColumn get tarifaRealPaxAdic => real().nullable()();
  RealColumn get tarifaPreventaPaxAdic => real().nullable()();
  RealColumn get tarifaRealAdulto => real().nullable()();
  RealColumn get tarifaPreventaAdulto => real().nullable()();
  RealColumn get tarifaRealMenores7a12 => real().nullable()();
  RealColumn get tarifaPreventaMenores7a12 => real().nullable()();
  TextColumn get codePeriodo => text().nullable()();
  TextColumn get codeTemporada => text().nullable()();
  TextColumn get codeTarifa => text().nullable()();
}
