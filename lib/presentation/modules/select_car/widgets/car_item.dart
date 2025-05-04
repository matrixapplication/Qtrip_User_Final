import 'package:flutter/material.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/decoration.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';
import 'package:q_trip_user/presentation/component/texts/black_texts.dart';

import '../../../../core/resources/color.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../domain/entities/vehicle_entity.dart';
import '../../../component/images/custom_image.dart';
import '../../../component/spaces.dart';
class VehicleItem extends StatelessWidget {
  final VehicleEntity _entity;
  final int? _selectedId;
  final ValueChanged<VehicleEntity> _onTap;

  const VehicleItem({
    required VehicleEntity entity,
    required int? selectedId,
    required ValueChanged<VehicleEntity> onTap,
  })  : _entity = entity,
        _selectedId = selectedId,
        _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>_onTap(_entity),
      child: Container(
        margin: 4.paddingHorizontal+8.paddingVert,
        padding: 8.paddingHorizontal+5.paddingVert,
        // height: 20.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: (_selectedId==_entity.id)?Theme.of(context).primaryColor:Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              // offset: const Offset(3, 6),
            ),
          ],

        ),
        // decoration:  BoxDecoration().listStyle().customColor(Theme.of(context).cardColor).borderStyle(color: (_selectedId==_entity.id)?Theme.of(context).primaryColor:Theme.of(context).hoverColor, width: 2),
        child:  Row(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            CustomImage(imageUrl: _entity.image,
              height: 56.w,
              width: 56.w,
              radius: 16,
            ),
            8.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                8.height,
                BlackMediumText(label:_entity.name,fontSize: 13.sp,labelColor: (_selectedId==_entity.id)?   Colors.white:blackColor,),
                5.height,
                BlackMediumText(label: '${_entity.priceAfterDiscount} EGP',fontSize: 12.sp,labelColor:blue4Color),
                // BlackRegularText(label: 'Arrive in 30 M',fontSize: 13.sp,labelColor:  (_selectedId==_entity.id)?   Colors.white:blackColor,fontWeight: FontWeight.w300,),
              ],
            )
          ],
        ),
      ),
    );
  }


}
