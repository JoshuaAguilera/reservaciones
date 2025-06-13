import 'package:drift/drift.dart';

class HabitacionTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get folioHabitacion => text().nullable()();
  TextColumn get folioCotizacion => text().nullable()();
  TextColumn get fechaCheckIn => text().nullable()();
  TextColumn get fechaCheckOut => text().nullable()();
  DateTimeColumn get fecha => dateTime()();
  IntColumn get adultos => integer().nullable()();
  IntColumn get menores0a6 => integer().nullable()();
  IntColumn get menores7a12 => integer().nullable()();
  IntColumn get paxAdic => integer().nullable()();
  IntColumn get count => integer().nullable()();
  BoolColumn get isFree => boolean().nullable()();
  BoolColumn get useCashSeason => boolean().nullable()();
  TextColumn get tarifaXDia => text().nullable()();
}
