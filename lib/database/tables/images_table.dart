import 'package:drift/drift.dart';

class ImagesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text().nullable()();
  TextColumn get urlImage => text().nullable()();
}
