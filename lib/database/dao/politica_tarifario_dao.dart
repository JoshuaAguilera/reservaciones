import 'package:drift/drift.dart';

import '../../models/politica_tarifario_model.dart';
import '../database.dart';
import '../tables/politica_tarifario_table.dart';

part 'politica_tarifario_dao.g.dart';

@DriftAccessor(tables: [PoliticaTarifarioTable])
class PoliticaTarifarioDao extends DatabaseAccessor<AppDatabase>
    with _$PoliticaTarifarioDaoMixin {
  PoliticaTarifarioDao(AppDatabase db) : super(db);

  var mapEmpty = <String, dynamic>{};

  // LIST
  Future<List<PoliticaTarifario>> getList({
    String descripcion = '',
    DateTime? initDate,
    DateTime? lastDate,
    String? sortBy,
    String order = 'asc',
    int limit = 20,
    int page = 1,
  }) async {
    final query = select(db.politicaTarifarioTable);

    if (descripcion.isNotEmpty) {
      query.where((u) => u.descripcion.like('%$descripcion%'));
    }

    if (initDate != null) {
      query.where((u) => u.createdAt.isBiggerOrEqualValue(initDate));
    }

    if (lastDate != null) {
      query.where((u) => u.createdAt.isSmallerOrEqualValue(lastDate));
    }

    OrderingTerm? ordering;

    switch (sortBy) {
      case 'clave':
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.politicaTarifarioTable.clave)
            : OrderingTerm.asc(db.politicaTarifarioTable.clave);
        break;
      case 'createdAt':
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.politicaTarifarioTable.createdAt)
            : OrderingTerm.asc(db.politicaTarifarioTable.createdAt);
        break;
      case 'updatedAt':
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.politicaTarifarioTable.updatedAt)
            : OrderingTerm.asc(db.politicaTarifarioTable.updatedAt);
        break;
      default:
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.politicaTarifarioTable.idInt)
            : OrderingTerm.asc(db.politicaTarifarioTable.idInt);
    }

    query.orderBy([(_) => ordering!]);

    final offset = (page - 1) * limit;
    query.limit(limit, offset: offset);

    final data = await query.get();

    return data.map(
      (e) {
        PoliticaTarifario policy = PoliticaTarifario.fromJson(e.toJson());
        return policy;
      },
    ).toList();
  }

  // CREATE
  Future<int> insert(PoliticaTarifario politica) {
    var response = into(db.politicaTarifarioTable).insert(
      PoliticaTarifarioTableData.fromJson(
        politica.toJson(),
      ),
    );

    return response;
  }

  // READ: Politica Tarifario por ID
  Future<PoliticaTarifario?> getByID(int id) async {
    var response = await (select(db.politicaTarifarioTable)
          ..where((u) {
            return u.idInt.equals(id);
          }))
        .getSingleOrNull();

    return PoliticaTarifario?.fromJson(
        response?.toJson() ?? <String, dynamic>{});
  }

  // UPDATE
  Future<bool> updat3(PoliticaTarifario politica) {
    var response = update(db.politicaTarifarioTable).replace(
      PoliticaTarifarioTableData.fromJson(
        politica.toJson(),
      ),
    );

    return response;
  }

  // DELETE
  Future<int> delet3(int id) {
    var response = (delete(db.politicaTarifarioTable)
          ..where((u) {
            return u.idInt.equals(id);
          }))
        .go();

    return response;
  }
}
