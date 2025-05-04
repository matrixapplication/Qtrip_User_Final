
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/routing/navigation_services.dart';
import 'package:q_trip_user/core/routing/routes.dart';
import 'package:q_trip_user/generated/locale_keys.g.dart';
import '../../domain/provider/local_auth_cubit.dart';
import 'base/simple_dialogs.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/resources/color.dart';
import '../../core/resources/values_manager.dart';
import '../component/custom_button.dart';
import '../component/texts/black_texts.dart';

Future showLogOutDialog(BuildContext context,) async =>
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
          BlackRegularText(label: tr(LocaleKeys.logOut),fontSize: 16.sp,fontWeight: FontWeight.w400,),
          8.height,
          BlackRegularText(label: tr(LocaleKeys.logOutMess),fontSize: 13.sp,fontWeight: FontWeight.w300,textAlign: TextAlign.center,),
          16.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Expanded(child:   CustomButton(

              color: Colors.white,
              textColor: primaryColor,
              onTap: (){
                _onLogoutPress(context);
              },
              raduis: 50,
              title: tr(LocaleKeys.yesLogOut),width: 150.w,height: 35.h,),),
              8.width,
              CustomButton(onTap: (){
                context.pop();
              },
                raduis: 50,
                title:tr(LocaleKeys.cancel),width: 90.w,height: 35.h,),
            ],
          )
        ],
      ),
    ),
  );
}


// Future<bool?> showLogoutDialog(BuildContext context) async {
//
//   return await showQuestionDialog(
//     context,
//     btnTextPositive: tr(LocaleKeys.no),
//     btnTextNegative: tr(LocaleKeys.yes),
//     question: tr(LocaleKeys.wantToSignOut),
//     onNegativeClick: ()=> _onLogoutPress(context),
//     onPositiveClick: () {},
//   );
// }

_onLogoutPress(BuildContext context) {
  BlocProvider.of<LocalAuthCubit>(context, listen: false).logOut().then((isLogOut) {
    if (isLogOut) {
      Navigator.pop(context);
      NavigationService.pushNamedAndRemoveUntil(Routes.loginScreen);
    }
  });
}