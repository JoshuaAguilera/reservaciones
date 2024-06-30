import 'package:drift/drift.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get password => text()();
  IntColumn get rol => integer().nullable().references(RolUser, #id)();
}

class RolUser extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text()();
}