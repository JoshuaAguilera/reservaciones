import 'package:drift/drift.dart';

class QuoteGroup extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get folio => text()();
  BoolColumn get isPresale => boolean()();
  TextColumn get category => text()();
  TextColumn get plan => text()();
  DateTimeColumn get registerDate => dateTime()();
  TextColumn get enterDate => text()();
  TextColumn get outDate => text()();
  RealColumn get rateAdult1_2 => real()();
  RealColumn get rateAdult3 => real()();
  RealColumn get rateAdult4 => real()();
  RealColumn get rateMinor => real()();
}
