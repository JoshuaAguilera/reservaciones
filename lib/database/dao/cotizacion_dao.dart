import 'package:drift/drift.dart';

import '../../models/cliente_model.dart';
import '../../models/cotizacion_model.dart';
import '../../models/usuario_model.dart';
import '../database.dart';
import '../tables/cliente_table.dart';
import '../tables/cotizacion_table.dart';
import '../tables/usuario_table.dart';

part 'cotizacion_dao.g.dart';

@DriftAccessor(tables: [CotizacionTable, ClienteTable, UsuarioTable])
class CotizacionDao extends DatabaseAccessor<AppDatabase>
    with _$CotizacionDaoMixin {
  CotizacionDao(AppDatabase db) : super(db);

  // LIST
  Future<List<Cotizacion>> getList({
    String clienteNombre = "",
    int? creadorId,
    int? cerradorId,
    int? clienteId,
    DateTime? initDate,
    DateTime? lastDate,
    String? sortBy,
    String order = 'asc',
    int limit = 20,
    int page = 1,
    bool inLastDay = false,
    bool inLastWeek = false,
    bool inLastMonth = false,
    bool onlyToday = false,
    List<bool>? showFilter,
  }) async {
    final creadorAlias = alias(db.usuarioTable, 'creador');
    final cerradorAlias = alias(db.usuarioTable, 'cerrador');
    final clienteAlias = alias(db.clienteTable, 'cliente');

    final query = select(db.cotizacionTable).join([
      leftOuterJoin(
        creadorAlias,
        creadorAlias.id.equalsExp(db.cotizacionTable.creadoPor),
      ),
      leftOuterJoin(
        cerradorAlias,
        cerradorAlias.id.equalsExp(db.cotizacionTable.cerradoPor),
      ),
      leftOuterJoin(
        clienteAlias,
        clienteAlias.id.equalsExp(db.cotizacionTable.cliente),
      ),
    ]);

    if (creadorId != null) {
      query.where(db.cotizacionTable.creadoPor.equals(creadorId));
    }

    if (cerradorId != null) {
      query.where(db.cotizacionTable.cerradoPor.equals(cerradorId));
    }

    if (clienteId != null) {
      query.where(db.cotizacionTable.cliente.equals(clienteId));
    }

    if (clienteNombre.trim().isNotEmpty) {
      final value = '%${clienteNombre.toLowerCase()}%';

      query.where(
        clienteAlias.nombre.lower().like(value) |
            clienteAlias.apellido.lower().like(value) |
            (clienteAlias.nombre + const Constant(' ') + clienteAlias.apellido)
                .lower()
                .like(value),
      );
    }

    if (initDate != null) {
      query.where(db.cotizacionTable.createdAt.isBiggerOrEqualValue(initDate));
    }

    if (lastDate != null) {
      query.where(db.cotizacionTable.createdAt.isSmallerOrEqualValue(lastDate));
    }

    if (initDate != null && lastDate != null) {
      query.where(
        db.cotizacionTable.createdAt.isBetweenValues(initDate, lastDate),
      );
    }

    if (!onlyToday) {
      if (inLastDay) {
        query.where(db.cotizacionTable.createdAt.isBetweenValues(
          DateTime.now().subtract(const Duration(days: 1)),
          DateTime.now(),
        ));
      }

      if (inLastWeek) {
        query.where(
          db.cotizacionTable.createdAt.isBetweenValues(
            DateTime.now().subtract(const Duration(days: 7)),
            DateTime.now(),
          ),
        );
      }

      if (inLastMonth) {
        query.where(
          db.cotizacionTable.createdAt.isBetweenValues(
              DateTime.now().subtract(const Duration(days: 30)),
              DateTime.now()),
        );
      }
    } else {
      query.where(
        db.cotizacionTable.createdAt.isBetweenValues(
            DateTime.parse(DateTime.now().toIso8601String().substring(0, 10)),
            DateTime.now()),
      );
    }

    if (showFilter != null) {
      Expression<bool> implementFilter = const Variable(true);

      if (showFilter[1]) {
        implementFilter = db.cotizacionTable.esGrupo.equals(true) &
            db.cotizacionTable.esConcretado.equals(false) &
            db.cotizacionTable.fechaLimite.isBiggerThan(
              Variable(
                DateTime.now(),
              ),
            );
      }

      if (showFilter[2]) {
        implementFilter = db.cotizacionTable.esGrupo.equals(false) &
            db.cotizacionTable.esConcretado.equals(false) &
            db.cotizacionTable.fechaLimite.isBiggerThan(
              Variable(
                DateTime.now(),
              ),
            );
      }

      if (showFilter[3]) {
        implementFilter = db.cotizacionTable.esGrupo.equals(true) &
            db.cotizacionTable.esConcretado.equals(true);
      }

      if (showFilter[4]) {
        implementFilter = db.cotizacionTable.esGrupo.equals(false) &
            db.cotizacionTable.esConcretado.equals(true);
      }

      if (showFilter[5]) {
        implementFilter = db.cotizacionTable.esConcretado.equals(false) &
            db.cotizacionTable.fechaLimite.isSmallerThan(
              Variable(
                DateTime.now(),
              ),
            );
      }

      query.where(implementFilter);
    }

    OrderingTerm orderingTerm;
    switch (sortBy) {
      case 'fecha':
        orderingTerm = order == 'desc'
            ? OrderingTerm.desc(db.cotizacionTable.createdAt)
            : OrderingTerm.asc(db.cotizacionTable.createdAt);
        break;
      default:
        orderingTerm = order == 'desc'
            ? OrderingTerm.desc(db.cotizacionTable.id)
            : OrderingTerm.asc(db.cotizacionTable.id);
    }

    query.orderBy([orderingTerm]);

    final offset = (page - 1) * limit;
    query.limit(limit, offset: offset);

    final rows = await query.get();

    // Mapear resultados con joins
    return rows.map((row) {
      final cot = row.readTable(db.cotizacionTable);
      final creador = row.readTableOrNull(creadorAlias);
      final cerrador = row.readTableOrNull(cerradorAlias);
      final cli = row.readTableOrNull(clienteAlias);
      return Cotizacion(
        id: cot.id,
        cotId: cot.cotId,
        folioPrincipal: cot.folioPrincipal,
        fechaLimite: cot.fechaLimite,
        esGrupo: cot.esGrupo,
        esConcretado: cot.esConcretado,
        comentarios: cot.comentarios,
        createdAt: cot.createdAt,
        creadoPor: Usuario.fromJson(creador?.toJson() ?? <String, dynamic>{}),
        cerradoPor: Usuario.fromJson(cerrador?.toJson() ?? <String, dynamic>{}),
        cliente: Cliente.fromJson(cli?.toJson() ?? <String, dynamic>{}),
      );
    }).toList();
  }

  // CREATE
  Future<int> insert(CotizacionTableCompanion cotizacion) {
    return into(db.cotizacionTable).insert(cotizacion);
  }

  // READ: Cotizacion por ID
  Future<CotizacionTableData?> getByID(int id) {
    var quote = (select(db.cotizacionTable)
          ..where((u) {
            return u.id.equals(id);
          }))
        .getSingleOrNull();

    return quote;
  }

  // UPDATE
  Future<bool> updat3(CotizacionTableData quote) {
    var response = update(db.cotizacionTable).replace(quote);

    return response;
  }

  // DELETE
  Future<int> delet3({int? id, String folio = ""}) {
    var response = (delete(db.cotizacionTable)
          ..where(
            (u) {
              if (id != null) {
                return u.id.equals(id);
              } else {
                return u.folioPrincipal.equals(folio);
              }
            },
          ))
        .go();

    return response;
  }
}
