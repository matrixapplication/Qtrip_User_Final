
import 'package:flutter/material.dart';
import 'package:q_trip_user/core/assets_constant/images.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/decoration.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';
import 'package:q_trip_user/presentation/component/texts/black_texts.dart';

import '../../../../../core/resources/resources.dart';
import '../../../../../domain/entities/notification_entity.dart';
import '../../../../../generated/assets.dart';
import '../../../../component/component.dart';


class NotificationItem extends StatelessWidget {

  final NotificationEntity _entity ;


  const NotificationItem({super.key,
    required NotificationEntity entity,
  }) : _entity = entity;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: 5.paddingVert+5.paddingHorizontal,

      decoration:  BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(2, 5), // changes position of shadow
          ),
        ],
      ),
      padding: 16.paddingAll,
      // height: 68.h,

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // height: 68.h,
            alignment: Alignment.center,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: SVGIcon(
                  AppImages.notification,
                  width: 32.r,
                  height: 32.r,
                ),
              ),
            ),
          ),
          8.width,
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kFormPaddingAllSmall.w, vertical: kFormPaddingAllLarge.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlackRegularText(label: _entity.title,fontSize: 16,),
                  4.height,
                  BlackRegularText(label: _entity.text,fontSize: 13,fontWeight: FontWeight.w300,),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
