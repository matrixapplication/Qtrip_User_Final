
import 'package:easy_localization/easy_localization.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/color.dart';
import '../../../../generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import '../../core/assets_constant/images.dart';

import '../../core/resources/styles.dart';
import '../../main.dart';
import 'package:html/parser.dart';

class CustomAppContData extends StatelessWidget {
  const CustomAppContData({super.key, required this.image, required this.des});
 final String image;
 final String des;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15.h,),
          Center(
            child: SizedBox(
                height: 130.w,
                width: 130.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child:
                  Image.asset(AppImages.logoW2)
                )),
          ),
          SizedBox(height: 35.h,),
          Text(
           LocaleKeys.appName.tr(),
            style: TextStyles.font16Regular.copyWith(
                color: Colors.black
            ),),
          16.height,
          Text(
            parse(des).outerHtml,
            style: TextStyles.font16Bold.copyWith(
                color: grayColor,
              fontWeight: FontWeight.w700
            ),
          textAlign: TextAlign.start,),
        ],
      ),
    );
  }
}
