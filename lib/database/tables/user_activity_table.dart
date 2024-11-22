import 'package:drift/drift.dart';
import 'package:generador_formato/database/tables/usuario_table.dart';

class UserActivity extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get fecha => dateTime().nullable()();
  TextColumn get name => text().nullable()();
  TextColumn get category => text().nullable()();
  IntColumn get status => integer().nullable()();
  IntColumn get userId => integer().nullable().references(Usuario, #id)();
}
