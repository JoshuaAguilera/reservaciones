import 'dart:io';

import 'package:drift/drift.dart';
import 'package:generador_formato/models/imagen_model.dart';
import 'package:generador_formato/services/base_service.dart';

import '../database/database.dart';
import '../utils/helpers/utility.dart';
import '../utils/shared_preferences/preferences.dart';

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
      Preferences.userImageUrl = imagen!.urlImagen ?? '';
    } catch (e) {
      await database.close();
    }

    return response;
  }

  Future<bool> updateUrlImage(
      int id, String code, String url, String urlOld) async {
    bool success = false;
    final archivo = File(urlOld);

    try {
      if (await archivo.exists()) {
        await archivo.delete();
      } else {
        print('El archivo no existe.');
      }

      final db = AppDatabase();
      int response = await db.updateURLImage(id, code, url);
      success = response != 1;
      db.close();
      Preferences.userImageUrl = url;
    } catch (e) {
      success = true;
      print(e);
    }

    return success;
  }

  Future<String> handleImageSelection(File? pathImage) async {
    try {
      final folderPath = '/images';
      int uniqueCode = Utility.getUniqueCode();

      //agregar code para no sobrescribir imagenes
      final fileName =
          'image_user_${Preferences.userId}_perfil_$uniqueCode.png';
      final filePath = '$folderPath/$fileName';

      final folder = Directory(folderPath);
      if (!folder.existsSync()) {
        folder.createSync(recursive: true);
      }

      final savedImage = await pathImage!.copy(filePath);

      return savedImage.path;
    } catch (e) {
      print(e);
      return '';
    }
  }
}
