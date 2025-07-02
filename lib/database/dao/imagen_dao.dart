import 'package:drift/drift.dart';

import '../../models/imagen_model.dart';
import '../database.dart';
import '../tables/imagen_table.dart';

part 'imagen_dao.g.dart';

@DriftAccessor(tables: [ImagenTable])
class ImagenDao extends DatabaseAccessor<AppDatabase> with _$ImagenDaoMixin {
  ImagenDao(AppDatabase db) : super(db);

  var mapEmpty = <String, dynamic>{};

  // LIST
  Future<List<Imagen>> getList({
    String nombre = '',
    DateTime? initDate,
    DateTime? lastDate,
    String? sortBy,
    String order = 'asc',
    int limit = 20,
    int page = 1,
  }) async {
    final query = select(db.imagenTable);

    if (nombre.isNotEmpty) {
      query.where((u) => u.nombre.like('%$nombre%'));
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
            ? OrderingTerm.desc(db.imagenTable.nombre)
            : OrderingTerm.asc(db.imagenTable.nombre);
        break;
      case 'createdAt':
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.imagenTable.createdAt)
            : OrderingTerm.asc(db.imagenTable.createdAt);
        break;
      default:
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.imagenTable.idInt)
            : OrderingTerm.asc(db.imagenTable.idInt);
    }

    query.orderBy([(_) => ordering!]);

    final offset = (page - 1) * limit;
    query.limit(limit, offset: offset);

    final data = await query.get();

    return data.map(
      (e) {
        Imagen image = Imagen.fromJson(e.toJson());
        return image;
      },
    ).toList();
  }

  // CREATE
  Future<Imagen?> insert(Imagen imagen) async {
    var response = await into(db.imagenTable).insertReturningOrNull(
      ImagenTableData.fromJson(
        imagen.toJson(),
      ),
    );

    if (response == null) return null;
    Imagen newImage = Imagen.fromJson(response.toJson());
    return newImage;
  }

  // READ: Imagen por ID
  Future<Imagen?> getByID(int id) async {
    var response = await (select(db.imagenTable)
          ..where((u) {
            return u.idInt.equals(id);
          }))
        .getSingleOrNull();

    return Imagen?.fromJson(response?.toJson() ?? <String, dynamic>{});
  }

  // UPDATE
  Future<Imagen?> updat3(Imagen imagen) async {
    var response = await update(db.imagenTable).replace(
      ImagenTableData.fromJson(
        imagen.toJson(),
      ),
    );

    if (!response) return null;
    return await getByID(imagen.idInt ?? 0);
  }

  // SAVE
  Future<Imagen?> save(Imagen imagen) async {
    if (imagen.idInt != null && imagen.idInt! > 0) {
      return await updat3(imagen);
    } else {
      return await insert(imagen);
    }
  }

  // DELETE
  Future<int> delet3(int id) {
    var response = (delete(db.imagenTable)
          ..where((u) {
            return u.idInt.equals(id);
          }))
        .go();

    return response;
  }
}
