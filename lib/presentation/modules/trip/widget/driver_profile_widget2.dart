import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:q_trip_user/core/assets_constant/images.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/color.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';
import 'package:q_trip_user/core/routing/navigation_services.dart';
import 'package:q_trip_user/core/routing/routes.dart';
import 'package:q_trip_user/presentation/component/texts/black_texts.dart';
import 'package:q_trip_user/presentation/modules/trip/widget/user_view.dart';

import '../../../../core/resources/values_manager.dart';
import '../../../../core/utils/contact_helper.dart';
import '../../../../domain/entities/driver_entity.dart';
import '../../../../domain/entities/trip_entity.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../component/icon_widget.dart';
import '../../../component/images/custom_image.dart';
import '../../../component/spaces.dart';
import '../trip_cubit.dart';

class CustomDriverProfileWidget extends StatelessWidget {
  final TripEntity tripEntity;
  const CustomDriverProfileWidget({Key? key,   required this.tripEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit =context.read<TripCubit>();

    return InkWell(
      onTap: (){
        // NavigationService.push(Routes.deliveryProfileScreen,arguments: {'tripEntity':tripEntity});
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
              if(tripEntity.vehicle !=null && tripEntity.vehicle?.brand!=null && tripEntity.vehicle!.brand.isNotEmpty)

                Column(
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomImage(
                          imageUrl: tripEntity.vehicle?.image,
                          radius: kFormRadiusLarge,
                          borderRadius:  BorderRadius.all(Radius.circular(kFormRadiusLarge)),
                          width: 50.w,
                          height: 50.h,
                          fit: BoxFit.cover,
                          // height: 48.r,
                        ),
                        8.width,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      2.height,
                                      BlackRegularText(label: '${tripEntity.vehicle?.brand??''} ,${tripEntity.vehicle?.model??''}',fontSize: 15,textAlign: TextAlign.center,),
                                      BlackRegularText(label: '${tripEntity.vehicle?.licensePlate??''} , ${tripEntity.vehicle?.colorName??''}',fontSize: 15,),

                                    ],
                                  ),
                                  Container(
                                    padding: 12.paddingHorizontal+4.paddingVert,
                                    decoration: BoxDecoration(
                                      color: blueColor,
                                      borderRadius: BorderRadius.circular(10),

                                    ),
                                    child: BlackMediumText(label: '${tr('${tripEntity.vehicle?.vehicleTypeCategory??''}')}',fontSize: 14),
                                  ),
                                ],
                              ),
                             ],
                          ),
                        )

                        // SvgPicture.asset(AppImages.moto),
                      ],
                    ),
                    8.height,
                    Divider(
                      endIndent: 40.w,
                      indent: 40.w,
                      color: dividerColor.withOpacity(0.2),),
                    8.height,
                  ],
                ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Padding(padding: EdgeInsets.only(bottom: 12),
                        child:
                        CustomImage(imageUrl:tripEntity.driverImage, radius: 50, height: 45.h, width: 45.w),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(kFormRadiusLarge),
                              ),
                              padding: EdgeInsets.all(2.r),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 17,
                                  ),
                                  BlackRegularText(label: tripEntity.driverRate??'',fontSize: 13,),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                  HorizontalSpace(kFormPaddingAllLarge.h),
                  Expanded(child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tripEntity.driverName??'', style: const TextStyle().regularStyle()),
                      Row(
                        children: [
                          Icon(
                            Icons.social_distance,
                            color: primaryColor,
                          ),
                          4.width,
                          Text( '${tripEntity.distance} ${LocaleKeys.km}', style: const TextStyle().regularStyle(fontSize: 10))
                        ],
                      ),

                    ],
                  ),),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // const Spacer(),
                      IconWidget(
                        onTap: (){
                          if ((tripEntity.driverMobile ?? '').isNotEmpty) {
                            ContactHelper.launchCall(tripEntity.driverMobile);
                          }
                        },
                        height: 40.h,
                        width: 40.w,
                        icon: Icons.call,
                      ),
                      Stack(
                        children: [
                          IconWidget(
                            onTap: () {
                              if ((tripEntity.tripId ?? '').isNotEmpty) {
                                NavigationService.push(Routes.chatScreen, arguments: {'entity':tripEntity});
                              }
                            },
                            height: 50.h,
                            width: 50.w,
                            widget: SvgPicture.asset(AppImages.sms,),
                          ),

                          // Badge for unread messages
                          Positioned(
                            top: 0,
                            right: 5,
                            child: StreamBuilder<int>(
                              stream:cubit.getUnReadMessageCount(tripEntity.tripId ?? ''),
                              builder: (context, snapshot) {
                                int unreadCount = snapshot.data ?? 0;
                                if (unreadCount == 0) return const SizedBox(); // Hide if no unread messages

                                return Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 20,
                                    minHeight: 20,
                                  ),
                                  child: Text(
                                    unreadCount.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )

                    ],
                  )

                ],
              ),


              8.height,
            ],
          )
      ),
    );
  }
}
