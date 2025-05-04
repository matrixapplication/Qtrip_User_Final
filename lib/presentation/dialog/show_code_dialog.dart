

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';

import '../../core/functions/get_andriod_vergion.dart';
import '../../core/resources/values_manager.dart';
import '../../core/routing/navigation_services.dart';
import '../../core/utils/show_toast.dart';
import '../../generated/assets.dart';
import '../component/custom_button.dart';
import '../component/texts/black_texts.dart';
import 'base/simple_dialogs.dart';

Future showCodeDialog(BuildContext context,) async =>
    showCustomDialog(context, _buildBody(context), onDismissCallback: ()=>NavigationService.goBack() ,isCancellable: true);


_buildBody(BuildContext context){
  return Padding(
    padding: EdgeInsets.symmetric(vertical: kScreenPaddingNormal.h),
    child: Container(
      color: Colors.white,
      margin: 16.paddingHorizontal,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
         Align(
           alignment: Alignment.centerRight,
           child:
           InkWell(
             onTap: (){
               Navigator.pop(context);
             },
             child: Icon(Icons.clear,color: Colors.black,size: 25.r,),
           ),
         ),
         16.height,
         // SvgPicture.asset(Assets.svgCode2,),
          16.height,
          BlackRegularText(label: 'Invite Friends',fontSize: 16.sp,fontWeight: FontWeight.w400,),
          8.height,
          BlackRegularText(label: 'Lorem ipsum dolor sit amet consectetur. Elit ultrices ',fontSize: 13.sp,fontWeight: FontWeight.w300,textAlign: TextAlign.center,),
          16.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const BlackRegularText(label: 'QT 55 787',fontSize: 23,),
              8.width,
              CustomButton(onTap: (){
                Clipboard.setData( const ClipboardData(text: 'QT 55 787')).then((_)async {
                  if (Platform.isAndroid) {
                    final res = await getAndroidVersion();
                    if (res.isNotEmpty) {
                      final androidVersion = int.parse(res);
                      if (androidVersion <= 10) {
                        showToast(
                          text:
                          'تم نسخ QT 55 787',
                          gravity: ToastGravity.TOP,
                        );
                      }
                    }
                    else {
                      showToast(
                        text:
                        'تم نسخ QT 55 787',
                        gravity: ToastGravity.TOP,
                      );
                    }
                  } else {
                    showToast(
                      text:
                      'تم نسخ QT 55 787',
                      gravity: ToastGravity.TOP,
                    );
                  }
                  context.pop();
                  //
                  // if(res.isNotEmpty){
                  // //   final androidVersion = int.parse(res);
                  // //   print(androidVersion);
                  // //   if(Platform.isAndroid){
                  // //   if (androidVersion <= 10) {
                  // //     showToast(text: '${LocaleKeys.copied.tr()} ${state.data?.code?.code ?? ''}', gravity:  ToastGravity.TOP,);
                  // //   }
                  // // }else{
                  // //     showToast(text: '${LocaleKeys.copied.tr()} ${state.data?.code?.code ?? ''}', gravity:  ToastGravity.TOP,);
                  // //   }
                  //
                  // }
                });
              },
                title: 'Copy',width: 90.w,height: 35.h,),
            ],
          )
        ],
      ),
    ),
  );
}