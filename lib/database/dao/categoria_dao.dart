import 'package:drift/drift.dart';

import '../../models/categoria_model.dart';
import '../../models/tipo_habitacion_model.dart';
import '../../models/usuario_model.dart';
import '../../res/helpers/colors_helpers.dart';
import '../database.dart';
import '../tables/categoria_table.dart';

part 'categoria_dao.g.dart';

@DriftAccessor(tables: [CategoriaTable])
class CategoriaDao extends DatabaseAccessor<AppDatabase>
    with _$CategoriaDaoMixin {
  CategoriaDao(AppDatabase db) : super(db);

  var mapEmpty = <String, dynamic>{};

  // LIST
  Future<List<Categoria>> getList({
    String nombre = '',
    String codigoHab = '',
    int? tipoHabId,
    int? creadorId,
    DateTime? initDate,
    DateTime? lastDate,
    String? sortBy,
    String order = 'asc',
    int limit = 20,
    int page = 1,
    bool conDetalle = false,
  }) async {
    final tipoAlias = alias(db.tipoHabitacionTable, 'tipo');
    final creadorAlias = alias(db.usuarioTable, 'creador');

    final query = select(db.categoriaTable).join([
      leftOuterJoin(
        tipoAlias,
        tipoAlias.idInt.equalsExp(db.categoriaTable.tipoHabitacionInt),
      ),
      if (conDetalle)
        leftOuterJoin(
          creadorAlias,
          creadorAlias.idInt.equalsExp(db.categoriaTable.creadoPorInt),
        ),
    ]);

    if (tipoHabId != null) {
      query.where(db.categoriaTable.tipoHabitacionInt.equals(tipoHabId));
    }

    if (creadorId != null) {
      query.where(db.categoriaTable.creadoPorInt.equals(creadorId));
    }

    if (codigoHab.isNotEmpty) {
      final value = '%${codigoHab.toLowerCase()}%';
      query.where(tipoAlias.codigo.lower().like(value));
    }

    if (nombre.isNotEmpty) {
      final value = '%${nombre.toLowerCase()}%';
      query.where(db.categoriaTable.nombre.lower().like(value));
    }

    if (initDate != null) {
      query.where(db.categoriaTable.createdAt.isBiggerOrEqualValue(initDate));
    }

    if (lastDate != null) {
      query.where(db.categoriaTable.createdAt.isSmallerOrEqualValue(lastDate));
    }

    if (initDate != null && lastDate != null) {
      query.where(
        db.categoriaTable.createdAt.isBetweenValues(initDate, lastDate),
      );
    }

    OrderingTerm? ordering;

    switch (sortBy) {
      case 'nombre':
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.categoriaTable.nombre)
            : OrderingTerm.asc(db.categoriaTable.nombre);
        break;
      case 'createdAt':
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.categoriaTable.createdAt)
            : OrderingTerm.asc(db.categoriaTable.createdAt);
        break;
      default:
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.categoriaTable.idInt)
            : OrderingTerm.asc(db.categoriaTable.idInt);
    }

    query.orderBy([ordering]);

    final offset = (page - 1) * limit;
    query.limit(limit, offset: offset);

    final rows = await query.get();

    return rows.map(
      (row) {
        final categoria = row.readTable(db.categoriaTable);
        final tipo = row.readTableOrNull(tipoAlias);
        final creador = row.readTableOrNull(creadorAlias);

        return Categoria(
          idInt: categoria.idInt,
          id: categoria.id,
          color: ColorsHelpers.colorFromJson(categoria.color),
          descripcion: categoria.descripcion,
          nombre: categoria.nombre,
          tipoHabitacion: TipoHabitacion.fromJson(tipo?.toJson() ?? mapEmpty),
          creadoPor: Usuario.fromJson(creador?.toJson() ?? mapEmpty),
        );
      },
    ).toList();
  }

  // CREATE
  Future<Categoria?> insert(Categoria categoria) async {
    var response = await into(db.categoriaTable).insertReturningOrNull(
      CategoriaTableData.fromJson(
        categoria.toJson(),
      ),
    );

    if (response == null) return null;
    return Categoria.fromJson(response.toJson());
  }

  // READ: Categoria por ID
  Future<Categoria?> getByID(int id) async {
    final tipoAlias = alias(db.tipoHabitacionTable, 'tipo');
    final creadorAlias = alias(db.usuarioTable, 'creador');

    final query = select(db.categoriaTable).join([
      leftOuterJoin(
        tipoAlias,
        tipoAlias.idInt.equalsExp(db.categoriaTable.tipoHabitacionInt),
      ),
      leftOuterJoin(
        creadorAlias,
        creadorAlias.idInt.equalsExp(db.categoriaTable.creadoPorInt),
      ),
    ]);

    query.where(db.categoriaTable.idInt.equals(id));
    var row = await query.getSingleOrNull();
    if (row == null) return null;
    final categoria = row.readTable(db.categoriaTable);
    final tipo = row.readTableOrNull(tipoAlias);
    final creador = row.readTableOrNull(creadorAlias);

    return Categoria(
      idInt: categoria.idInt,
      id: categoria.id,
      color: ColorsHelpers.colorFromJson(categoria.color),
      descripcion: categoria.descripcion,
      nombre: categoria.nombre,
      tipoHabitacion: TipoHabitacion.fromJson(tipo?.toJson() ?? mapEmpty),
      creadoPor: Usuario.fromJson(creador?.toJson() ?? mapEmpty),
    );
  }

  // UPDATE
  Future<Categoria?> updat3(Categoria categoria) async {
    var response = await update(db.categoriaTable).replace(
      CategoriaTableData.fromJson(
        categoria.toJson(),
      ),
    );

    if (!response) return null;
    return await getByID(categoria.idInt ?? 0);
  }

  // SAVE
  Future<Categoria?> save(Categoria categoria) async {
    if (categoria.idInt == null) {
      return await insert(categoria);
    } else {
      return await updat3(categoria);
    }
  }

  // DELETE
  Future<int> delet3(int id) {
    var response = (delete(db.clienteTable)
          ..where((u) {
            return u.idInt.equals(id);
          }))
        .go();

    return response;
  }
}
