import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/generated/locale_keys.g.dart';
import 'package:q_trip_user/presentation/component/component.dart';
import 'package:q_trip_user/presentation/component/icon_widget.dart';
import 'package:q_trip_user/presentation/modules/delivery_profile/widgets/delivery_profile_item.dart';
import 'package:q_trip_user/presentation/modules/delivery_profile/widgets/delivery_review_item.dart';

import '../../../core/assets_constant/images.dart';
import '../../../domain/entities/driver_entity.dart';
import '../../../domain/entities/trip_entity.dart';
import '../../component/texts/black_texts.dart';
import '../trip/widget/user_view.dart';

class DeliveryProfileScreen extends StatelessWidget {
  final TripEntity tripEntity;
  const DeliveryProfileScreen({Key? key, required this.tripEntity, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  CustomAppBar(
        leading: IconWidget(
        onTap: (){
          Navigator.pop(context);
        },
        ),
      ),
      body: SingleChildScrollView(
        padding: 20.paddingHorizontal,
        child: Column(
          children: [
            34.height,
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
                   UserView(
                       isColum: true,
                       entity:
                       DriverEntity(
                         image:
                         tripEntity.driverImage??'',
                         name: tripEntity.driverName, id:int.parse( tripEntity.driverId.toString()), mobile: tripEntity.driverMobile, location: LatLng(0,0),)),
                   16.height,
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: [
                       10.width,
                       Expanded(child: DeliveryProfileItem(image: AppImages.star2, label: tr(LocaleKeys.rating), text: '${tripEntity.driverRate}',),),
                       10.width,
                       Expanded(child:  DeliveryProfileItem(image: AppImages.routing, label: tr(LocaleKeys.trips), text:'${tripEntity.driverAvgTrips}',),),
                       10.width,
                       Expanded(child: DeliveryProfileItem(image: AppImages.cal, label: tr(LocaleKeys.years), text: '${tripEntity.driverAvgYear}',),),
                       10.width,
                     ],
                   ),
                   16.height
                 ],
               ),

            ),
            24.height,
            Row(
              children: [
                SvgPicture.asset(AppImages.passen),
                8.width,
                BlackRegularText(label: 'Passenger Reviews',fontSize: 16,fontWeight: FontWeight.w300,)
              ],
            ),
            16.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DeliveryReviewItem(image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTsKcJ7LauQ9tyYsIUm3IKhiZJR1bKhZ4V8jw&s',
                  label: 'Excellent Driving',),
                DeliveryReviewItem(image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTsKcJ7LauQ9tyYsIUm3IKhiZJR1bKhZ4V8jw&s',
                  label: 'Very Friendly',),
                DeliveryReviewItem(image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTsKcJ7LauQ9tyYsIUm3IKhiZJR1bKhZ4V8jw&s',
                  label: 'Clean Car',),
              ],
            )
          ],
        ),
      ),
    );
  }
}
