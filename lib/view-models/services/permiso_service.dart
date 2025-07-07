import '../../models/permiso_model.dart';
import 'base_service.dart';

class PermisoService extends BaseService {
  Future<List<Permiso>> getList({
    String search = "",
    String sortBy = "resource",
    String order = "asc",
  }) async {
    var roles = List<Permiso>.empty();

    try {
      List<Permiso> permisos = Permission().permisos;

      // Filtrar por search
      if (search.isNotEmpty) {
        String q = search.toLowerCase();
        permisos = permisos.where((p) {
          return (p.description?.toLowerCase().contains(q) ?? false) ||
              (p.action?.toLowerCase().contains(q) ?? false);
        }).toList();
      }

      String Function(Permiso) getField = (Permiso p) => p.resource ?? '';

      switch (sortBy) {
        case 'description':
          getField = (Permiso p) => p.description ?? '';
          break;
        case 'action':
          getField = (Permiso p) => p.action ?? '';
          break;
        case 'resource':
          getField = (Permiso p) => p.resource ?? '';
          break;
        // Agrega más campos si es necesario
      }

      permisos.sort((a, b) {
        final aValue = getField(a).toLowerCase();
        final bValue = getField(b).toLowerCase();
        int cmp = aValue.compareTo(bValue);
        return order == "asc" ? cmp : -cmp;
      });

      roles = permisos;
    } catch (e) {
      print(e);
    }
    return roles;
  }
}
