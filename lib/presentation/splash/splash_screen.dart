import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/color.dart';

import 'package:q_trip_user/core/routing/navigation_services.dart';
import 'package:q_trip_user/core/routing/routes.dart';
import 'package:q_trip_user/generated/assets.dart';
import '../../../core/resources/values_manager.dart';
import '../../core/assets_constant/images.dart';
import '../../core/utils/language_helper.dart';
import '../../domain/provider/local_auth_cubit.dart';
import '../../generated/locale_keys.g.dart';
import '../component/custom_button.dart';
import '../component/texts/black_texts.dart';
import '../dialog/show_langauge_dialog.dart';



class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  with SingleTickerProviderStateMixin{
  late final LocalAuthCubit _viewModel;
  _playAnimation() async{
    Timer(const Duration(seconds: 1), () async {
      _route(context);
    });
  }

  final box = GetStorage();

  @override
  void initState() {
    _viewModel = BlocProvider.of<LocalAuthCubit>(context, listen: false);
    // BlocProvider.of<LayoutCubit>(context).initGoogleMap();
    super.initState();
    _playAnimation();
  }
  bool? isShowLanguage=false;
  void _route(context) async{
    bool? isSelectedLanguage =  box.read('isSelectedLanguage6');
    Timer(const Duration(seconds: 2), () async {
      bool isAuthed = await _viewModel.isLogin();
      if (isAuthed) {
        NavigationService.pushNamedAndRemoveUntil( Routes.driverHomeScreen);
      }else{
        print('asdadssa ${isSelectedLanguage}');
          if(isSelectedLanguage==null){
             setState(() {
               isShowLanguage=true;
             });
          }else{
            NavigationService.pushNamedAndRemoveUntil( Routes.onBoardingScreen);
          }

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool? isAr = kIsArabic;

    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        width:deviceWidth,
        height: deviceHeight,
          alignment: Alignment.center,
          // child: Text('Logo',style:const TextStyle().titleStyle(fontSize: 42).colorWhite(),),
        child: Stack(
          children: [
            Image.asset(
              // width:deviceWidth,
              // height: deviceHeight,
              fit: BoxFit.fill,
                width:  deviceWidth,
             AppImages.imagesSplashBackground
            ),
            Positioned(
              top: MediaQuery.sizeOf(context).height*0.43,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(Assets.imagesLogo2,),
                  // Text('Driver',style:const TextStyle().titleStyle(fontSize: 32).blackStyle(),),
                ],
              ),
            ),
            if(isShowLanguage==true)
            Positioned(
              bottom: 20,
              left: 10,
              right: 10,
              child:   StatefulBuilder(
                builder: (context, setState) {
                  return Container(
                    // color: Colors.white,
                    margin: 16.paddingHorizontal+16.paddingVert,
                    padding: 16.paddingVert,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 7,
                              offset: Offset(3,5)
                          )
                        ]
                    ),
                    child:
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        10.height,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: 16.paddingHorizontal,
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.black,
                                  size: 25.r,
                                ),
                              ),
                            ),
                            70.width,
                            Container(
                              height: 4.h,
                              width: 72.w,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(4)
                              ),
                            )
                          ],
                        ),
                        20.height,
                        BlackRegularText(
                          label: tr(LocaleKeys.selectLanguage),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        Column(
                          children: [
                            RadioListTile(
                              title: BlackRegularText(
                                label: tr(LocaleKeys.arabic),
                                fontSize: 16.sp,
                              ),
                              value: true,
                              groupValue: isAr,
                              onChanged: (bool? value) {
                                setState(() {
                                  isAr = value!;
                                });
                              },
                            ),
                            RadioListTile(
                              title: BlackRegularText(
                                label: tr(LocaleKeys.english),
                                fontSize: 16.sp,
                              ),
                              value: false,
                              groupValue: isAr,
                              onChanged: (bool? value) {
                                setState(() {
                                  isAr = value!;
                                });
                              },
                            ),
                            12.height,
                            Container(
                              margin: 16.paddingHorizontal,
                              child: CustomButton(


                                onTap: () async {
                                  box.write('isSelectedLanguage6',true);

                                  if (isAr == true) {
                                    await context.setLocale(const Locale('ar')).then((value) {
                                      setState(() {}); // تحديث النصوص
                                      Future.delayed(const Duration(milliseconds: 1), () {
                                        NavigationService.pushNamedAndRemoveUntil(Routes.onBoardingScreen);
                                      });

                                    });
                                  } else {
                                    await context.setLocale(const Locale('en')).then((value) {
                                      setState(() {}); // تحديث النصوص
                                      Future.delayed(const Duration(milliseconds: 1), () {
                                        NavigationService.pushNamedAndRemoveUntil(Routes.onBoardingScreen);
                                      });
                                    });
                                  }
                                  //

                                },
                                raduis: 12,
                                title: tr(LocaleKeys.confirm),
                                width: double.infinity,
                                height: 40.h,
                              ),
                            ),
                            8.height,
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),)

          ],
        ),
      ),
    );
  }
}


