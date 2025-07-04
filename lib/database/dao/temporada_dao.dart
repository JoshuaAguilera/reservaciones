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
  Future<Temporada?> insert(Temporada temporada) async {
    var response = await into(db.temporadaTable).insertReturningOrNull(
      TemporadaTableData.fromJson(
        temporada.toJson(),
      ),
    );

    if (response == null) return null;
    final newSeason = Temporada.fromJson(response.toJson());
    return newSeason;
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
  Future<Temporada?> updat3(Temporada temporada) async {
    var response = await update(db.temporadaTable).replace(
      TemporadaTableData.fromJson(
        temporada.toJson(),
      ),
    );

    if (!response) return null;
    return await getByID(temporada.idInt ?? 0);
  }

  // SAVE
  Future<Temporada?> save(Temporada temporada) async {
    if (temporada.idInt == null || temporada.idInt == 0) {
      return await insert(temporada);
    } else {
      return await updat3(temporada);
    }
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
