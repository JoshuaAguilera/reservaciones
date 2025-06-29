import 'package:intl/intl.dart';

import '../../models/categoria_model.dart';
import '../../models/habitacion_model.dart';
import '../../models/tarifa_model.dart';
import '../../models/tarifa_rack_model.dart';
import '../../models/tarifa_x_habitacion_model.dart';
import '../../models/temporada_model.dart';

class CalculatorHelpers {
  static String formatterNumber(double number) {
    return NumberFormat.simpleCurrency(locale: 'EN-us', decimalDigits: 2)
        .format(number);
  }

  static double formatNumberRound(double number, {int fractionDigits = 7}) {
    if (number > 0) {
      return double.parse(number.toStringAsFixed(fractionDigits));
    } else if (number < 0) {
      return double.parse(number.toStringAsFixed(fractionDigits));
    } else {
      return 0.0;
    }
  }

  static dynamic calculatePromotion(String tarifa, double? promocion,
      {bool returnDouble = false,
      bool rounded = true,
      bool onlyDiscount = false}) {
    double subtotal = 0;
    double tarifaNum = double.parse(tarifa.isEmpty ? '0' : tarifa);
    double promocionNUM = promocion ?? 0;

    double descuento = formatNumberRound((tarifaNum * 0.01) * (promocionNUM));

    subtotal = tarifaNum - descuento;

    if (!returnDouble) {
      if (rounded) {
        return formatterNumber(formatNumberRound(subtotal).roundToDouble());
      } else {
        return formatterNumber(subtotal);
      }
    } else {
      if (rounded) {
        return formatNumberRound(onlyDiscount ? descuento : subtotal)
            .roundToDouble();
      } else {
        return onlyDiscount ? descuento : subtotal;
      }
    }
  }

  static double calculateTarifa(
    Habitacion habitacion,
    int totalDays,
    Categoria categoria, {
    String tipoTemporada = "general",
    TarifaXHabitacion? tarifaHab,
    bool isCalculateChildren = false,
    bool withDiscount = true,
    bool onlyDiscount = false,
    double? descuentoProvisional,
    bool getTotalRoom = false,
    bool applyRoundFormat = false,
  }) {
    double tariffAdult = 0;
    double tariffChildren = 0;

    if (tarifaHab == null) return 0;
    if (tarifaHab.tarifaXDia?.tarifaRack == null) return 0;

    TarifaRack rack = tarifaHab.tarifaXDia!.tarifaRack!;

    List<Tarifa> tarifas = tarifaHab.tarifaXDia?.tarifaRack?.tarifas ?? [];

    Tarifa? nowTarifa = tarifas
        .where((element) => element.categoria?.idInt == categoria.idInt)
        .firstOrNull;

    double descuento = 0;

    if ((rack.temporadas ?? []).isNotEmpty) {
      descuento = getSeasonNow(
            rack,
            totalDays,
            tipo: tipoTemporada,
          )?.descuento ??
          0;
    } else {
      descuento = descuentoProvisional ?? 0;
    }

    tariffChildren =
        (nowTarifa?.tarifaMenores7a12 ?? 0) * habitacion.menores7a12!;

    switch (habitacion.adultos) {
      case 1 || 2:
        double adult1o2 = (nowTarifa?.tarifaAdulto1a2 ?? 0);
        tariffAdult = adult1o2;
      case 3:
        double adult3 = (nowTarifa?.tarifaAdulto3 ?? 0);
        tariffAdult = adult3;
      case 4:
        double adult4 = (nowTarifa?.tarifaAdulto4 ?? 0);
        tariffAdult = adult4;
      default:
        double paxAdic = (nowTarifa?.tarifaPaxAdicional ?? 0);
        tariffAdult = paxAdic;
    }

    if (withDiscount) {
      tariffChildren = calculatePromotion(
        tariffChildren.toString(),
        descuento,
        returnDouble: true,
        rounded: applyRoundFormat,
      );

      tariffAdult = calculatePromotion(
        tariffAdult.toString(),
        descuento,
        returnDouble: true,
        rounded: applyRoundFormat,
      );
    }

    if (onlyDiscount) {
      tariffChildren = calculatePromotion(
        tariffChildren.toString(),
        descuento,
        returnDouble: true,
        rounded: applyRoundFormat,
        onlyDiscount: true,
      );
      tariffAdult = calculatePromotion(
        tariffAdult.toString(),
        descuento,
        returnDouble: true,
        rounded: applyRoundFormat,
        onlyDiscount: true,
      );
    }

    if (getTotalRoom) {
      return formatNumberRound(tariffChildren).roundToDouble() +
          formatNumberRound(tariffAdult).roundToDouble();
    }

    if (isCalculateChildren) {
      return applyRoundFormat
          ? formatNumberRound(tariffChildren).roundToDouble()
          : tariffChildren;
    } else {
      return applyRoundFormat
          ? formatNumberRound(tariffAdult).roundToDouble()
          : tariffAdult;
    }
  }

  static Temporada? getSeasonNow(TarifaRack? nowRegister, int totalDays,
      {String tipo = "general"}) {
    if (nowRegister == null || nowRegister.temporadas == null) {
      return null;
    }

    Temporada? nowSeason;

    List<Temporada> validSeasons = [];

    validSeasons = nowRegister
            .copyWith()
            .temporadas
            ?.where((element) => element.tipo == tipo)
            .toList()
            .map((element) => element.copyWith())
            .toList() ??
        [];

    for (var element in validSeasons) {
      if (totalDays == element.estanciaMinima ||
          totalDays > element.estanciaMinima!) {
        nowSeason = element.copyWith();
      }
    }

    return nowSeason;
  }
}
