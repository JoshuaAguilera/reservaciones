import 'package:drift/drift.dart';

class ClienteTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().nullable()();
  TextColumn get apellido => text().nullable()();
  TextColumn get numeroTelefonico => text().nullable()();
  TextColumn get correoElectronico => text().nullable()();
  TextColumn get nacionalidad =>
      text().withDefault(const Variable("Mexicana")).nullable()();
  TextColumn get estado => text().nullable()();
  TextColumn get ciudad => text().nullable()();
  TextColumn get cp => text().nullable()();
  TextColumn get notas => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime).nullable()();
}
