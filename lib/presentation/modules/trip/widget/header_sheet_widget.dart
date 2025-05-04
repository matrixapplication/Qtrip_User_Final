import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/resources/color.dart';
import 'package:q_trip_user/generated/locale_keys.g.dart';
import '../../../component/texts/black_texts.dart';

class HeaderSheetWidget extends StatelessWidget {
  const HeaderSheetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 5.paddingVert,
      decoration: BoxDecoration(
        color: blueColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            BlackRegularText(label: tr(LocaleKeys.enjoyYourTrip),fontSize: 13,fontWeight: FontWeight.w300),
            BlackBoldText(label: '${tr(LocaleKeys.q)}',fontSize: 13,labelColor: primaryColor,),
            BlackBoldText(label: ' ${tr(LocaleKeys.trip2)}',fontSize: 13,labelColor: blue2Color),
        ],
      )
    );
  }
}
