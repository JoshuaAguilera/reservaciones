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
    bool conDetalle = false,
  }) async {
    final creadorAlias = alias(db.usuarioTable, 'creador');
    final cerradorAlias = alias(db.usuarioTable, 'cerrador');
    final clienteAlias = alias(db.clienteTable, 'cliente');

    final query = select(db.cotizacionTable).join([
      leftOuterJoin(
        creadorAlias,
        creadorAlias.id.equalsExp(db.cotizacionTable.creadoPor),
      ),
      if (conDetalle)
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
      query.where(db.cotizacionTable.creadoPorInt.equals(creadorId));
    }

    if (cerradorId != null) {
      query.where(db.cotizacionTable.cerradoPorInt.equals(cerradorId));
    }

    if (clienteId != null) {
      query.where(db.cotizacionTable.clienteInt.equals(clienteId));
    }

    if (clienteNombre.trim().isNotEmpty) {
      final value = '%${clienteNombre.toLowerCase()}%';

      query.where(
        clienteAlias.nombres.lower().like(value) |
            clienteAlias.apellidos.lower().like(value) |
            (clienteAlias.nombres +
                    const Constant(' ') +
                    clienteAlias.apellidos)
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
            db.cotizacionTable.estatus.equals("cotizado") &
            db.cotizacionTable.fechaLimite.isBiggerThan(
              Variable(
                DateTime.now(),
              ),
            );
      }

      if (showFilter[2]) {
        implementFilter = db.cotizacionTable.esGrupo.equals(false) &
            db.cotizacionTable.estatus.equals("cotizado") &
            db.cotizacionTable.fechaLimite.isBiggerThan(
              Variable(
                DateTime.now(),
              ),
            );
      }

      if (showFilter[3]) {
        implementFilter = db.cotizacionTable.esGrupo.equals(true) &
            db.cotizacionTable.estatus.equals("reservado");
      }

      if (showFilter[4]) {
        implementFilter = db.cotizacionTable.esGrupo.equals(false) &
            db.cotizacionTable.estatus.equals("reservado");
      }

      if (showFilter[5]) {
        implementFilter = db.cotizacionTable.estatus.equals("cotizado") &
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
        idInt: cot.idInt,
        id: cot.id,
        folio: cot.folio,
        fechaLimite: cot.fechaLimite,
        esGrupo: cot.esGrupo,
        estatus: cot.estatus,
        comentarios: cot.comentarios,
        createdAt: cot.createdAt,
        creadoPor: Usuario.fromJson(creador?.toJson() ?? <String, dynamic>{}),
        cerradoPor: Usuario.fromJson(cerrador?.toJson() ?? <String, dynamic>{}),
        cliente: Cliente.fromJson(cli?.toJson() ?? <String, dynamic>{}),
      );
    }).toList();
  }

  // CREATE
  Future<int> insert(Cotizacion cotizacion) {
    var response = into(db.cotizacionTable).insert(
      CotizacionTableData.fromJson(
        cotizacion.toJson(),
      ),
    );
    return response;
  }

  // READ: Cotizacion por ID
  Future<Cotizacion?> getByID(int id) async {
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

    query.where(
      db.cotizacionTable.idInt.equals(id),
    );

    var row = await query.getSingleOrNull();
    if (row == null) return null;
    final cot = row.readTable(db.cotizacionTable);
    final creador = row.readTableOrNull(creadorAlias);
    final cerrador = row.readTableOrNull(cerradorAlias);
    final cli = row.readTableOrNull(clienteAlias);

    var quote = Cotizacion(
      id: cot.id,
      idInt: cot.idInt,
      folio: cot.folio,
      createdAt: cot.createdAt,
      fechaLimite: cot.fechaLimite,
      estatus: cot.estatus,
      esGrupo: cot.esGrupo,
      creadoPor: Usuario.fromJson(creador?.toJson() ?? <String, dynamic>{}),
      cerradoPor: Usuario.fromJson(cerrador?.toJson() ?? <String, dynamic>{}),
      cliente: Cliente.fromJson(cli?.toJson() ?? <String, dynamic>{}),
    );
    return quote;
  }

  // UPDATE
  Future<bool> updat3(Cotizacion quote) {
    var response = update(db.cotizacionTable).replace(
      CotizacionTableData.fromJson(
        quote.toJson(),
      ),
    );

    return response;
  }

  // DELETE
  Future<int> delet3({int? id, String folio = ""}) {
    var response = (delete(db.cotizacionTable)
          ..where(
            (u) {
              if (id != null) {
                return u.idInt.equals(id);
              } else {
                return u.folio.equals(folio);
              }
            },
          ))
        .go();

    return response;
  }
}
