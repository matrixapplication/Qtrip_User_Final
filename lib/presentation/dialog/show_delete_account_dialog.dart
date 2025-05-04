

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/color.dart';
import 'package:q_trip_user/generated/locale_keys.g.dart';

import '../../core/functions/get_andriod_vergion.dart';
import '../../core/resources/values_manager.dart';
import '../../core/routing/navigation_services.dart';
import '../../core/routing/routes.dart';
import '../../core/utils/show_toast.dart';
import '../../domain/provider/local_auth_cubit.dart';
import '../../generated/assets.dart';
import '../component/custom_button.dart';
import '../component/texts/black_texts.dart';
import 'base/simple_dialogs.dart';

Future showDeleteAccountDialog(BuildContext context,) async =>
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
          BlackRegularText(label: tr(LocaleKeys.deleteAccount),fontSize: 16.sp,fontWeight: FontWeight.w400,),
          8.height,
          BlackRegularText(label:tr(LocaleKeys.deleteAccountMess),fontSize: 13.sp,fontWeight: FontWeight.w300,textAlign: TextAlign.center,),
          16.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(

                color: Colors.white,
                textColor: primaryColor,
                onTap: (){
                  _onDeletePress(context);
              },
                raduis: 50,
                title:  tr(LocaleKeys.deleteYes),width: 100.w,height: 35.h,),
              8.width,
              CustomButton(onTap: (){
                context.pop();
              },
                raduis: 50,
                title: tr(LocaleKeys.cancel),width: 100.w,height: 35.h,),
            ],
          )
        ],
      ),
    ),
  );
}

_onDeletePress(BuildContext context) {
  BlocProvider.of<LocalAuthCubit>(context, listen: false).deleteAccount(context);
}