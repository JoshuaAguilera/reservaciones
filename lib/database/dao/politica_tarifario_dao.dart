import 'package:drift/drift.dart';

import '../../models/politica_tarifario_model.dart';
import '../../models/usuario_model.dart';
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
    String clave = '',
    int? creadorId,
    DateTime? initDate,
    DateTime? lastDate,
    String? sortBy,
    String order = 'asc',
    int limit = 20,
    int page = 1,
  }) async {
    final creadorAlias = alias(db.usuarioTable, 'creador');

    final query = select(db.politicaTarifarioTable).join([
      leftOuterJoin(
        creadorAlias,
        creadorAlias.idInt.equalsExp(db.politicaTarifarioTable.creadoPorInt),
      ),
    ]);

    if (creadorId != null) {
      query.where(db.politicaTarifarioTable.creadoPorInt.equals(creadorId));
    }

    if (descripcion.isNotEmpty) {
      query.where(db.politicaTarifarioTable.descripcion
          .lower()
          .like('%${descripcion.toLowerCase()}%'));
    }

    if (initDate != null) {
      query.where(
          db.politicaTarifarioTable.createdAt.isBiggerOrEqualValue(initDate));
    }

    if (lastDate != null) {
      query.where(
          db.politicaTarifarioTable.createdAt.isSmallerOrEqualValue(lastDate));
    }

    if (initDate != null && lastDate != null) {
      query.where(
        db.politicaTarifarioTable.createdAt.isBetweenValues(initDate, lastDate),
      );
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

    query.orderBy([ordering]);

    final offset = (page - 1) * limit;
    query.limit(limit, offset: offset);

    final rows = await query.get();

    return rows.map(
      (row) {
        final politica = row.readTable(db.politicaTarifarioTable);
        final creador = row.readTableOrNull(creadorAlias);

        return PoliticaTarifario(
          idInt: politica.idInt,
          id: politica.id,
          clave: politica.clave,
          descripcion: politica.descripcion,
          createdAt: politica.createdAt,
          valor: politica.valor,
          updatedAt: politica.updatedAt,
          creadoPor: Usuario.fromJson(
            creador?.toJson() ?? mapEmpty,
          ),
        );
      },
    ).toList();
  }

  // CREATE
  Future<PoliticaTarifario?> insert(PoliticaTarifario politica) async {
    var response = await into(db.politicaTarifarioTable).insertReturningOrNull(
      PoliticaTarifarioTableData.fromJson(
        politica.toJson(),
      ),
    );

    if (response == null) return null;
    return PoliticaTarifario.fromJson(response.toJson());
  }

  // READ: Politica Tarifario por ID
  Future<PoliticaTarifario?> getByID(int id) async {
    final creadorAlias = alias(db.usuarioTable, 'creador');

    final query = select(db.politicaTarifarioTable).join([
      leftOuterJoin(
        creadorAlias,
        creadorAlias.idInt.equalsExp(db.politicaTarifarioTable.creadoPorInt),
      ),
    ]);

    query.where(db.politicaTarifarioTable.idInt.equals(id));
    var row = await query.getSingleOrNull();
    if (row == null) return null;
    final politica = row.readTable(db.politicaTarifarioTable);
    final creador = row.readTableOrNull(creadorAlias);
    
    return PoliticaTarifario(
      idInt: politica.idInt,
      id: politica.id,
      clave: politica.clave,
      descripcion: politica.descripcion,
      createdAt: politica.createdAt,
      valor: politica.valor,
      updatedAt: politica.updatedAt,
      creadoPor: Usuario.fromJson(
        creador?.toJson() ?? mapEmpty,
      ),
    );
  }

  // UPDATE
  Future<PoliticaTarifario?> updat3(PoliticaTarifario politica) async {
    var response = await update(db.politicaTarifarioTable).replace(
      PoliticaTarifarioTableData.fromJson(
        politica.toJson(),
      ),
    );

    if (!response) return null;
    return await getByID(politica.idInt ?? 0);
  }

  // SAVE
  Future<PoliticaTarifario?> save(PoliticaTarifario politica) async {
    if (politica.idInt == null) {
      return await insert(politica);
    } else {
      return await updat3(politica);
    }
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
