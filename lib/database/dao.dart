import 'package:drift/drift.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/database/tables/receipt_quotes_table.dart';

part 'database.g.dart';

// the _TodosDaoMixin will be created by drift. It contains all the necessary
// fields for the tables. The <MyDatabase> type annotation is the database class
// that should use this dao.
@DriftAccessor(tables: [ReceiptQuoteTable])
class ReceiptQuoteDao extends DatabaseAccessor<AppDatabase> with _$TodosDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  ReceiptQuoteDao(AppDatabase db) : super(db);

}

/*


@DriftAccessor(tables: [Movies])
class MoviesDao extends DatabaseAccessor<AppDatabase> with _$MoviesDaoMixin {
  MoviesDao(super.db);
  Future<int> add(entity) {
    return into(movies).insert(entity);
  }
  Future addAll(List<Movie> entities) {
    return batch((batch) => batch.insertAll(movies, entities));
  }
  Future<Movie?> findById(int id) {
    return (select(movies)
          ..where((tbl) => tbl.id.equals(id))
          ..limit(1))
        .getSingleOrNull();
  }
  Stream<List<Movie>> getAll() {
    return select(movies).watch();
  }
  Future<List<Movie>> getAllAsFuture({String? filter}) {
    return select(movies).get();
  }
  Future remove(int id) {
    return (delete(movies)..where((tbl) => tbl.id.equals(id))).go();
  }
  Future removeAll() {
    return delete(movies).go();
  }
  Future updateMovie(entity) {
    return (update(movies).replace(entity));
  }
}
*/