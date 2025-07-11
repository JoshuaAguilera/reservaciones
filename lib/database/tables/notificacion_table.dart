import 'package:drift/drift.dart';
import 'package:generador_formato/database/tables/usuario_table.dart';

class NotificacionTable extends Table {
  IntColumn get idInt => integer().autoIncrement()();
  TextColumn get id => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime).nullable()();
  TextColumn get mensaje => text().nullable()();
  TextColumn get tipo => text().nullable()();
  TextColumn get documento => text().nullable()();
  TextColumn get estatus => text().withDefault(const Variable("enviado"))();
  TextColumn get ruta => text().nullable()();
  IntColumn get usuarioInt =>
      integer().nullable().references(UsuarioTable, #id)();
  TextColumn get usuario => text().nullable()();
}
