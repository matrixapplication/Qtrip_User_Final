import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:q_trip_user/core/assets_constant/images.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';
import 'package:q_trip_user/presentation/component/texts/black_texts.dart';
import '../../../../core/resources/color.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/routing/navigation_services.dart';
import '../../../../core/routing/navigation_services.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/contact_helper.dart';
import '../../../../domain/entities/driver_entity.dart';
import '../../../../domain/entities/trip_entity.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../component/custom_elevated_button.dart';
import '../../../component/icon_widget.dart';
import '../../../component/images/custom_image.dart';
import '../../../component/spaces.dart';
import '../../../component/texts/primary_texts.dart';
import '../trip_cubit.dart';
import 'driver_profile_widget.dart';
import 'driver_profile_widget2.dart';
import 'header_sheet_widget.dart';

class TripSheetView extends StatefulWidget {
  final TripEntity _entity;
  const TripSheetView({
    required TripEntity entity,
  }) : _entity = entity;


  @override
  State<TripSheetView> createState() => _TripSheetViewState();
}

class _TripSheetViewState extends State<TripSheetView> {
  String radioValue='0';
   @override
  void initState() {


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    DriverEntity? driver = context.watch<TripCubit>().state.driver;
    var driverArriveDuration = context.watch<TripCubit>().state.driverArriveDuration;
    double? driverArriveDistance = context.watch<TripCubit>().state.driverArriveDistance;
    // var driverDirectionEntity = context.watch<TripCubit>().state.driverDirectionEntity;

    return Padding(
        padding: EdgeInsets.all(kScreenPaddingNormal.r),
        child:
        SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(widget._entity.status == 'accepted' && driverArriveDuration!=null)
                Center(
                  child: BlackMediumText(label: '$driverArriveDuration ${tr(LocaleKeys.minutes)} , ${driverArriveDistance?.toStringAsFixed(1)??'0'} ${tr(LocaleKeys.km)} ',fontSize: 16,),
                ),
              4.height,
              if(widget._entity.status == 'accepted' && driverArriveDuration!=null)
                Center(
                  child:
                  BlackRegularText(label: '${tr(LocaleKeys.cancellationFeesWillApply)} 2 ${tr(LocaleKeys.minutes)} ${tr(LocaleKeys.fromTimeOrdering)}',fontSize: 13,fontWeight: FontWeight.w300),
                ),
              12.height,

              Center(
                child:
                HeaderSheetWidget()
              ),

              VerticalSpace(20.h),
              CustomDriverProfileWidget(tripEntity: widget._entity,),

              // 10.height,
              // if(widget._entity.vehicle !=null && widget._entity.vehicle?.brand!=null && widget._entity.vehicle!.brand.isNotEmpty)
              // Row(
              //   mainAxisSize: MainAxisSize.max,
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.end,
              //       children: [
              //         Text('${widget._entity.vehicle?.brand??''} ,${widget._entity.vehicle?.model} ,${widget._entity.vehicle?.vehicleTypeCategory}', style: const TextStyle().regularStyle(fontSize: 12)),
              //         Text('${widget._entity.vehicle?.manufacturingYear} ,${widget._entity.vehicle?.colorName}', style: const TextStyle().regularStyle(fontSize: 12)),
              //       ],
              //     ),
              //     10.width,
              //     CustomImage(imageUrl:widget._entity.vehicle?.image, radius: 12, height: 45.h, width: 80.w,fit: BoxFit.fill,),
              //   ],
              // ),
                24.height,
                ClipRRect(
               borderRadius: BorderRadius.circular(20),
               child:  Image.asset(AppImages.home5,width: double.infinity,height: 144.h,fit: BoxFit.cover,),
             ),
                12.height,
              // BlackMediumText(label: '   ${ widget._entity.price.toString()??''} ${LocaleKeys.currency.tr()}',fontSize: 13,),

            ],
          ),
        ));
  }
  getStatusText(){
    switch(widget._entity.status){
      case 'accepted':return tr(LocaleKeys.isOnTheWay);
      case 'driver_arrived':return tr(LocaleKeys.isArrived);
      case 'driver_arrived':return tr(LocaleKeys.isArrived);
      case 'start_trip':return tr(LocaleKeys.isStartTrip);
      case 'end_trip':return tr(LocaleKeys.isEndTrip);
    }
  }
}
