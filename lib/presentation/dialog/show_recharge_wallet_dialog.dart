import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/data/injection.dart';
import 'package:q_trip_user/generated/locale_keys.g.dart';
import 'package:q_trip_user/presentation/component/inputs/custom_text_field_numeric.dart';
import '../../core/resources/values_manager.dart';
import '../../core/routing/navigation_services.dart';
import '../component/custom_button.dart';
import '../component/custom_text_field.dart';
import '../component/spaces.dart';
import '../component/texts/black_texts.dart';
import '../modules/setting/wallet/wallet_cubit.dart';
import 'base/simple_dialogs.dart';

Future showRechargeWalletDialog(BuildContext context,{String? mess, double? wallet,double? tripPrice}) async =>
    showCustomDialog(context, _buildBody(context,mess: mess,wallet: wallet,tripPrice: tripPrice), onDismissCallback: ()=>NavigationService.goBack() ,isCancellable: true);


_buildBody(BuildContext context,{String? mess ,double? wallet,double? tripPrice}) {
  TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final ValueNotifier<String?> validationMessage = ValueNotifier(null);

  return Padding(
    padding: EdgeInsets.symmetric(vertical: kScreenPaddingNormal.h),
    child: Container(
      color: Colors.white,
      margin: 16.paddingHorizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.clear, color: Colors.black, size: 25.r),
            ),
          ),

          if (mess != null)
            Column(
              children: [
               Center(
                 child:  BlackSemiBoldText(
                   label: mess,
                   fontSize: 16.sp,
                   textAlign: TextAlign.center,
                 ),
               ),
                VerticalSpace(8.h),
              ],
            ),

          // ✅ نص إرشادي
          if(wallet!=null && tripPrice!=null)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: BlackRegularText(
              label: tr(LocaleKeys.wallet_balance_info, namedArgs: {
                'wallet': '${wallet ?? 0}',
                'tripPrice': '${tripPrice ?? 0}'
              }),
              fontSize: 12.sp,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w300,
            ),
          ),

          BlackRegularText(
            label: tr(LocaleKeys.enterYourAmount),
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.center,
          ),
          8.height,

          // ✅ TextField مع Validator
          Form(
            key: formKey,
            child: CustomTextField(
              textInputType: TextInputType.number,
              hintText: tr(LocaleKeys.enterYourAmount),
              controller: controller,
              onChanged: (value) {
                print('value $value');
                final amount = double.tryParse(value);
                if (amount == null) {
                  validationMessage.value = tr(LocaleKeys.enter_valid_number);
                } else if ((wallet ?? 0) + amount < (tripPrice ?? 0)) {
                  validationMessage.value = tr(LocaleKeys.insufficient_funds);
                } else {
                  validationMessage.value = null;
                }
              },
              validationFunc: (value) {
                // if(wallet!=null && tripPrice!=null){
                //   if (value == null || value.isEmpty) {
                //     return tr(LocaleKeys.enter_amount_please);
                //   }
                //
                //   final enteredAmount = double.tryParse(value);
                //   if (enteredAmount == null) {
                //     return tr(LocaleKeys.enter_valid_number);
                //   }
                //
                //   final currentWallet = wallet ?? 0;
                //   final cost = tripPrice ?? 0;
                //   if ((currentWallet + enteredAmount) < cost) {
                //     return tr(LocaleKeys.insufficient_funds);
                //   }
                // }else{
                //   if (value == null || value.isEmpty) {
                //     return tr(LocaleKeys.enter_amount_please);
                //   }
                //   return null;
                // }



                return null;
              },
            ),
          ),
          ValueListenableBuilder<String?>(
            valueListenable: validationMessage,
            builder: (context, value, _) {
              if (value == null) return SizedBox.shrink();
              return Padding(
                padding: EdgeInsets.only(top: 8.h),
                child:
                BlackMediumText(
                  label: value,
                  fontSize: 12.sp,
                  labelColor: Colors.red,
                  textAlign: TextAlign.start,
                )
              );
            },
          ),
          20.height,

          CustomButton(
            onTap: () {
              if(validationMessage.value!=null && validationMessage.value!.isNotEmpty){
                return;
              }
              if (formKey.currentState!.validate()) {
                final bloc = getIt<WalletCubit>();
                Navigator.pop(context);
                bloc.rechargeWallet(
                  amount: double.parse(controller.text),
                  context: context,
                );
              }
            },
            raduis: 20,
            title: tr(LocaleKeys.pay),
            height: 35.h,
          ),
          12.height
        ],
      ),
    ),
  );
}