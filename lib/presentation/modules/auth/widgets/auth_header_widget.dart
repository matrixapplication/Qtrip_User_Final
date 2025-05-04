import 'package:flutter/material.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';

import '../../../component/icon_widget.dart';
import '../../../component/images/custom_logo.dart';
import '../../../component/spaces.dart';
import '../../../component/texts/black_texts.dart';

class AuthHeaderWidget extends StatelessWidget {
  final String? title;
  const AuthHeaderWidget({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconWidget(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          onTap: ()=>context.pop(),
        ),
       Expanded(child:  Column(
         children: [
           VerticalSpace(30.h),
           BlackMediumText(label: title??''),
         ],
       ),)  ,
        Padding(padding: 10.paddingAll,
        child: CustomLogo(
          fit: BoxFit.contain,
          height: 40.h,
          width: 90.w,
        ),
        )

      ],
    );
  }
}
