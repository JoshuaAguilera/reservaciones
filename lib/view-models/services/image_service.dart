import 'dart:io';

import 'package:drift/drift.dart';

import '../../database/database.dart';
import '../../models/imagen_model.dart';
import '../../res/helpers/utility.dart';
import '../../utils/shared_preferences/preferences.dart';
import 'base_service.dart';

class ImageService extends BaseService {
  Future<ImageTableData?> getImageById(int imageId) async {
    List<ImageTableData> images = [];

    try {
      final db = AppDatabase();
      images = await db.getImageById(imageId);
      db.close();
    } catch (e) {
      print(e);
    }
    return images.firstOrNull;
  }

  Future<ImageTableData?> saveImage(Imagen? imagen) async {
    ImageTableData? response;
    final database = AppDatabase();

    try {
      ImageTableData? result =
          await database.into(database.imageTable).insertReturningOrNull(
                ImageTableCompanion.insert(
                  code: Value(imagen?.createdAt?.toString()),
                  urlImage: Value(imagen?.ruta),
                ),
              );
      await database.close();
      response = result;
      Preferences.userImageUrl = imagen!.ruta ?? '';
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
