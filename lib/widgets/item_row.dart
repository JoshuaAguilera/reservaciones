import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/models/numero_cotizacion_model.dart';
import 'package:generador_formato/utils/helpers/utility.dart';

import '../utils/helpers/web_colors.dart';
import 'text_styles.dart';

class ItemRow {
  static Widget statusQuoteRow(NumeroCotizacion register) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        gradient: LinearGradient(
          colors: Utility.getGradientQuote(register.tipoCotizacion),
          end: Alignment.topCenter,
          begin: Alignment.bottomCenter,
        ),
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 15),
      width: double.infinity,
      height: 110,
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Utility.getIconCardDashboard(register.tipoCotizacion),
                size: 38,
                color: Colors.white,
              ),
              TextStyles.TextTitleList(
                  index: register.numCotizaciones,
                  color: Colors.white,
                  size: 30,
                  isBold: false),
            ],
          ),
          TextStyles.mediumText(
            text: register.tipoCotizacion ?? '',
            color: Colors.white,
            size: 15,
          )
        ],
      ),
    );
  }
}
