import 'package:drift/drift.dart';

import '../../models/temporada_model.dart';
import '../database.dart';
import '../tables/temporada_table.dart';

part 'temporada_dao.g.dart';

@DriftAccessor(tables: [TemporadaTable])
class TemporadaDao extends DatabaseAccessor<AppDatabase>
    with _$TemporadaDaoMixin {
  TemporadaDao(AppDatabase db) : super(db);

  // LIST
  Future<List<Temporada>> getList({
    int? tarifaRackId,
    int limit = 20,
    int page = 1,
  }) async {
    final query = select(db.temporadaTable);

    if (tarifaRackId != null) {
      query.where((u) => u.tarifaRackInt.equals(tarifaRackId));
    }

    final offset = (page - 1) * limit;
    query.limit(limit, offset: offset);

    final data = await query.get();

    return data.map(
      (e) {
        Temporada season = Temporada.fromJson(e.toJson());
        return season;
      },
    ).toList();
  }

  // CREATE
  Future<int> insert(Temporada temporada) {
    var response = into(db.temporadaTable).insert(
      TemporadaTableData.fromJson(
        temporada.toJson(),
      ),
    );

    return response;
  }

  // READ: Temporada por ID
  Future<Temporada?> getByID(int id) async {
    var response = await (select(db.temporadaTable)
          ..where((u) {
            return u.idInt.equals(id);
          }))
        .getSingleOrNull();

    return Temporada?.fromJson(response?.toJson() ?? <String, dynamic>{});
  }

  // UPDATE
  Future<bool> updat3(Temporada temporada) {
    var response = update(db.temporadaTable).replace(
      TemporadaTableData.fromJson(
        temporada.toJson(),
      ),
    );

    return response;
  }

  // DELETE
  Future<int> delet3(int id) {
    var response = (delete(db.temporadaTable)
          ..where((u) {
            return u.idInt.equals(id);
          }))
        .go();

    return response;
  }
}
