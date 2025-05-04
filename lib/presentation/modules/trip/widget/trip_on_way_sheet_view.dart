import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:q_trip_user/core/assets_constant/images.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/decoration.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';
import 'package:q_trip_user/presentation/component/icon_widget.dart';
import 'package:q_trip_user/presentation/component/texts/black_texts.dart';
import 'package:q_trip_user/presentation/modules/trip/widget/trip_details_widget.dart';

import '../../../../core/resources/values_manager.dart';
import '../../../../core/routing/navigation_services.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/contact_helper.dart';
import '../../../../domain/entities/driver_entity.dart';
import '../../../../domain/entities/trip_entity.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../component/custom_divider.dart';
import '../../../component/images/custom_image.dart';
import '../../../component/images/custom_person_image.dart';
import '../../../component/spaces.dart';
import '../../../component/text/icon_text.dart';
import '../../select_car/select_car_cubit.dart';
import '../../select_car/widgets/more_item.dart';
import '../trip_cubit.dart';
import 'driver_profile_widget.dart';
import 'driver_profile_widget2.dart';
import 'header_sheet_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';
class TripOnWaySheetView extends StatefulWidget {
  final TripEntity _entity;

  const TripOnWaySheetView({
    required TripEntity entity,
  }) : _entity = entity;

  @override
  State<TripOnWaySheetView> createState() => _TripSheetViewState();
}

class _TripSheetViewState extends State<TripOnWaySheetView> {
  @override
  void initState() {
    var cubit = context.read<TripCubit>();
    cubit.getTimeArrived();
    // cubit.getArrivedDistance();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
//You've reached
    int? arriveDuration = context.watch<TripCubit>().state.arriveDuration;
    double? arriveDistance = context.watch<TripCubit>().state.arriveDistance;
    final driverDirectionEntity = context.watch<TripCubit>().driverDirectionEntity;
    print('detailsEntity ${driverDirectionEntity?.durationText}');
    return Padding(
        padding: EdgeInsets.all(kScreenPaddingNormal.r),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderSheetWidget(),
              16.height,
              Center(
                child: BlackMediumText(
                  label: tr(LocaleKeys.YouAreYourWay),
                  fontSize: 20,
                ),
              ) ,
             //Rate your
              Center(
                child: BlackRegularText(
                  label: "${tr(LocaleKeys.YouGetYourDestination)} ${driverDirectionEntity?.durationText??''}.",
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                ),
              ),


              24.height,
               Container(
                 padding: 16.paddingHorizontal+16.paddingVert,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(20),
                   boxShadow: [
                     BoxShadow(
                       color: Colors.black.withOpacity(0.06),
                       blurRadius: 7,
                       offset: Offset(5,8)
                     )
                   ]
                 ),
                 child:
                 Skeletonizer(
                   enabled: driverDirectionEntity==null,
                   child:   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: [
                       TripDetailsWidget(
                         label: tr(LocaleKeys.distance),
                         text: '${driverDirectionEntity?.distanceText??''}',
                       ),
                       TripDetailsWidget(
                         label: tr(LocaleKeys.time),
                         text: '${driverDirectionEntity?.durationText??''}',
                       ),
                       TripDetailsWidget(
                         label: tr(LocaleKeys.price),
                         text: '${widget._entity.price??''} ${LocaleKeys.currency.tr()}',
                       ),
                       // Text('${widget._entity.vehicle?.image}'),
                       CustomImage(
                         imageUrl: widget._entity.driverImage??'',
                         radius: kFormRadiusLarge,
                         borderRadius:  BorderRadius.all(Radius.circular(kFormRadiusLarge)),
                         width: 45.w,
                         height: 45.w,
                         // height: 48.r,
                         // SvgPicture.asset(
                         //   AppImages.moto,

                       ),
                     ],
                   ),),


               ),
              16.height,

              CustomDriverProfileWidget(tripEntity: widget._entity,),
            ],
          ),
        ));
  }

}
