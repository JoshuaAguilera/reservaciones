import 'dart:io';
import 'package:drift/native.dart';
import 'package:generador_formato/helpers/utility.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

import 'tables/quote_table.dart';
import 'tables/receipt_quotes_table.dart';
import 'tables/user_table.dart';
part 'database.g.dart';

// @DriftDatabase(tables: [Users, RolUser, ReceiptQuote, Quote])
// class AppDatabase extends _$AppDatabase {}

@DriftDatabase(tables: [
  Users,
  RolUser,
  ReceiptQuote,
  Quote,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<QuoteData>> getQuotesbyFolio(String folioQuotes) {
    return (select(quote)..where((t) => t.folio.equals(folioQuotes))).get();
  }

  Future<List<ReceiptQuoteData>> getReceiptQuotesSearch(String search) {
    return (select(receiptQuote)..where((t) => t.nameCustomer.contains(search)))
        .get();
  }

  Future<List<ReceiptQuoteData>> getReceiptQuotesLastDay() {
    return (select(receiptQuote)
          ..where((t) => t.dateRegister.isBetweenValues(
              DateTime.now().subtract(const Duration(days: 1)),
              DateTime.now())))
        .get();
  }

  Future<List<ReceiptQuoteData>> getReceiptQuotesLastWeek() {
    return (select(receiptQuote)
          ..where((t) => t.dateRegister.isBetweenValues(
              DateTime.now().subtract(const Duration(days: 7)),
              DateTime.now())))
        .get();
  }

  Future<List<ReceiptQuoteData>> getReceiptQuotesLastMont() {
    return (select(receiptQuote)
          ..where((t) => t.dateRegister.isBetweenValues(
              DateTime.now().subtract(const Duration(days: 30)),
              DateTime.now())))
        .get();
  }

  Future deleteReceiptQuoteByFolio(String folio) {
    return (delete(receiptQuote)..where((t) => t.folioQuotes.equals(folio)))
        .go();
  }

  Future deleteQuotesByFolio(String folio) {
    return (delete(quote)..where((t) => t.folio.equals(folio))).go();
  }
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
