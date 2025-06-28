import 'package:drift/drift.dart';

import '../../models/tarifa_base_model.dart';
import '../../models/usuario_model.dart';
import '../database.dart';
import '../tables/tarifa_base_table.dart';
import '../tables/tarifa_table.dart';

part 'tarifa_base_dao.g.dart';

@DriftAccessor(tables: [TarifaBaseTable, TarifaTable])
class TarifaBaseDao extends DatabaseAccessor<AppDatabase>
    with _$TarifaBaseDaoMixin {
  TarifaBaseDao(AppDatabase db) : super(db);

  var mapEmpty = <String, dynamic>{};

  // LIST
  Future<List<TarifaBase>> getList({
    String nombre = '',
    String codigo = '',
    int? tarifaBaseId,
    int? creadorId,
    DateTime? initDate,
    DateTime? lastDate,
    String? sortBy,
    String order = 'asc',
    int limit = 20,
    int page = 1,
    bool conDetalle = false,
  }) async {
    final baseAlias = alias(db.tarifaBaseTable, 'base');
    final creadorAlias = alias(db.usuarioTable, 'creador');

    final query = select(db.tarifaBaseTable).join([
      if (conDetalle)
        leftOuterJoin(
          baseAlias,
          baseAlias.idInt.equalsExp(db.tarifaBaseTable.tarifaBaseInt),
        ),
      leftOuterJoin(
        creadorAlias,
        creadorAlias.idInt.equalsExp(db.tarifaBaseTable.creadoPorInt),
      ),
    ]);

    if (tarifaBaseId != null) {
      query.where(db.tarifaBaseTable.tarifaBaseInt.equals(tarifaBaseId));
    }

    if (creadorId != null) {
      query.where(db.tarifaBaseTable.creadoPorInt.equals(creadorId));
    }

    if (codigo.isNotEmpty) {
      final value = '%${codigo.toLowerCase()}%';
      query.where(db.tarifaBaseTable.codigo.lower().like(value));
    }

    if (nombre.isNotEmpty) {
      final value = '%${nombre.toLowerCase()}%';
      query.where(db.tarifaBaseTable.nombre.lower().like(value));
    }

    if (initDate != null) {
      query.where(db.tarifaBaseTable.createdAt.isBiggerOrEqualValue(initDate));
    }

    if (lastDate != null) {
      query.where(db.tarifaBaseTable.createdAt.isSmallerOrEqualValue(lastDate));
    }

    if (initDate != null && lastDate != null) {
      query.where(
        db.tarifaBaseTable.createdAt.isBetweenValues(initDate, lastDate),
      );
    }

    OrderingTerm? ordering;

    switch (sortBy) {
      case 'nombre':
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.tarifaBaseTable.nombre)
            : OrderingTerm.asc(db.tarifaBaseTable.nombre);
        break;
      case 'createdAt':
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.tarifaBaseTable.createdAt)
            : OrderingTerm.asc(db.tarifaBaseTable.createdAt);
        break;
      default:
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.tarifaBaseTable.idInt)
            : OrderingTerm.asc(db.tarifaBaseTable.idInt);
    }

    query.orderBy([ordering]);

    final offset = (page - 1) * limit;
    query.limit(limit, offset: offset);

    final rows = await query.get();

    return rows.map(
      (row) {
        final tarifa = row.readTable(db.tarifaBaseTable);
        final base = row.readTableOrNull(baseAlias);
        final creador = row.readTableOrNull(creadorAlias);

        return TarifaBase(
          idInt: tarifa.idInt,
          id: tarifa.id,
          nombre: tarifa.nombre,
          aumIntegrado: tarifa.aumentoIntegrado,
          codigo: tarifa.codigo,
          conAutocalculacion: tarifa.conAutocalculacion,
          upgradeCategoria: tarifa.upgradeCategoria,
          upgradeMenor: tarifa.upgradeMenor,
          upgradePaxAdic: tarifa.upgradePaxAdic,
          tarifaBase: TarifaBase.fromJson(base?.toJson() ?? mapEmpty),
          creadoPor: Usuario.fromJson(creador?.toJson() ?? mapEmpty),
        );
      },
    ).toList();
  }

  // CREATE
  Future<int> insert(TarifaBase tarifa) {
    var response = into(db.tarifaBaseTable).insert(
      TarifaBaseTableData.fromJson(
        tarifa.toJson(),
      ),
    );

    return response;
  }

  // READ: TarifaBase por ID
  Future<TarifaBase?> getByID(int id) async {
    final baseAlias = alias(db.tarifaBaseTable, 'base');
    final creadorAlias = alias(db.usuarioTable, 'creador');

    final query = select(db.tarifaBaseTable).join([
      leftOuterJoin(
        baseAlias,
        baseAlias.idInt.equalsExp(db.tarifaBaseTable.tarifaBaseInt),
      ),
      leftOuterJoin(
        creadorAlias,
        creadorAlias.idInt.equalsExp(db.tarifaBaseTable.creadoPorInt),
      ),
    ]);

    query.where(db.tarifaBaseTable.idInt.equals(id));
    var row = await query.getSingleOrNull();
    if (row == null) return null;
    final tarifa = row.readTable(db.tarifaBaseTable);
    final base = row.readTableOrNull(baseAlias);
    final creador = row.readTableOrNull(creadorAlias);

    return TarifaBase(
      idInt: tarifa.idInt,
      id: tarifa.id,
      nombre: tarifa.nombre,
      aumIntegrado: tarifa.aumentoIntegrado,
      codigo: tarifa.codigo,
      conAutocalculacion: tarifa.conAutocalculacion,
      upgradeCategoria: tarifa.upgradeCategoria,
      upgradeMenor: tarifa.upgradeMenor,
      upgradePaxAdic: tarifa.upgradePaxAdic,
      tarifaBase: TarifaBase.fromJson(base?.toJson() ?? mapEmpty),
      creadoPor: Usuario.fromJson(creador?.toJson() ?? mapEmpty),
    );
  }

  // UPDATE
  Future<bool> updat3(TarifaBase tarifa) {
    var response = update(db.tarifaBaseTable).replace(
      TarifaBaseTableData.fromJson(
        tarifa.toJson(),
      ),
    );

    return response;
  }

  // DELETE
  Future<int> delet3(int id) {
    var response = (delete(db.tarifaBaseTable)
          ..where((u) {
            return u.idInt.equals(id);
          }))
        .go();

    return response;
  }

  // Future<int> propageChangesTariff(
  //     {required TarifaBaseTableData baseTariff,
  //     required List<tf.Tarifa> tarifasBase}) async {
  //   int tarifaId = baseTariff.id;
  //   final tarifaDao = TarifaDao(db);

  //   List<TarifaBase> _tariffs =
  //       await getBaseTariffComplement(tarifaPadreId: tarifaId);

  //   if (_tariffs.isNotEmpty) {
  //     for (var tarifaBase in _tariffs) {
  //       if ((tarifaBase.tarifas ?? []).isEmpty) {
  //         continue;
  //       }

  //       double divisor = tarifaBase.aumIntegrado ?? 1;

  //       for (var element in (tarifaBase.tarifas!)) {
  //         tf.Tarifa? selectTariff = await tarifasBase
  //             .where((elementInt) =>
  //                 elementInt.categoria == (element.categoria ?? ''))
  //             .firstOrNull;

  //         if (selectTariff == null) continue;

  //         element.tarifaAdulto4 = Utility.formatNumberRound(
  //             (selectTariff.tarifaAdulto4 ?? 0) / divisor);
  //         element.tarifaAdulto1a2 = Utility.formatNumberRound(
  //             (selectTariff.tarifaAdulto1a2 ?? 0) / divisor);
  //         element.tarifaAdulto3 = Utility.formatNumberRound(
  //             (selectTariff.tarifaAdulto3 ?? 0) / divisor);
  //         element.tarifaMenores7a12 = Utility.formatNumberRound(
  //             (selectTariff.tarifaMenores7a12 ?? 0) / divisor);

  //         await tarifaDao.updateForBaseTariff(
  //           tarifaData: TarifaTableCompanion(
  //             tarifaAdultoCPLE: Value(element.tarifaAdulto4),
  //             tarifaAdultoSGLoDBL: Value(element.tarifaAdulto1a2),
  //             tarifaAdultoTPL: Value(element.tarifaAdulto3),
  //             tarifaMenores7a12: Value(element.tarifaMenores7a12),
  //             tarifaPaxAdicional: Value(element.tarifaPaxAdicional),
  //           ),
  //           baseTariffId: tarifaBase.idInt!,
  //           id: element.id ?? 0,
  //         );
  //       }

  //       await propageChangesTariff(
  //         baseTariff: TarifaBaseTableData(
  //             id: tarifaBase.idInt!, descIntegrado: tarifaBase.aumIntegrado),
  //         tarifasBase: tarifaBase.tarifas ?? List<tf.Tarifa>.empty(),
  //       );
  //     }
  //   }

  //   tarifaDao.close();

  //   return tarifaId;
  // }

  // Future<int> removeOrigenTarifaId({required int? origenId}) {
  //   return (update(tarifaBaseTable)
  //         ..where((tbl) => tbl.tarifaOrigenId.equals(origenId!)))
  //       .write(
  //     const TarifaBaseTableCompanion(
  //       tarifaOrigenId: Value(null),
  //     ),
  //   );
  // }

  // Future<int> removePadreTarifaId({required int? padreId}) {
  //   return (update(tarifaBaseTable)
  //         ..where((tbl) => tbl.tarifaPadreId.equals(padreId!)))
  //       .write(
  //     const TarifaBaseTableCompanion(
  //       tarifaPadreId: Value(null),
  //       tarifaOrigenId: Value(null),
  //       descIntegrado: Value(null),
  //     ),
  //   );
  // }
}
