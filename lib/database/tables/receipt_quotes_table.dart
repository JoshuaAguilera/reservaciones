import 'package:drift/drift.dart';

class ReceiptQuote extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nameCustomer => text()();
  TextColumn get numPhone => text()();
  TextColumn get mail => text()();
  TextColumn get folioQuotes => text()();
  IntColumn get userId => integer()();
  DateTimeColumn get dateRegister => dateTime()();
  RealColumn get rateDay => real()();
  RealColumn get total => real()();
  IntColumn get rooms => integer()();
  BoolColumn get isGroup => boolean()();
}