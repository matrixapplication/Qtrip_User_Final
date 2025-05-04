import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';

import '../../../../../../core/assets_constant/images.dart';
import '../../core/resources/styles.dart';


class CustomNotFoundDataWidget extends StatelessWidget {
  const CustomNotFoundDataWidget({super.key, required  this.title, required this.type, required this.image});
  final String image;
  final String title;
  final String type;
  @override
  Widget build(BuildContext context) {
    return
      Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        type=='png'?
        Expanded(child: Image.asset(image)):
        Expanded(child: SvgPicture.asset(image,)),
        Text('${title}',
            style: TextStyles.font16Bold.copyWith(
                color: Colors.black.withOpacity(0.6)
            ),
        ),
       100.height,
      ],
    );
  }
}
