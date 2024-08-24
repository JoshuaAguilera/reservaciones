import 'package:drift/drift.dart';

class Periodo extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text()();
  DateTimeColumn get fecha => dateTime().nullable()();
  DateTimeColumn get fechaInicial => dateTime().nullable()();
  DateTimeColumn get fechaFinal => dateTime().nullable()();
  BoolColumn get enLunes => boolean().nullable()();
  BoolColumn get enMartes => boolean().nullable()();
  BoolColumn get enMiercoles => boolean().nullable()();
  BoolColumn get enJueves => boolean().nullable()();
  BoolColumn get enViernes => boolean().nullable()();
  BoolColumn get enSabado => boolean().nullable()();
  BoolColumn get enDomingo => boolean().nullable()();
}
