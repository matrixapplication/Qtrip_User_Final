import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/color.dart';
import 'package:q_trip_user/presentation/component/texts/black_texts.dart';
import '../../../../generated/assets.dart';
import '../../../component/custom_app_bar.dart';
import '../../../component/custom_button.dart';
import '../../../component/custom_text_row.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title:'Payment Methods',isCenterTitle:  true,),
      body:
      SafeArea(
        child: SingleChildScrollView(
          padding: 16.paddingHorizontal+8.paddingVert,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              24.height,
              const BlackRegularText(label: 'Lorem ipsum dolor sit amet consectetur. Consectetur non tincidunt.',fontSize: 16,),
              26.height,
              CustomTextRowWidget(image: Assets.svgWallet2,title: 'E-Wallet',onTap: (){},),
              16.height,
              CustomTextRowWidget(image: Assets.svgBanck,title: 'Bank Account',onTap: (){},),
            ],
          ),
        ),
      ),
    );
  }
}
