import 'package:drift/drift.dart';

import '../../models/cliente_model.dart';
import '../database.dart';
import '../tables/cliente_table.dart';

part 'cliente_dao.g.dart';

@DriftAccessor(tables: [ClienteTable])
class ClienteDao extends DatabaseAccessor<AppDatabase> with _$ClienteDaoMixin {
  ClienteDao(AppDatabase db) : super(db);

  // LIST
  Future<List<Cliente>> getList({
    String nombre = '',
    String correo = '',
    DateTime? initDate,
    DateTime? lastDate,
    String? sortBy,
    String order = 'asc',
    int limit = 20,
    int page = 1,
  }) async {
    final query = select(db.clienteTable);

    if (nombre.isNotEmpty) {
      final value = '%${nombre.toLowerCase()}%';
      query.where(
        (tbl) {
          var response = tbl.nombres.lower().like(value) |
              tbl.apellidos.lower().like(value) |
              (tbl.nombres + const Constant(' ') + tbl.apellidos)
                  .lower()
                  .like(value);

          return response;
        },
      );
    }

    if (correo.isNotEmpty) {
      query.where((u) => u.correoElectronico.like('%$correo%'));
    }

    if (initDate != null) {
      query.where((u) => u.createdAt.isBiggerOrEqualValue(initDate));
    }

    if (lastDate != null) {
      query.where((u) => u.createdAt.isSmallerOrEqualValue(lastDate));
    }

    OrderingTerm? ordering;

    switch (sortBy) {
      case 'nombre':
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.clienteTable.nombres)
            : OrderingTerm.asc(db.clienteTable.nombres);
        break;
      case 'correo':
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.clienteTable.correoElectronico)
            : OrderingTerm.asc(db.clienteTable.correoElectronico);
        break;
      case 'createdAt':
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.clienteTable.createdAt)
            : OrderingTerm.asc(db.clienteTable.createdAt);
        break;
      default:
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.clienteTable.idInt)
            : OrderingTerm.asc(db.clienteTable.idInt);
    }

    query.orderBy([(_) => ordering!]);

    final offset = (page - 1) * limit;
    query.limit(limit, offset: offset);

    final data = await query.get();
    return data.map(
      (e) {
        Cliente client = Cliente.fromJson(e.toJson());
        return client;
      },
    ).toList();
  }

  // CREATE
  Future<Cliente?> insert(Cliente cliente) async {
    var response = await into(db.clienteTable).insertReturningOrNull(
      ClienteTableData.fromJson(
        cliente.toJson(),
      ),
    );

    if (response == null) return null;
    Cliente newCustomer = Cliente.fromJson(response.toJson());
    return newCustomer;
  }

  // READ: Cliente por ID
  Future<Cliente?> getByID(int id) async {
    var response = await (select(db.clienteTable)
          ..where((u) {
            return u.idInt.equals(id);
          }))
        .getSingleOrNull();

    return Cliente?.fromJson(response?.toJson() ?? <String, dynamic>{});
  }

  // UPDATE
  Future<Cliente?> updat3(Cliente cliente) async {
    var response = await update(db.clienteTable).replace(
      ClienteTableData.fromJson(
        cliente.toJson(),
      ),
    );

    if (!response) return null;
    return await getByID(cliente.idInt ?? 0);
  }

  // SAVE
  Future<Cliente?> save(Cliente cliente) async {
    if (cliente.idInt == null) {
      return await insert(cliente);
    } else {
      return await updat3(cliente);
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
