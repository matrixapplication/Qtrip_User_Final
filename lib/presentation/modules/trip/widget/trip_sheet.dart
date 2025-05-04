
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/color.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';
import 'package:q_trip_user/presentation/modules/trip/widget/searching_view.dart';
import 'package:q_trip_user/presentation/modules/trip/widget/trip_on_way_sheet_view.dart';


import '../../../../core/assets_constant/images.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../domain/entities/trip_entity.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../component/custom_button.dart';
import '../../../component/spaces.dart';
import '../../../component/texts/black_texts.dart';
import '../../../sheet/cancel_response_picker/cancel_response_picker_sheet.dart';
import '../../select_car/widgets/more_item.dart';
import '../trip_cubit.dart';
import 'trip_sheet_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TripSheet extends StatelessWidget {
  final TripEntity? _entity;
  const TripSheet({
    required TripEntity? entity,
  }) : _entity = entity;


  @override
  Widget build(BuildContext context) {
    TripState state = context.watch<TripCubit>().state;

    return  SafeArea(
      child:
       RefreshIndicator(
         onRefresh: () async {
           await Future.delayed(Duration(seconds: 1)).then((value) {
              context.read<TripCubit>().    getTimeArrived();
              // (context, _entity?.tripId??'0',tripEntity: _entity);

           });
         },
         child: DraggableScrollableSheet(

           initialChildSize:_getStatusHeight(),
           minChildSize:_getStatusHeight(),

           // initialChildSize: 0.5,
           // minChildSize: 0.5,
           maxChildSize:1,

           builder: (BuildContext context, ScrollController scrollController) {
             return SingleChildScrollView(
               physics:AlwaysScrollableScrollPhysics(),
               controller: scrollController,
               child: Container(
                 // height:deviceHeight,
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20),),
                     // boxShadow: [
                     //   BoxShadow(
                     //     color: Colors.grey.withOpacity(0.6),
                     //
                     //     spreadRadius: 1,
                     //     blurRadius: 5,
                     //     offset: const Offset(0, 3),
                     //   ),
                     // ],
                   ),
                   child:
                   SingleChildScrollView(
                     physics: NeverScrollableScrollPhysics(),
                     child:   Column(
                       children: [
                         VerticalSpace(kScreenPaddingNormal.h),
                         Container(
                           width: 80,
                           height: 4,
                           decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(2)),
                         ),
                         if(_entity!=null)
                           _entity?.driverId =='0' ? SearchingView(entity:_entity ):
                           Column(
                             children: [
                               _entity?.status=='start_trip'?
                               TripOnWaySheetView(entity: _entity!):
                               TripSheetView(entity: _entity!),
                               Container(
                                 padding: 10.paddingHorizontal+8.paddingVert,
                                 margin: 16.paddingHorizontal+8.paddingVert,
                                 decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(20),
                                     color: Colors.white,
                                     boxShadow: [
                                       BoxShadow(
                                           color: Colors.black38.withOpacity(0.1),
                                           blurRadius: 10,
                                           offset: Offset(8,5)
                                       )
                                     ]
                                 ),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     _entity?.status!='start_trip'?
                                     BlackMediumText(label: '   ${ _entity?.price.toString()??''} ${LocaleKeys.currency.tr()}',fontSize: 13,):SizedBox.shrink(),

                                     if(_entity?.paymentMethod=='cash')
                                       MoreItemWidget(
                                         endWidget:InkWell(
                                             onTap: (){},
                                             child:
                                             SizedBox()
                                           // SvgPicture.asset(AppImages.edit,width: 20,height: 20,fit: BoxFit.cover,),
                                         ),
                                         onTap: ()async{
                                           // PromoCodeEntity? promoCodeEntity=await  NavigationService.push(Routes.driverPromoScreen,arguments: { 'promo':  BlocProvider.of<SelectCarCubit>(context,listen: false).body.promoCodeEntity});
                                           // BlocProvider.of<SelectCarCubit>(context,listen: false).setPromoCode(promoCodeEntity);
                                         },
                                         svgIcon: AppImages.cash,
                                         label: tr(LocaleKeys.cash),
                                       ),
                                     if(_entity?.paymentMethod=='wallet')
                                       MoreItemWidget(
                                         endWidget:InkWell(
                                             onTap: (){},
                                             child:
                                             SizedBox()
                                           // SvgPicture.asset(AppImages.edit,width: 20,height: 20,fit: BoxFit.cover,),
                                         ),
                                         onTap: ()async{
                                           // PromoCodeEntity? promoCodeEntity=await  NavigationService.push(Routes.driverPromoScreen,arguments: { 'promo':  BlocProvider.of<SelectCarCubit>(context,listen: false).body.promoCodeEntity});
                                           // BlocProvider.of<SelectCarCubit>(context,listen: false).setPromoCode(promoCodeEntity);
                                         },
                                         svgIcon: AppImages.card,
                                         label: tr(LocaleKeys.onlinePayment),
                                       ),
                                     12.height,

                                     Column(
                                       children: [
                                         Row(
                                           children: [
                                             Container(
                                               height:8,
                                               width: 8,
                                               decoration:const BoxDecoration(shape: BoxShape.circle,color: primaryColor),
                                             ),
                                             HorizontalSpace(kFormPaddingAllSmall.h),
                                             Expanded(child: Text( _entity?.pickupAddress??'',style: const TextStyle().descriptionStyle(fontSize: 10).blackStyle().ellipsisStyle(),maxLines: 2)),
                                           ],
                                         ),
                                         VerticalSpace(kFormPaddingAllLarge.w),
                                         Row(
                                           children: [
                                             Container(
                                               height:8,
                                               width: 8,
                                               decoration:const BoxDecoration(shape: BoxShape.circle,color: blue2Color),
                                             ),
                                             HorizontalSpace(kFormPaddingAllSmall.h),
                                             Expanded(child: Text( _entity?.dropAddress??'',style: const TextStyle().descriptionStyle(fontSize: 10).blackStyle().ellipsisStyle(),maxLines: 2)),
                                           ],
                                         ),
                                       ],
                                     ),
                                     12.height,

                                     if(_entity?.status == 'accepted'||_entity?.status == 'driver_arrived'||_entity?.status == 'padding')
                                       Padding(
                                         padding: EdgeInsets.symmetric(horizontal: kFormPaddingAllLarge.r),
                                         child: CustomButton(
                                             boxShadow: true,
                                             color: Colors.white,
                                             textColor: Colors.red,
                                             loading: state.isLoading,
                                             onTap: () {
                                               if(_entity==null )return;
                                               showCancelResponsePicker(context, tripId: _entity!.tripId);
                                               // BlocProvider.of<TripCubit>(context,listen: false).cancelTrip();
                                             },
                                             title: tr(LocaleKeys.cancel)),
                                       ),
                                     20.height,
                                   ],
                                 ),
                               )
                             ],
                           ),
                         if(_entity?.status == 'padding')
                           Padding(
                             padding: EdgeInsets.all(kScreenPaddingNormal.r),
                             child: Column(
                               children: [
                                 Row(
                                   children: [
                                     Container(
                                       height:8,
                                       width: 8,
                                       decoration:const BoxDecoration(shape: BoxShape.circle,color: primaryColor),
                                     ),
                                     HorizontalSpace(kFormPaddingAllSmall.h),
                                     Expanded(child: Text( _entity?.pickupAddress??'',style: const TextStyle().descriptionStyle(fontSize: 10).blackStyle().ellipsisStyle(),maxLines: 2)),
                                   ],
                                 ),
                                 VerticalSpace(kFormPaddingAllLarge.w),
                                 Row(
                                   children: [
                                     Container(
                                       height:8,
                                       width: 8,
                                       decoration:const BoxDecoration(shape: BoxShape.circle,color: blue2Color),
                                     ),
                                     HorizontalSpace(kFormPaddingAllSmall.h),
                                     Expanded(child: Text( _entity?.dropAddress??'',style: const TextStyle().descriptionStyle(fontSize: 10).blackStyle().ellipsisStyle(),maxLines: 2)),
                                   ],
                                 ),
                               ],
                             ),
                           ),
                         VerticalSpace(kScreenPaddingLarge.h),
                         // _entity?.status == 'accepted'||_entity?.status == 'driver_arrived'
                         if(_entity?.status == 'padding' || _entity?.status==null || _entity?.status=='')
                           Padding(
                             padding: EdgeInsets.symmetric(horizontal: kFormPaddingAllLarge.r),
                             child: CustomButton(
                                 boxShadow: true,
                                 color: Colors.white,
                                 textColor: Colors.red,
                                 loading: state.isLoading,
                                 onTap: () {
                                   if(_entity==null )return;
                                   showCancelResponsePicker(context, tripId: _entity!.tripId);
                                   // BlocProvider.of<TripCubit>(context,listen: false).cancelTrip();
                                 },
                                 title: tr(LocaleKeys.cancel)),
                           ),
                         20.height,

                         // Expanded(
                         //   child: SingleChildScrollView(
                         //     physics: const BouncingScrollPhysics(),
                         //     child: Padding(
                         //       padding: EdgeInsets.all(kScreenPaddingNormal.r),
                         //       child: Column(
                         //
                         //         children: [
                         //           Text(tr(LocaleKeys.chooseCar),style: const TextStyle().regularStyle(),),
                         //           VerticalSpace(kScreenPaddingNormal.h),
                         //
                         //           MoreItemWidget(
                         //             svgIcon: Assets.svgPaymentIcon,
                         //             label: tr(LocaleKeys.payment),
                         //             desc: tr(LocaleKeys.chooseYourPaymentMethod),
                         //
                         //           ),
                         //           MoreItemWidget(
                         //             svgIcon: Assets.svgPromoCodeIcon,
                         //             label: tr(LocaleKeys.promoCode),
                         //           ),
                         //         ],
                         //       ),
                         //     ),
                         //   ),
                         // ),
                       ],
                     ),
                   )
               ),
             );
           },
         ),
       )
    );
  }

  double _getStatusHeight() {
    if (_entity == null) {
      return 0.0;
    } else if ((_entity?.driverId ?? '0') == '0') {
      return 0.45;
    } else {
      return 0.4;
    }
  }
}
