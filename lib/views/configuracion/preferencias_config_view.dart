import 'package:flutter/material.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/widgets/text_styles.dart';

import '../../ui/custom_widgets.dart';
import '../../utils/helpers/desktop_colors.dart';

class PreferenciasConfigView extends StatefulWidget {
  @override
  State<PreferenciasConfigView> createState() => _PreferenciasConfigViewState();
}

class _PreferenciasConfigViewState extends State<PreferenciasConfigView> {
  @override
  Widget build(BuildContext context) {
    double screenHight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: screenWidth < 1100 ? screenWidth : screenWidth * 0.33,
            height: screenWidth < 1100 ? null : screenHight * 0.85,
            child: CustomWidgets.containerCard(
              children: [
                Row(
                  mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextStyles.mediumText(
                      text: "Planes individuales en el sistema:",
                      color: DesktopColors.prussianBlue,
                    ),
                    Buttons.commonButton(onPressed: () {}, text: "Agregar")
                  ],
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Card(
                    color: Colors.grey[600],
                    margin: EdgeInsets.all(0),
                    elevation: 5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
