import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_trip_user/core/assets_constant/images.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/generated/locale_keys.g.dart';
import 'package:q_trip_user/presentation/component/component.dart';
import 'package:q_trip_user/presentation/component/texts/black_texts.dart';
import 'package:q_trip_user/presentation/component/texts/primary_texts.dart';

import '../../../../core/resources/color.dart';
import '../../../../core/resources/styles.dart';
import '../../../../core/routing/routes.dart';
import '../../../component/images/custom_logo.dart';
import '../../home/home_cubit.dart';
class LogAsScreen extends StatefulWidget {
  const LogAsScreen({super.key});

  @override
  State<LogAsScreen> createState() => _LogAsScreenState();
}

class _LogAsScreenState extends State<LogAsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context, listen: false).initGoogleMap();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding:75.paddingTop,
            child: SingleChildScrollView(
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomLogo(
                    height: 70.h,
                    fit: BoxFit.contain,
                    width: 168.w,
                  ),
                  const VerticalSpace(8),
                  Text(
                    tr(LocaleKeys.welcomeLogAs),
                    textAlign: TextAlign.center,
                    style: TextStyles.font16Regular.copyWith(fontSize: 18.sp,fontWeight: FontWeight.w300,color: blackColor,height: 1.2),
                  ),
                  const VerticalSpace(30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child:  Image.asset(
                      AppImages.log,
                    ),
                  ),
                  const VerticalSpace(30),
                  PrimaryBoldText(label: tr(LocaleKeys.welcomeLogAs2),fontSize: 26,textAlign: TextAlign.center,),
                  const VerticalSpace(16),
                  BlackRegularText(label: tr(LocaleKeys.welcomeLogAs3),fontSize: 20,labelStyle: TextStyles.font16Regular.copyWith(fontWeight: FontWeight.w300,fontSize: 20,),textAlign: TextAlign.center,),
                  const VerticalSpace(16),
                  Padding(
                    padding: 16.paddingHorizontal,
                    child: Column(
                      children: [
                        CustomButton(
                          onTap: (){
                            context.pushNamed(Routes.loginScreen);
                          },
                          title: tr(LocaleKeys.logIn),
                          height: 44.h,),
                        const VerticalSpace(12),
                        CustomButton(
                          color: Colors.white,
                          textColor: primaryColor,
                          onTap: (){
                            context.pushNamed(Routes.registerScreen);

                          },title: tr(LocaleKeys.signUp),height: 44.h,),
                      ],
                    ),
                  )


                ],
              ),
            )
        )
    );
  }

}

