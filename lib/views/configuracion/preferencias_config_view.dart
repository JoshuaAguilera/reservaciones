import 'package:flutter/material.dart';
import 'package:generador_formato/widgets/text_styles.dart';

import '../../ui/custom_widgets.dart';
import '../../utils/helpers/web_colors.dart';

class PreferenciasConfigView extends StatefulWidget {
  @override
  State<PreferenciasConfigView> createState() =>
      _PreferenciasConfigViewState();
}

class _PreferenciasConfigViewState
    extends State<PreferenciasConfigView> {
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
                TextStyles.mediumText(
                    text: "Planes individuales en el sistema:",
                    color: DesktopColors.prussianBlue),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
