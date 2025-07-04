import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import '../../models/politica_tarifario_model.dart';
import '../../models/tarifa_base_model.dart';
import '../../models/tarifa_rack_model.dart';
import '../../models/temporada_model.dart';
import '../../utils/shared_preferences/settings.dart';
import '../services/politica_tarifario_service.dart';
import '../services/tarifa_base_service.dart';
import '../services/tarifa_rack_service.dart';

final editTarifaProvider = StateProvider<TarifaRack>((ref) => TarifaRack());

final listTarifaProvider = FutureProvider.family<List<TarifaRack>, String>(
  (ref, arg) async {
    final detectChanged = ref.watch(changeTarifasProvider);
    final list = await TarifaRackService().getList();
    return list;
  },
);

final listPolicyProvider =
    FutureProvider.family<List<PoliticaTarifario>?, String>(
  (ref, arg) async {
    final detectChanged = ref.watch(changeTariffPolicyProvider);
    final list = await PoliticaTarifarioService().getList();
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
    Temporada(nombre: "DIRECTO", editable: false, tipo: "individual"),
    Temporada(nombre: "BAR I", editable: false, tipo: "individual"),
    Temporada(nombre: "BAR II", editable: false, tipo: "individual"),
  ],
);

final temporadasGrupalesProvider = StateProvider<List<Temporada>>((ref) => []);
final temporadasEfectivoProvider = StateProvider<List<Temporada>>((ref) => []);

final tarifaBaseProvider = FutureProvider.family<List<TarifaBase>, String>(
  (ref, arg) async {
    final detectChanged = ref.watch(changeTarifasBaseProvider);
    final list = await TarifaBaseService().getList();
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
