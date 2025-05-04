import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:q_trip_user/core/assets_constant/images.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/color.dart';
import 'package:q_trip_user/core/routing/navigation_services.dart';
import 'package:q_trip_user/core/routing/routes.dart';
import 'package:q_trip_user/presentation/component/texts/black_texts.dart';
import 'package:q_trip_user/presentation/modules/trip/widget/user_view.dart';

import '../../../../core/resources/values_manager.dart';
import '../../../../domain/entities/driver_entity.dart';
import '../../../../domain/entities/trip_entity.dart';
import '../../../component/images/custom_image.dart';

class DriverProfileWidget extends StatelessWidget {
  final DriverEntity? entity;
  final TripEntity tripEntity;
  final String? deliveryRate;
  const DriverProfileWidget({Key? key,  this.entity, this.deliveryRate, required this.tripEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        NavigationService.push(Routes.deliveryProfileScreen,arguments: {'tripEntity':tripEntity});
        },
      child:
      Container(
          padding: 16.paddingHorizontal+8.paddingVert,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(2, 6),
              ),
            ],
          ),
          child:
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: 12.paddingHorizontal+4.paddingVert,
                        decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius: BorderRadius.circular(10),

                        ),
                        child: BlackMediumText(label: '${tr('${tripEntity.vehicle?.vehicleTypeCategory??''}')}',fontSize: 13),
                      ),
                      2.height,
                      BlackRegularText(label: '${tripEntity.vehicle?.brand??''} ,${tripEntity.vehicle?.model??''}',fontSize: 13,textAlign: TextAlign.center,),
                      BlackRegularText(label: '${tripEntity.vehicle?.licensePlate??''} , ${tripEntity.vehicle?.colorName??''} ',fontSize: 13,),
                    ],
                  ),
                  CustomImage(
                    imageUrl: tripEntity.vehicle?.image,
                    radius: kFormRadiusLarge,
                    borderRadius:  BorderRadius.all(Radius.circular(kFormRadiusLarge)),
                    width: 50.w,
                    height: 50.h,
                    // height: 48.r,
                  ),
                  // SvgPicture.asset(AppImages.moto),
                ],
              ),

              8.height,
              Divider(
                endIndent: 40.w,
                indent: 40.w,
                color: dividerColor.withOpacity(0.2),),
              8.height,
              UserView(entity: entity,deliveryRate: deliveryRate,tripEntity:tripEntity),
              8.height,
            ],
          )
      ),
    );
  }
}
