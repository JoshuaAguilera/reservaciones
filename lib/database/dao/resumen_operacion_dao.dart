import 'package:drift/drift.dart';

import '../../models/categoria_model.dart';
import '../../models/resumen_operacion_model.dart';
import '../database.dart';
import '../tables/resumen_operacion_table.dart';

part 'resumen_operacion_dao.g.dart';

@DriftAccessor(tables: [ResumenOperacionTable])
class ResumenOperacionDao extends DatabaseAccessor<AppDatabase>
    with _$ResumenOperacionDaoMixin {
  ResumenOperacionDao(AppDatabase db) : super(db);

  // LIST
  Future<List<ResumenOperacion>> getList({
    int? habitacionId,
    int? cotizacionId,
    int? categoriaId,
    int limit = 20,
    int page = 1,
  }) async {
    final categoriaAlias = alias(db.categoriaTable, 'categoria');

    final query = select(db.resumenOperacionTable).join([
      leftOuterJoin(
        categoriaAlias,
        categoriaAlias.idInt.equalsExp(db.resumenOperacionTable.categoriaInt),
      ),
    ]);

    if (habitacionId != null) {
      query.where(db.resumenOperacionTable.habitacionInt.equals(habitacionId));
    }

    if (cotizacionId != null) {
      query.where(db.resumenOperacionTable.cotizacionInt.equals(cotizacionId));
    }

    final offset = (page - 1) * limit;
    query.limit(limit, offset: offset);

    final rows = await query.get();

    // Mapear resultados con joins
    return rows.map((row) {
      final resumen = row.readTable(db.resumenOperacionTable);
      final creador = row.readTableOrNull(categoriaAlias);

      return ResumenOperacion(
        idInt: resumen.idInt,
        id: resumen.id,
        cotizacion: resumen.cotizacion,
        cotizacionInt: resumen.cotizacionInt,
        habitacion: resumen.habitacion,
        habitacionInt: resumen.habitacionInt,
        descuento: resumen.descuento,
        impuestos: resumen.impuestos,
        subtotal: resumen.subtotal,
        total: resumen.total,
        categoria: Categoria.fromJson(creador?.toJson() ?? <String, dynamic>{}),
      );
    }).toList();
  }

  // CREATE
  Future<int> insert(ResumenOperacion tarifas) {
    return into(db.resumenOperacionTable).insert(
      ResumenOperacionTableData.fromJson(
        tarifas.toJson(),
      ),
    );
  }

  // READ: Resumen Operacion por ID
  Future<ResumenOperacion?> getByID(int id) async {
    var response = await (select(db.resumenOperacionTable)
          ..where((u) {
            return u.idInt.equals(id);
          }))
        .getSingleOrNull();

    if (response == null) return null;
    var resumen = ResumenOperacion.fromJson(response.toJson());
    return resumen;
  }

  // UPDATE
  Future<bool> updat3(ResumenOperacion resumen) {
    var response = update(db.resumenOperacionTable).replace(
      ResumenOperacionTableData.fromJson(
        resumen.toJson(),
      ),
    );

    return response;
  }

  // DELETE
  Future<int> delet3(int id) {
    var response = (delete(db.resumenOperacionTable)
          ..where((u) {
            return u.idInt.equals(id);
          }))
        .go();

    return response;
  }
}
