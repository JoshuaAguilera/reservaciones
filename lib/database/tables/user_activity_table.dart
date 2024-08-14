import 'package:drift/drift.dart';

class UserActivity extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get fecha => dateTime().nullable()();
  TextColumn get name => text().nullable()();
  TextColumn get status => text().nullable()();
  IntColumn get userId => integer().nullable()();
}
