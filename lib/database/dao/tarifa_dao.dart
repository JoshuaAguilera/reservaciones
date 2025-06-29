import 'package:drift/drift.dart';

import '../../models/categoria_model.dart';
import '../../models/tarifa_base_model.dart';
import '../../models/tarifa_model.dart';
import '../database.dart';
import '../tables/tarifa_table.dart';

part 'tarifa_dao.g.dart';

@DriftAccessor(tables: [TarifaTable])
class TarifaDao extends DatabaseAccessor<AppDatabase> with _$TarifaDaoMixin {
  TarifaDao(AppDatabase db) : super(db);

  var mapEmpty = <String, dynamic>{};

  // LIST
  Future<List<Tarifa>> getList({
    int? tarifaBaseId,
    int? categoriaId,
    DateTime? initDate,
    DateTime? lastDate,
    String sortBy = 'created_at',
    String order = 'asc',
    int limit = 20,
    int page = 1,
    bool conDetalle = false,
  }) async {
    final baseAlias = alias(db.tarifaBaseTable, 'base');
    final categoriaAlias = alias(db.categoriaTable, 'categoria');

    final query = select(db.tarifaTable).join([
      if (conDetalle)
        leftOuterJoin(
          baseAlias,
          baseAlias.idInt.equalsExp(db.tarifaTable.tarifaBaseInt),
        ),
      leftOuterJoin(
        categoriaAlias,
        categoriaAlias.idInt.equalsExp(db.tarifaTable.categoriaInt),
      ),
    ]);

    if (tarifaBaseId != null) {
      query.where(db.tarifaTable.tarifaBaseInt.equals(tarifaBaseId));
    }

    if (categoriaId != null) {
      query.where(db.tarifaTable.categoriaInt.equals(categoriaId));
    }

    if (initDate != null) {
      query.where(db.tarifaTable.createdAt.isBiggerOrEqualValue(initDate));
    }

    if (lastDate != null) {
      query.where(db.tarifaTable.createdAt.isSmallerOrEqualValue(lastDate));
    }

    if (initDate != null && lastDate != null) {
      query.where(
        db.tarifaTable.createdAt.isBetweenValues(initDate, lastDate),
      );
    }

    OrderingTerm? ordering;

    switch (sortBy) {
      case 'created_at':
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.tarifaTable.createdAt)
            : OrderingTerm.asc(db.tarifaTable.createdAt);
        break;
      default:
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.tarifaTable.idInt)
            : OrderingTerm.asc(db.tarifaTable.idInt);
    }

    query.orderBy([ordering]);

    final offset = (page - 1) * limit;
    query.limit(limit, offset: offset);

    final rows = await query.get();

    // Mapear resultados con joins
    return rows.map((row) {
      final tarifa = row.readTable(db.tarifaTable);
      final base = row.readTableOrNull(baseAlias);
      final categoria = row.readTableOrNull(categoriaAlias);

      return Tarifa(
        idInt: tarifa.idInt,
        id: tarifa.id,
        tarifaAdulto1a2: tarifa.tarifaAdulto1a2,
        tarifaAdulto3: tarifa.tarifaAdulto3,
        tarifaAdulto4: tarifa.tarifaAdulto4,
        tarifaMenores0a6: tarifa.tarifaMenores0a6,
        tarifaMenores7a12: tarifa.tarifaMenores7a12,
        tarifaPaxAdicional: tarifa.tarifaPaxAdicional,
        createdAt: tarifa.createdAt,
        categoria: Categoria.fromJson(categoria?.toJson() ?? mapEmpty),
        tarifaBase: TarifaBase.fromJson(base?.toJson() ?? mapEmpty),
      );
    }).toList();
  }

  // CREATE
  Future<int> insert(Tarifa tarifa) {
    return into(db.tarifaTable).insert(
      TarifaTableData.fromJson(
        tarifa.toJson(),
      ),
    );
  }

  // READ: Tarifa por ID
  Future<Tarifa?> getByID(int id) async {
    final baseAlias = alias(db.tarifaBaseTable, 'base');
    final categoriaAlias = alias(db.categoriaTable, 'categoria');

    final query = select(db.tarifaTable).join([
      leftOuterJoin(
        baseAlias,
        baseAlias.idInt.equalsExp(db.tarifaTable.tarifaBaseInt),
      ),
      leftOuterJoin(
        categoriaAlias,
        categoriaAlias.idInt.equalsExp(db.tarifaTable.categoriaInt),
      ),
    ]);

    query.where(db.tarifaTable.idInt.equals(id));
    var row = await query.getSingleOrNull();
    if (row == null) return null;
    final tarifa = row.readTable(db.tarifaTable);
    final base = row.readTableOrNull(baseAlias);
    final categoria = row.readTableOrNull(categoriaAlias);

    return Tarifa(
      idInt: tarifa.idInt,
      id: tarifa.id,
      tarifaAdulto1a2: tarifa.tarifaAdulto1a2,
      tarifaAdulto3: tarifa.tarifaAdulto3,
      tarifaAdulto4: tarifa.tarifaAdulto4,
      tarifaMenores0a6: tarifa.tarifaMenores0a6,
      tarifaMenores7a12: tarifa.tarifaMenores7a12,
      tarifaPaxAdicional: tarifa.tarifaPaxAdicional,
      createdAt: tarifa.createdAt,
      categoria: Categoria.fromJson(categoria?.toJson() ?? mapEmpty),
      tarifaBase: TarifaBase.fromJson(base?.toJson() ?? mapEmpty),
    );
  }

  // UPDATE
  Future<bool> updat3(Tarifa tarifa) {
    var response = update(db.tarifaTable).replace(
      TarifaTableData.fromJson(
        tarifa.toJson(),
      ),
    );

    return response;
  }

  // DELETE
  Future<int> delet3(int id) {
    var response = (delete(db.tarifaTable)
          ..where((u) {
            return u.idInt.equals(id);
          }))
        .go();

    return response;
  }

  // Future<int> updateForBaseTariff({
  //   required TarifaTableCompanion tarifaData,
  //   required int baseTariffId,
  //   required int id,
  // }) {
  //   return (update(tarifaTable)
  //         ..where((tbl) => tbl.tarifaPadreId.equals(baseTariffId))
  //         ..where((tbl) => tbl.id.equals(id)))
  //       .write(tarifaData);
  // }

  // Future<int> removeBaseTariff(int tarifaBaseId) {
  //   return (update(tarifaTable)
  //         ..where((t) => t.tarifaPadreId.equals(tarifaBaseId)))
  //       .write(
  //     const TarifaTableCompanion(tarifaPadreId: Value(null)),
  //   );
  // }
}
