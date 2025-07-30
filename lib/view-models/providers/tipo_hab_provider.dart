import 'package:riverpod/riverpod.dart';

import '../../models/tipo_habitacion_model.dart';
import '../services/tipo_hab_service.dart';

final tipoHabListProvider =
    FutureProvider.family<List<TipoHabitacion>, String>((ref, arg) async {
  final list = await TipoHabService().getList();
  return list;
});
