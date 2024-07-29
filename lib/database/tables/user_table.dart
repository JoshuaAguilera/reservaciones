import 'package:drift/drift.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get password => text()();
  TextColumn get rol => text()();
  TextColumn get mail => text()();
  TextColumn get passwordMail => text()();
  TextColumn get phone => text()();
}
