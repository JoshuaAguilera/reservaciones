import 'package:drift/drift.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
  TextColumn get password => text().nullable()();
  TextColumn get rol => text().nullable()();
  TextColumn get mail => text().nullable()();
  TextColumn get passwordMail => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get birthDate => text().nullable()();
  TextColumn get firstName => text().nullable()();
  TextColumn get secondName => text().nullable()();
}
