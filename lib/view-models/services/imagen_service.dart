import 'dart:io';

import 'package:tuple/tuple.dart';

import '../../database/dao/imagen_dao.dart';
import '../../database/database.dart';
import '../../models/error_model.dart';
import '../../models/imagen_model.dart';
import '../../res/helpers/utility.dart';
import '../../utils/shared_preferences/preferences.dart';
import 'base_service.dart';

class ImagenService extends BaseService {
  Future<Tuple2<String?, Imagen?>> getImageById(int imageId) async {
    Imagen? imagen;

    try {
      final db = AppDatabase();
      final imagenDao = ImagenDao(db);
      imagen = await imagenDao.getByID(imageId);
      imagenDao.close();
      db.close();

      if (imagen == null) throw Exception('Imagen no encontrada');
    } catch (e) {
      print(e);
      return Tuple2(e.toString(), null);
    }
    return Tuple2(null, imagen);
  }

  Future<Tuple3<ErrorModel?, Imagen?, bool>> saveData({
    required Imagen imagen,
  }) async {
    ErrorModel? error;
    Imagen? saveImage;
    bool invalideToken = false;

    try {
      final db = AppDatabase();
      final imagenDao = ImagenDao(db);
      saveImage = await imagenDao.save(imagen);
      await imagenDao.close();
      await db.close();

      if (saveImage == null) throw Exception('Ocurrió un error al guardar');
    } catch (e) {
      error = ErrorModel(message: e.toString());
    }

    return Tuple3(error, saveImage, invalideToken);
  }

  Future<Tuple3<ErrorModel?, bool, bool>> delete(Imagen imagen) async {
    ErrorModel? error;
    bool invalideToken = false;
    bool deleted = false;

    try {
      final db = AppDatabase();
      final imagenDao = ImagenDao(db);
      int response = await imagenDao.delet3(imagen.idInt ?? 0);
      deleted = response > 0;
      await imagenDao.close();
      await db.close();

      if (!deleted) throw Exception('Ocurrió un error al eliminar');
    } catch (e) {
      error = ErrorModel(message: e.toString());
    }

    return Tuple3(error, deleted, invalideToken);
  }

  Future<String> handleImageSelection(File? pathImage) async {
    try {
      const folderPath = '/images';
      int uniqueCode = Utility.getUniqueCode();

      //agregar code para no sobrescribir imagenes
      final fileName =
          'image_user_${Preferences.userIdInt}_perfil_$uniqueCode.png';
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
