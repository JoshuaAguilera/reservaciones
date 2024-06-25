import 'dart:io';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
part 'database.g.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get password => text()();
  IntColumn get rol => integer().nullable().references(RolUser, #id)();
}

class RolUser extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text()();
}

class ReceiptQuote extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nameCustomer => text()();
  TextColumn get numPhone => text()();
  TextColumn get mail => text()();
  TextColumn get folioQuotes => text()();
  IntColumn get userId => integer()();
}

class Quote extends Table {
  //Cotizacion individual
  IntColumn get id => integer().autoIncrement()();
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

// @DriftDatabase(tables: [Users, RolUser, ReceiptQuote, Quote])
// class AppDatabase extends _$AppDatabase {}

@DriftDatabase(tables: [Users, RolUser, ReceiptQuote, Quote])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'dbReservaciones.sqlite'));

    // Also work around limitations on old Android versions
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    // Make sqlite3 pick a more suitable location for temporary files - the
    // one from the system may be inaccessible due to sandboxing.
    final cachebase = (await getTemporaryDirectory()).path;
    // We can't access /tmp on Android, which sqlite3 would try by default.
    // Explicitly tell it about the correct temporary directory.
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
