import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';
import 'package:q_trip_user/presentation/component/images/custom_image.dart';
import '../../../../../core/routing/navigation_services.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/utils/contact_helper.dart';
import '../../../../../domain/entities/trip_entity.dart';
import '../../../../core/assets_constant/images.dart';
import '../../../../core/resources/color.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../domain/entities/driver_entity.dart';
import '../../../component/icon_widget.dart';
import '../../../component/images/custom_person_image.dart';
import '../../../component/spaces.dart';

class UserView extends StatelessWidget {
  final DriverEntity? _entity;
  final String? deliveryRate;
  final bool? isColum;
  final TripEntity? tripEntity;

  const UserView({
    super.key,
    required DriverEntity? entity,
    this.deliveryRate,
    this.isColum,
    this.tripEntity,
  }) : _entity = entity;

  @override
  Widget build(BuildContext context) {
    return
      Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomImage(
            imageUrl: _entity?.image, radius: 50, height: 60.h, width: 60.w),
        // CustomPersonImage(imageUrl: _entity?.image, size: 50.r),
        HorizontalSpace(kFormPaddingAllLarge.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(' ${_entity?.name ?? ''}',
                style: const TextStyle().regularStyle()),
            if (isColum == null)
              Row(
                children: [
                  Icon(
                    Icons.star_border,
                    color: primaryColor,
                  ),
                  4.width,
                  Text(deliveryRate ?? '',
                      style: const TextStyle().regularStyle(fontSize: 13))
                ],
              )
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconWidget(
                    onTap: () {
                      if ((_entity?.mobile ?? '').isNotEmpty) {
                        ContactHelper.launchCall(_entity!.mobile);
                      }
                    },
                    height: 50.h,
                    width: 50.w,
                    icon: Icons.call,
                  ),
                  IconWidget(
                    onTap: () {
                      print('sdf_entity ${tripEntity?.tripId ?? ''}');
                      if (tripEntity?.tripId != null) {
                        NavigationService.push(Routes.chatScreen,
                            arguments: {'entity': tripEntity});
                      }
                    },
                    height: 50.h,
                    width: 50.w,
                    widget: SvgPicture.asset(
                      AppImages.sms,
                    ),
                  ),
                ],
              ),
          ],
        ),
        if (isColum == null)
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Spacer(),
                IconWidget(
                  onTap: () {
                    if ((_entity?.mobile ?? '').isNotEmpty) {
                      ContactHelper.launchCall(_entity!.mobile);
                    }
                  },
                  height: 50.h,
                  width: 50.w,
                  icon: Icons.call,
                ),
                IconWidget(
                  onTap: () {
                    print('sdf_entity ${tripEntity?.tripId ?? ''}');
                    if (tripEntity?.tripId != null) {
                      NavigationService.push(Routes.chatScreen,
                          arguments: {'entity': tripEntity});
                    }

                  },
                  height: 50.h,
                  width: 50.w,
                  widget: SvgPicture.asset(
                    AppImages.sms,
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }
}
