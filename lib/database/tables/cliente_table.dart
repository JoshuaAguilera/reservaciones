import 'package:drift/drift.dart';

class ClienteTable extends Table {
  IntColumn get idInt => integer().autoIncrement()();
  TextColumn get id => text().nullable()();
  TextColumn get nombres => text().nullable()();
  TextColumn get apellidos => text().nullable()();
  TextColumn get numeroTelefonico => text().nullable()();
  TextColumn get correoElectronico => text().nullable()();
  TextColumn get pais =>
      text().withDefault(const Variable("Mexico")).nullable()();
  TextColumn get estado => text().nullable()();
  TextColumn get ciudad => text().nullable()();
  TextColumn get direccion => text().nullable()();
  TextColumn get notas => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime).nullable()();
}
