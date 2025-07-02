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

  static dynamic getPromotion(
    double? tarifa, {
    double? promocion,
    bool returnDouble = false,
    bool rounded = true,
    bool onlyDiscount = false,
  }) {
    double subtotal = 0;
    double tarifaNum = tarifa ?? 0;
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

  static double getTarifa(
    Habitacion habitacion,
    int totalDays,
    Categoria categoria, {
    String tipoTemporada = "individual",
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
      tariffChildren = getPromotion(
        tariffChildren,
        promocion: descuento,
        returnDouble: true,
        rounded: applyRoundFormat,
      );

      tariffAdult = getPromotion(
        tariffAdult,
        promocion: descuento,
        returnDouble: true,
        rounded: applyRoundFormat,
      );
    }

    if (onlyDiscount) {
      tariffChildren = getPromotion(
        tariffChildren,
        promocion: descuento,
        returnDouble: true,
        rounded: applyRoundFormat,
        onlyDiscount: true,
      );
      tariffAdult = getPromotion(
        tariffAdult,
        promocion: descuento,
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
      {String tipo = "individual"}) {
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

  static String getRate({
    String tarifaAdulto = '',
    String tarifaPaxAdicional = '',
    int numPaxAdic = 0,
    bool applyRound = true,
  }) {
    String subtotalString = '0';
    double subtotal = 0;
    double tarifaAdultoNum =
        double.parse(tarifaAdulto.isEmpty ? '0' : tarifaAdulto);
    double tarifaPaxAdicNum =
        double.parse(tarifaPaxAdicional.isEmpty ? '0' : tarifaPaxAdicional);

    subtotal = tarifaAdultoNum + (tarifaPaxAdicNum * numPaxAdic);

    if (applyRound) {
      subtotalString = subtotal.round().toString();
    } else {
      subtotalString = formatNumberRound(subtotal).toString();
    }

    return subtotalString;
  }

  static dynamic getIncrease(double? tarifa, double? aumento,
      {bool withRound = true}) {
    double subtotal = 0;
    double tarifaNum = tarifa ?? 0;
    double aumentoNUM = aumento ?? 0;

    if (aumentoNUM != 0) {
      double increase = (tarifaNum / aumentoNUM);

      subtotal = increase;

      if (withRound) return subtotal.round().toDouble();
      return subtotal;
    } else {
      if (withRound) return tarifaNum.round().toDouble();
      return tarifaNum;
    }
  }

  static double getTotalCategoryRoom(
    TarifaRack? rate,
    Habitacion room,
    Categoria? categoria,
    int totalDays, {
    String tipoTemporada = "individual",
    bool isCalculateChildren = false,
    bool withDiscount = true,
    bool onlyDiscount = false,
    double? descuentoProvisional,
    bool getTotalRoom = false,
    bool applyRoundFormat = false,
  }) {
    double tariffAdult = 0;
    double tariffChildren = 0;

    if (rate == null) return 0;
    if (rate.tarifas == null) return 0;

    Tarifa? nowTarifa = rate.tarifas!
        .where((element) => element.categoria?.idInt == categoria?.idInt)
        .firstOrNull;

    double descuento = 0;

    if (rate.temporadas != null && rate.temporadas!.isNotEmpty) {
      descuento = getSeasonNow(
            rate,
            totalDays,
            tipo: tipoTemporada,
          )?.descuento ??
          0;
    } else {
      descuento = descuentoProvisional ?? 0;
    }

    tariffChildren = (nowTarifa?.tarifaMenores7a12 ?? 0) * room.menores7a12!;

    switch (room.adultos) {
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
      tariffChildren = getPromotion(
        tariffChildren,
        promocion: descuento,
        returnDouble: true,
        rounded: applyRoundFormat,
      );

      tariffAdult = getPromotion(
        tariffAdult,
        promocion: descuento,
        returnDouble: true,
        rounded: applyRoundFormat,
      );
    }

    if (onlyDiscount) {
      tariffChildren = getPromotion(
        tariffChildren,
        promocion: descuento,
        returnDouble: true,
        rounded: applyRoundFormat,
        onlyDiscount: true,
      );
      tariffAdult = getPromotion(
        tariffAdult,
        promocion: descuento,
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

  static double getTotalRooms(
    List<Habitacion> habitaciones,
    Categoria categoria, {
    String tipoCotizacion = "individual",
    bool onlyTotalReal = false,
    bool onlyDiscount = false,
    bool onlyTotal = false,
  }) {
    double total = 0;

    double calculateSubtotal(
        Habitacion habitacion, bool withDiscount, bool isGroup,
        {bool forDiscount = false}) {
      final tariffGroup = habitacion.tarifasXHabitacion
          ?.where((t) => t.esGrupal ?? false)
          .firstOrNull;

      if (tipoCotizacion == 'grupal' && tariffGroup != null && isGroup) {
        final applyRound = !(tariffGroup.tarifaXDia?.modificado ?? false);

        double baseTotal = getTotalCategoryRoom(
          tariffGroup.tarifaXDia?.tarifaRack,
          habitacion,
          categoria,
          habitacion.tarifasXHabitacion!.length,
          tipoTemporada: "grupal",
          getTotalRoom: true,
          descuentoProvisional: tariffGroup.tarifaXDia?.descIntegrado,
          withDiscount: withDiscount,
          applyRoundFormat: applyRound,
        );

        return (baseTotal * habitacion.tarifasXHabitacion!.length) *
            habitacion.count;
      } else {
        final resumen = habitacion.resumenes
            ?.where(
              (r) => r.categoria?.idInt == categoria.idInt,
            )
            .firstOrNull;

        if (resumen != null) {
          if (forDiscount) return (resumen.descuento ?? 0) * habitacion.count;
          if (withDiscount) return (resumen.total ?? 0) * habitacion.count;
          return (resumen.subtotal ?? 0) * habitacion.count;
        }
      }

      return 0;
    }

    final realRooms = habitaciones.where((h) => !h.esCortesia).toList();

    if (onlyTotalReal) {
      for (var habitacion in realRooms) {
        total += calculateSubtotal(habitacion, false, true);
      }
    }

    if (onlyDiscount) {
      for (var habitacion in habitaciones) {
        final isCortesia = habitacion.esCortesia;
        total +=
            calculateSubtotal(habitacion, true, !isCortesia, forDiscount: true);
      }
    }

    if (onlyTotal) {
      double desc = 0;
      for (var habitacion in realRooms) {
        total += calculateSubtotal(habitacion, true, true);
      }

      for (var habitacion in habitaciones.where((h) => h.esCortesia)) {
        desc += calculateSubtotal(habitacion, true, true);
      }

      total -= desc;
    }

    return total;
  }

  static double getTariffTotals(
    List<TarifaXHabitacion> tarifasFiltradas,
    Habitacion habitacion,
    Categoria categoria, {
    bool onlyAdults = false,
    bool onlyChildren = false,
  }) {
    double total = 0;

    for (var element in tarifasFiltradas) {
      Tarifa? selectTarifa;
      bool applyRound = !(element.tarifaXDia?.modificado ?? false);

      selectTarifa = element.tarifaXDia?.tarifaRack?.tarifas
          ?.where((element) => element.categoria?.idInt == categoria.idInt)
          .firstOrNull;

      if (onlyAdults) {
        switch (habitacion.adultos) {
          case 1 || 2:
            double adult1o2 = selectTarifa?.tarifaAdulto1a2 ?? 0;
            total +=
                (applyRound ? formatNumberRound(adult1o2).round() : adult1o2) *
                    element.numDays;

          case 3:
            total += (applyRound
                    ? (formatNumberRound((selectTarifa?.tarifaAdulto3 ?? 0))
                        .round())
                    : (selectTarifa?.tarifaAdulto3 ?? 0)) *
                element.numDays;

          case 4:
            total += (applyRound
                    ? (formatNumberRound((selectTarifa?.tarifaAdulto4 ?? 0))
                        .round())
                    : (selectTarifa?.tarifaAdulto4 ?? 0)) *
                element.numDays;

          default:
            total += 0;
        }
      }

      if (onlyChildren) {
        total += ((applyRound
                    ? (formatNumberRound((selectTarifa?.tarifaMenores7a12 ?? 0))
                        .round())
                    : (selectTarifa?.tarifaMenores7a12 ?? 0)) *
                element.numDays) *
            (habitacion.menores7a12 ?? 0);
      }
    }

    return total;
  }

  static double calculateDiscountTotal(
    List<TarifaXHabitacion> tarifasFiltradas,
    Habitacion habitacion,
    Categoria categoria,
    int totalDays, {
    String typeQuote = "individual",
    bool applyRoundFormatt = false,
  }) {
    double discountTotal = 0;

    for (var element in tarifasFiltradas) {
      discountTotal += calculateDiscountXTariff(
        element,
        habitacion,
        categoria,
        totalDays,
        typeQuote: typeQuote,
        applyRoundFormatt:
            !(element.tarifaXDia?.modificado ?? false) || applyRoundFormatt,
      );
    }

    return discountTotal;
  }

  static double calculateDiscountXTariff(
    TarifaXHabitacion element,
    Habitacion habitacion,
    Categoria categoria,
    int totalDays, {
    bool onlyDiscountUnitary = false,
    String typeQuote = "individual",
    bool useCashTariff = false,
    bool applyRoundFormatt = false,
  }) {
    double discount = 0;

    double totalAdults = getTotalCategoryRoom(
      element.tarifaXDia?.tarifaRack,
      habitacion,
      categoria,
      totalDays,
      withDiscount: false,
      // applyRoundFormat: applyRoundFormatt,
    );
    double totalChildren = getTotalCategoryRoom(
      element.tarifaXDia?.tarifaRack,
      habitacion,
      categoria,
      totalDays,
      withDiscount: false,
      isCalculateChildren: true,
      // applyRoundFormat: applyRoundFormatt,
    );

    double totalR = totalChildren + totalAdults;

    double descuento = element.tarifaXDia?.temporadaSelect?.descuento ??
        element.tarifaXDia?.descIntegrado ??
        0;

    double discountAdult = getPromotion(
      totalAdults,
      promocion: descuento,
      returnDouble: true,
      rounded: applyRoundFormatt,
    );

    double discountChildren = getPromotion(
      totalChildren,
      promocion: descuento,
      returnDouble: true,
      rounded: applyRoundFormatt,
    );

    discount = discountAdult + discountChildren;

    discount = (applyRoundFormatt
            ? formatNumberRound(totalR).roundToDouble()
            : totalR) -
        discount;

    if (onlyDiscountUnitary) return (discount) + 0.0;

    return (discount * element.numDays) + 0.0;
  }
}
