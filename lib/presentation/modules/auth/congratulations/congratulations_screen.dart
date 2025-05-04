import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/generated/locale_keys.g.dart';

import '../../../../core/assets_constant/images.dart';
import '../../../../core/routing/routes.dart';
import '../../../component/custom_button.dart';
import '../../../component/images/custom_logo.dart';
import '../../../component/texts/black_texts.dart';

class CongratulationsScreen extends StatelessWidget {
  const CongratulationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child:
            SingleChildScrollView(
              padding: 20.paddingHorizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  40.height,
                  CustomLogo(
                    height: 75.h,
                    width: 135.w,
                  ),
                  16.height,
                  SvgPicture.asset(AppImages.cong,),
                  32.height,
                  BlackBoldText(label: tr(LocaleKeys.congratulations),fontSize: 26.sp,textAlign: TextAlign.center,),
                  8.height,
                  BlackRegularText(label: tr(LocaleKeys.YourAccountSuccessfully),fontSize:16.sp ,fontWeight: FontWeight.w300,textAlign: TextAlign.center,),
                  32.height,
                  CustomButton(
                    onTap: () {
                      context.pushNamed(Routes.driverHomeScreen);
                    },
                    title: tr(LocaleKeys.getStarted),
                  ),
                  20.height,

                ],
              ),
            )
        )
    );
  }

}
