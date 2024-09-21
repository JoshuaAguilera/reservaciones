import 'package:generador_formato/models/registro_tarifa_model.dart';
import 'package:generador_formato/services/tarifa_service.dart';
import 'package:riverpod/riverpod.dart';

final editTarifaProvider = StateProvider<RegistroTarifa>((ref) {
  return RegistroTarifa();
});

final allTarifaProvider =
    FutureProvider.family<List<RegistroTarifa>, String>((ref, arg) async {
  final detectChanged = ref.watch(changeTarifasProvider);
  final list = await TarifaService().getTarifasBD();
  return list;
});

final listTarifaProvider =
    FutureProvider.family<List<RegistroTarifa>, String>((ref, arg) {
  final detectChanged = ref.watch(changeTarifasListProvider);
  final todos = ref.watch(allTarifaProvider('')).asData;
  return todos!.value;
});

final changeTarifasProvider = StateProvider<int>((ref) {
  return 0;
});

final changeTarifasListProvider = StateProvider<int>((ref) {
  return 0;
});

final selectedModeViewProvider = StateProvider<List<bool>>((ref) {
  return <bool>[
    true,
    false,
    false,
  ];
});
