import 'package:drift/drift.dart';

import '../../models/tarifa_rack_model.dart';
import '../../models/usuario_model.dart';
import '../../res/helpers/colors_helpers.dart';
import '../database.dart';
import '../tables/tarifa_rack_table.dart';

part 'tarifa_rack_dao.g.dart';

@DriftAccessor(tables: [TarifaRackTable])
class TarifaRackDao extends DatabaseAccessor<AppDatabase>
    with _$TarifaRackDaoMixin {
  TarifaRackDao(AppDatabase db) : super(db);

  // LIST
  Future<List<TarifaRack>> getList({
    String nombre = "",
    int? creadorId,
    DateTime? initDate,
    DateTime? lastDate,
    String sortBy = 'created_at',
    String order = 'asc',
    int limit = 20,
    int page = 1,
  }) async {
    final creadorAlias = alias(db.usuarioTable, 'creador');

    final query = select(db.tarifaRackTable).join([
      leftOuterJoin(
        creadorAlias,
        creadorAlias.idInt.equalsExp(db.tarifaRackTable.creadoPorInt),
      ),
    ]);

    if (creadorId != null) {
      query.where(db.tarifaRackTable.creadoPorInt.equals(creadorId));
    }

    if (nombre.isNotEmpty) {
      final value = '%${nombre.toLowerCase()}%';
      query.where(db.tarifaRackTable.nombre.lower().like(value));
    }

    if (initDate != null) {
      query.where(db.tarifaRackTable.createdAt.isBiggerOrEqualValue(initDate));
    }

    if (lastDate != null) {
      query.where(db.tarifaRackTable.createdAt.isSmallerOrEqualValue(lastDate));
    }

    if (initDate != null && lastDate != null) {
      query.where(
        db.tarifaRackTable.createdAt.isBetweenValues(initDate, lastDate),
      );
    }

    OrderingTerm orderingTerm;
    switch (sortBy) {
      case 'nombre':
        orderingTerm = order == 'desc'
            ? OrderingTerm.desc(db.tarifaRackTable.nombre)
            : OrderingTerm.asc(db.tarifaRackTable.nombre);
        break;
      case 'created_at':
        orderingTerm = order == 'desc'
            ? OrderingTerm.desc(db.tarifaRackTable.createdAt)
            : OrderingTerm.asc(db.tarifaRackTable.createdAt);
        break;
      default:
        orderingTerm = order == 'desc'
            ? OrderingTerm.desc(db.tarifaRackTable.id)
            : OrderingTerm.asc(db.tarifaRackTable.id);
    }

    query.orderBy([orderingTerm]);

    final offset = (page - 1) * limit;
    query.limit(limit, offset: offset);

    final rows = await query.get();

    return rows.map((row) {
      final rack = row.readTable(db.tarifaRackTable);
      final creador = row.readTableOrNull(creadorAlias);

      return TarifaRack(
        idInt: rack.idInt,
        id: rack.id,
        color: ColorsHelpers.colorFromJson(rack.color),
        nombre: rack.nombre,
        createdAt: rack.createdAt,
        creadoPor: Usuario.fromJson(creador?.toJson() ?? <String, dynamic>{}),
      );
    }).toList();
  }

  // CREATE
  Future<int> insert(TarifaRack tarifa) {
    var response = into(db.tarifaRackTable).insert(
      TarifaRackTableData.fromJson(
        tarifa.toJson(),
      ),
    );
    return response;
  }

  // READ: TarifaRack por ID
  Future<TarifaRack?> getByID(int id) async {
    final creadorAlias = alias(db.usuarioTable, 'creador');

    final query = select(db.tarifaRackTable).join([
      leftOuterJoin(
        creadorAlias,
        creadorAlias.idInt.equalsExp(db.tarifaRackTable.creadoPorInt),
      ),
    ]);

    query.where(
      db.tarifaRackTable.idInt.equals(id),
    );

    var row = await query.getSingleOrNull();
    if (row == null) return null;
    final rack = row.readTable(db.tarifaRackTable);
    final creador = row.readTableOrNull(creadorAlias);

    return TarifaRack(
      idInt: rack.idInt,
      id: rack.id,
      color: ColorsHelpers.colorFromJson(rack.color),
      nombre: rack.nombre,
      createdAt: rack.createdAt,
      creadoPor: Usuario.fromJson(creador?.toJson() ?? <String, dynamic>{}),
    );
  }

  // UPDATE
  Future<bool> updat3(TarifaRack tarifa) {
    var response = update(db.tarifaRackTable).replace(
      TarifaRackTableData.fromJson(
        tarifa.toJson(),
      ),
    );

    return response;
  }

  // DELETE
  Future<int> delet3(int id) {
    var response = (delete(db.tarifaRackTable)
          ..where(
            (u) {
              return u.idInt.equals(id);
            },
          ))
        .go();

    return response;
  }
}
