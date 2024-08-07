import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:generador_formato/models/numero_cotizacion_model.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/utils/helpers/utility.dart';

import 'text_styles.dart';

class ItemRow {
  static Widget statusQuoteRow(NumeroCotizacion register) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        gradient: LinearGradient(
          colors: Utility.getGradientQuote(register.tipoCotizacion),
          end: Alignment.centerRight,
          begin: Alignment.centerLeft,
        ),
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 15),
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: Icon(
              Utility.getIconCardDashboard(register.tipoCotizacion),
              size: 55,
              color: Utility.getColorRegisterQuote(register.tipoCotizacion!),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextStyles.standardText(
                text: register.tipoCotizacion ?? '',
                color: Colors.white,
                size: 13,
                overClip: true,
              ),
              const SizedBox(height: 15),
              TextStyles.TextTitleList(
                index: register.numCotizaciones,
                color: Colors.white,
                size: 30,
                isBold: false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget dayRateRow(
      {required BuildContext context,
      required int day,
      int? initDay,
      int? lastDay}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {},
        child: (initDay != null && (day + 1) < initDay) ||
                (lastDay != null && (day + 1) > lastDay + 3)
            ? SizedBox(
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned(
                        child:
                            TextStyles.TextSpecial(day: day + 1, subtitle: ""))
                  ],
                ),
              )
            : SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 5,
                  color: Theme.of(context).primaryColorDark,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextStyles.TextSpecial(
                            day: (day + 1) - (initDay! - 1),
                            subtitle: dayNames[day],
                            sizeTitle: 28,
                            colorsubTitle: Theme.of(context).primaryColor,
                            colorTitle: Theme.of(context).dividerColor,
                            sizeSubtitle: 15),
                        const SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextStyles.TextAsociative(
                                "Adulto: ", Utility.formatterNumber(0),
                                boldInversed: true,
                                size: 11,
                                color: Theme.of(context).primaryColor),
                            TextStyles.TextAsociative(
                                "Men. 7 a 12: ",
                                boldInversed: true,
                                size: 11,
                                Utility.formatterNumber(0),
                                color: Theme.of(context).primaryColor),
                            TextStyles.TextAsociative(
                                "Pax adic.: ",
                                boldInversed: true,
                                size: 11,
                                Utility.formatterNumber(0),
                                color: Theme.of(context).primaryColor),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
