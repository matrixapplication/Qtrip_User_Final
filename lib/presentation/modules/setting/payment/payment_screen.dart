import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/color.dart';
import 'package:q_trip_user/presentation/component/texts/black_texts.dart';
import '../../../../core/routing/routes.dart';
import '../../../../generated/assets.dart';
import '../../../component/custom_app_bar.dart';
import '../../../component/custom_button.dart';
import '../../../component/custom_text_row.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title:'Payment',isCenterTitle:  true,),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: 16.paddingHorizontal+8.paddingVert,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              24.height,
              Container(
                padding: 24.paddingAll,
                decoration: BoxDecoration(
                  color: backGroundWhite,
                  borderRadius: BorderRadius.circular(36.r),
                ),
                child: Column(
                  children: [
                     SvgPicture.asset(Assets.svgWallet2,width: 35.w,height: 35.h,),
                     8.height,
                     BlackBoldText(label: '0.00 EGP',fontSize: 23.sp,labelColor: purpleColor,),
                     BlackRegularText(label: 'Your Balance',fontSize: 16.sp,fontWeight: FontWeight.w300,textAlign: TextAlign.center,),
                     8.height,

                    CustomButton(
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Icon(Icons.add,color: Colors.white,),
                           8.width,
                           BlackRegularText(label: 'Add Money',fontSize: 16.sp,fontWeight: FontWeight.w500,labelColor: Colors.white,),
                         ],
                       ),
                     onTap: (){},),

                  ],
                ),
              ),
              26.height,
              CustomTextRowWidget(title: 'Payment History',onTap: (){
                context.pushNamed(Routes.walletScreen);
              },
              color: blackColor,
              ),
              10.height,
              CustomTextRowWidget(title: 'Payment Methods',onTap: (){
                // context.pushNamed(Routes.paymentMethodScreen);
              },
                color: blackColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
