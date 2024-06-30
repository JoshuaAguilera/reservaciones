import 'dart:io';
import 'package:drift/native.dart';
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

/*
class FeedDatabase extends _$FeedDatabase {
  // we tell the database where to store the data with this constructor
  FeedDatabase._internal()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: 'feed.db'));

  static FeedDatabase _instance = FeedDatabase._internal();

  factory FeedDatabase() => _instance;
  @override
  int get schemaVersion => 1;
}
*/

@DriftDatabase(tables: [UsersTable, RolUserTable, ReceiptQuoteTable, QuoteTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<QuoteData>> getQuotesbyFolio(String folioQuotes) {
    return (select(quote)..where((t) => t.folio.equals(folioQuotes))).get();
  }

  Stream<List<ReceiptQuoteData>> getReceiptQuotesByCustomer(
      String nameCustomer) {
    return (select(receiptQuote)
          ..where((t) => t.nameCustomer.equals(nameCustomer)))
        .watch();
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
