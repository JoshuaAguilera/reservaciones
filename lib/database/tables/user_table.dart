import 'package:drift/drift.dart';

class UsersTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get password => text()();
  IntColumn get rol => integer().nullable().references(RolUserTable, #id)();
}

class RolUserTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text()();
}