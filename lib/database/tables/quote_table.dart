
import 'package:drift/drift.dart';

class Quote extends Table {
  //Cotizacion individual
  IntColumn get id => integer().autoIncrement()();
  TextColumn get folio => text()();
  BoolColumn get isGroup => boolean()();
  TextColumn get category => text()();
  TextColumn get plan => text()();
  TextColumn get enterDate => text()();
  TextColumn get outDate => text()();
  IntColumn get adults => integer()();
  IntColumn get minor0a6 => integer()();
  IntColumn get minor7a12 => integer()();
  RealColumn get rateRealAdult => real()();
  RealColumn get ratePresaleAdult => real()();
  RealColumn get rateRealMinor => real()();
  RealColumn get ratePresaleMinor => real()();

  //cotizacion grupal
  // IntColumn get pax => integer()();
  // TextColumn get typeRoom => text()();
  // RealColumn get subtotal => real()();
  // TextColumn get rooms => text()();
}