import 'package:drift/drift.dart';

class ImageTable extends Table {
  IntColumn get idInt => integer().autoIncrement()();
  TextColumn get id => text().nullable()();
  TextColumn get nombre => text().nullable()();
  TextColumn get ruta => text().nullable()();
  TextColumn get url => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime).nullable()();
}
