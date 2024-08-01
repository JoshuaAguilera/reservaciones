import 'dart:io';
import 'package:drift/native.dart';
import 'package:generador_formato/database/tables/quote_group_table.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

import 'tables/quote_table.dart';
import 'tables/receipt_quotes_table.dart';
import 'tables/user_table.dart';
part 'database.g.dart';

// @DriftDatabase(tables: [Users, ReceiptQuote, Quote, QuoteGroup])
// class AppDatabase extends _$AppDatabase {}

@DriftDatabase(tables: [
  Users,
  ReceiptQuote,
  Quote,
  QuoteGroup,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<QuoteData>> getQuotesIndbyFolio(String folioQuotes) {
    return (select(quote)..where((t) => t.folio.equals(folioQuotes))).get();
  }

  Future<List<QuoteGroupData>> getQuotesGroupbyFolio(String folioQuotes) {
    return (select(quoteGroup)..where((t) => t.folio.equals(folioQuotes)))
        .get();
  }

  Future<List<ReceiptQuoteData>> getReceiptQuotesSearch(String search) {
    return (select(receiptQuote)..where((t) => t.nameCustomer.contains(search)))
        .get();
  }

  Future<List<ReceiptQuoteData>> getReceiptQuotesLastDay({String search = ""}) {
    if (search.isEmpty) {
      return (select(receiptQuote)
            ..where(
              (t) => t.dateRegister.isBetweenValues(
                DateTime.now().subtract(const Duration(days: 1)),
                DateTime.now(),
              ),
            ))
          .get();
    } else {
      return (select(receiptQuote)
            ..where((t) => t.nameCustomer.contains(search))
            ..where((t) => t.dateRegister.isBetweenValues(
                DateTime.now().subtract(const Duration(days: 1)),
                DateTime.now())))
          .get();
    }
  }

  Future<List<ReceiptQuoteData>> getReceiptQuotesLastWeek(
      {String search = ""}) {
    if (search.isEmpty) {
      return (select(receiptQuote)
            ..where((t) => t.dateRegister.isBetweenValues(
                DateTime.now().subtract(const Duration(days: 7)),
                DateTime.now())))
          .get();
    } else {
      return (select(receiptQuote)
            ..where((t) => t.nameCustomer.contains(search))
            ..where((t) => t.dateRegister.isBetweenValues(
                DateTime.now().subtract(const Duration(days: 7)),
                DateTime.now())))
          .get();
    }
  }

  Future<List<ReceiptQuoteData>> getReceiptQuotesLastMont(
      {String search = ""}) {
    if (search.isEmpty) {
      return (select(receiptQuote)
            ..where((t) => t.dateRegister.isBetweenValues(
                DateTime.now().subtract(const Duration(days: 30)),
                DateTime.now())))
          .get();
    } else {
      return (select(receiptQuote)
            ..where((t) => t.nameCustomer.contains(search))
            ..where((t) => t.dateRegister.isBetweenValues(
                DateTime.now().subtract(const Duration(days: 30)),
                DateTime.now())))
          .get();
    }
  }

  Future<List<ReceiptQuoteData>> getReceiptQuotesTimePeriod(
      DateTime initTime, DateTime lastTime,
      {String search = ""}) {
    if (search.isEmpty) {
      return (select(receiptQuote)
            ..where((t) => t.dateRegister.isBetweenValues(
                  initTime,
                  lastTime,
                )))
          .get();
    } else {
      return (select(receiptQuote)
            ..where((t) => t.nameCustomer.contains(search))
            ..where((t) => t.dateRegister.isBetweenValues(
                  initTime,
                  lastTime,
                )))
          .get();
    }
  }

  Future<List<QuoteData>> getQuotesIndToday() {
    return (select(quote)
          ..where(
            (t) => t.registerDate.isBetweenValues(
              DateTime.parse(DateTime.now().toIso8601String().substring(0, 10)),
              DateTime.now(),
            ),
          ))
        .get();
  }

  Future<List<QuoteGroupData>> getQuotesGroupToday() {
    return (select(quoteGroup)
          ..where(
            (t) => t.registerDate.isBetweenValues(
              DateTime.parse(DateTime.now().toIso8601String().substring(0, 10)),
              DateTime.now(),
            ),
          ))
        .get();
  }

  Future<List<ReceiptQuoteData>> getReceiptQuotesRecent() {
    return (select(receiptQuote)
          ..orderBy([
            (t) => OrderingTerm(
                expression: t.dateRegister, mode: OrderingMode.desc)
          ]))
        .get();
  }

  Future<List<QuoteData>> getQuotesIndTimePeriod(
    DateTime initTime,
    DateTime lastTime,
  ) {
    return (select(quote)
          ..where((t) => t.registerDate.isBetweenValues(
                initTime,
                lastTime,
              )))
        .get();
  }

  Future<List<QuoteGroupData>> getQuotesGroupTimePeriod(
    DateTime initTime,
    DateTime lastTime,
  ) {
    return (select(quoteGroup)
          ..where((t) => t.registerDate.isBetweenValues(
                initTime,
                lastTime,
              )))
        .get();
  }

  Future deleteReceiptQuoteByFolio(String folio) {
    return (delete(receiptQuote)..where((t) => t.folioQuotes.equals(folio)))
        .go();
  }

  Future deleteQuotesByFolio(String folio) {
    return (delete(quote)..where((t) => t.folio.equals(folio))).go();
  }

  Future<List<QuoteData>> getHistoryQuotesInd() {
    return (select(quote)).get();
  }

  Future<List<QuoteGroupData>> getHistoryQuotesGroup() {
    return (select(quoteGroup)).get();
  }

  //USER SECCION
  Future<List<User>> foundUserByName(String userName) async {
    return await (select(users)..where((t) => t.name.equals(userName))).get();
  }

  Future<List<User>> loginUser(String userName, String password) async {
    return await (select(users)
          ..where((t) => t.name.equals(userName))
          ..where(
            (tbl) => tbl.password.equals(password),
          ))
        .get();
  }

  Future<int> updateInfoUser(User usuario) {
    return (update(users)..where((t) => t.id.equals(usuario.id)))
        .write(usuario);
  }

  Future<int> updatePasswordUser(int userId, String newPassword) {
    return (update(users)..where((t) => t.id.equals(userId)))
        .write(User(id: userId, password: newPassword));
  }

   Future<int> updatePasswordMailUser(int userId, String newPassword) {
    return (update(users)..where((t) => t.id.equals(userId)))
        .write(User(id: userId, passwordMail: newPassword));
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
