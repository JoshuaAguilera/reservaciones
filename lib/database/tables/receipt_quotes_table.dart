import 'package:drift/drift.dart';

class ReceiptQuoteTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nameCustomer => text()();
  TextColumn get numPhone => text()();
  TextColumn get mail => text()();
  TextColumn get folioQuotes => text()();
  IntColumn get userId => integer()();
  TextColumn get dateRegister => text()();
  RealColumn get rateDay => real()();
  RealColumn get total => real()();
}