import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/registro_tarifa_model.dart';
import 'package:generador_formato/models/temporada_model.dart';
import 'package:generador_formato/services/tarifa_service.dart';
import 'package:generador_formato/utils/shared_preferences/settings.dart';
import 'package:riverpod/riverpod.dart';

import '../models/tarifa_base_model.dart';

final editTarifaProvider =
    StateProvider<RegistroTarifa>((ref) => RegistroTarifa());

final allTarifaProvider = FutureProvider.family<List<RegistroTarifa>, String>(
  (ref, arg) async {
    final detectChanged = ref.watch(changeTarifasProvider);
    final list = await TarifaService().getTarifasBD();
    return list;
  },
);

final listTarifaProvider = FutureProvider.family<List<RegistroTarifa>, String>(
  (ref, arg) {
    final detectChanged = ref.watch(changeTarifasListProvider);
    final todos = ref.watch(allTarifaProvider('')).asData;
    return todos!.value;
  },
);

final tariffPolicyProvider = FutureProvider.family<Politica?, String>(
  (ref, arg) async {
    final detectChanged = ref.watch(changeTariffPolicyProvider);
    final list = await TarifaService().getTariffPolicy();
    return list;
  },
);

final changeTarifasProvider = StateProvider<int>((ref) => 0);
final changeTarifasBaseProvider = StateProvider<int>((ref) => 0);
final changeTarifasListProvider = StateProvider<int>((ref) => 0);
final changeTariffPolicyProvider = StateProvider<int>((ref) => 0);

final selectedModeViewProvider =
    StateProvider<List<bool>>((ref) => <bool>[true, false, false]);

final temporadasIndividualesProvider = StateProvider<List<Temporada>>(
  (ref) => [
    Temporada(nombre: "DIRECTO", editable: false),
    Temporada(nombre: "BAR I", editable: false),
    Temporada(nombre: "BAR II", editable: false),
  ],
);

final temporadasGrupalesProvider = StateProvider<List<Temporada>>((ref) => []);
final temporadasEfectivoProvider = StateProvider<List<Temporada>>((ref) => []);

final tarifaBaseProvider = FutureProvider.family<List<TarifaBaseInt>, String>(
  (ref, arg) async {
    final detectChanged = ref.watch(changeTarifasBaseProvider);
    final list = await TarifaService().getBaseTariff();
    return list;
  },
);

//Calendar Controller Providers

final dateTarifferProvider = StateProvider<DateTime>((ref) => DateTime.now());
final pageWeekControllerProvider = StateProvider<PageController>(
  (ref) => PageController(initialPage: DateTime.now().month - 1),
);

class MonthControllerNotifier extends ChangeNotifier {
  bool showCalendar = true;
  double targetCalendar = 1;

  void disguice() {
    targetCalendar = 0;
    Future.delayed(Settings.applyAnimations ? 450.ms : 100.ms, () {
      showCalendar = false;
      notifyListeners();
    });
  }

  void reveal() {
    Future.delayed(Settings.applyAnimations ? 650.ms : 150.ms, () {
      targetCalendar = 1;
      showCalendar = true;
      notifyListeners();
    });
  }
}

final monthNotifierProvider =
    ChangeNotifierProvider<MonthControllerNotifier>((ref) {
  return MonthControllerNotifier();
});
