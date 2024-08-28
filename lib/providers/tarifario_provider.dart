import 'package:generador_formato/models/registro_tarifa_model.dart';
import 'package:generador_formato/services/tarifa_service.dart';
import 'package:riverpod/riverpod.dart';

final allTarifaProvider =
    FutureProvider.family<List<RegistroTarifa>, String>((ref, arg) async {
  final detectChanged = ref.watch(changeTarifasProvider);
  final list = await TarifaService().getTarifasBD();
  return list;
});

final changeTarifasProvider = StateProvider<int>((ref) {
  return 0;
});
