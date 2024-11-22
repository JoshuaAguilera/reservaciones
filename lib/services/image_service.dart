import 'package:drift/drift.dart';
import 'package:generador_formato/models/imagen_model.dart';
import 'package:generador_formato/services/base_service.dart';

import '../database/database.dart';

class ImageService extends BaseService {
  Future<ImagesTableData?> getImageById(int imageId) async {
    List<ImagesTableData> images = [];

    try {
      final db = AppDatabase();
      images = await db.getImageById(imageId);
      db.close();
    } catch (e) {
      print(e);
    }
    return images.firstOrNull;
  }

  Future<ImagesTableData?> saveImage(Imagen? imagen) async {
    ImagesTableData? response;
    final database = AppDatabase();

    try {
      ImagesTableData? result =
          await database.into(database.imagesTable).insertReturningOrNull(
                ImagesTableCompanion.insert(
                  code: Value(imagen?.code?.toString()),
                  urlImage: Value(imagen?.urlImagen),
                ),
              );
      await database.close();
      response = result;
    } catch (e) {
      await database.close();
    }

    return response;
  }

  Future<bool> updateUrlImage(int id, String code, String url) async {
    bool success = false;

    try {
      final db = AppDatabase();
      int response = await db.updateURLImage(id, code, url);
      success = response != 1;
      db.close();
    } catch (e) {
      print(e);
    }

    return success;
  }
}
