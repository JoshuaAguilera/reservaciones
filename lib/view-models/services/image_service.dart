import 'dart:io';

import 'package:tuple/tuple.dart';

import '../../database/dao/imagen_dao.dart';
import '../../database/database.dart';
import '../../models/imagen_model.dart';
import '../../res/helpers/utility.dart';
import '../../utils/shared_preferences/preferences.dart';
import 'base_service.dart';

class ImageService extends BaseService {
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

  Future<Tuple2<String?, Imagen?>> saveImage({
    required Imagen imagen,
    String oldUrl = '',
  }) async {
    Imagen? newImage;
    bool isUpdate = imagen.idInt != null;

    try {
      if (oldUrl.isNotEmpty) {
        final archivo = File(oldUrl);
        if (await archivo.exists()) {
          await archivo.delete();
        } else {
          print('El archivo no existe.');
        }
      }

      final db = AppDatabase();
      final imagenDao = ImagenDao(db);
      final response = await (isUpdate
          ? imagenDao.updat3(imagen)
          : imagenDao.insert(imagen));
      await imagenDao.close();
      await db.close();

      if (response == null) throw Exception('Ocurrió un error al guardar');
      newImage = response;
    } catch (e) {
      print(e);
      return Tuple2(e.toString(), null);
    }

    return Tuple2(null, newImage);
  }

  Future<String> handleImageSelection(File? pathImage) async {
    try {
      final folderPath = '/images';
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
