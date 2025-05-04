
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/color.dart';
import 'package:q_trip_user/core/resources/decoration.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';
import 'package:q_trip_user/presentation/component/component.dart';
import 'package:q_trip_user/presentation/component/texts/black_texts.dart';
import '../../../../core/assets_constant/images.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/routing/navigation_services.dart';
import '../../../../core/routing/routes.dart';
import '../../../../domain/entities/trip_entity.dart';
import '../../../../domain/entities/trip_history_entity.dart';
import '../../../../domain/request_body/address_body.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../component/animation/tap_effect.dart';
import '../../../component/spaces.dart';
import '../../../sheet/rate_sheet/rate_sheet.dart';
import '../../../sheet/report_sheet/report_sheet.dart';
import '../../search/search_cubit.dart';



class MyTripsItemWidget extends StatelessWidget {

  final TripHistoryEntity _entity;

  const MyTripsItemWidget({super.key,
    required TripHistoryEntity entity,
  })  : _entity = entity;

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kFormRadius)),
      child: Container(
        decoration: const BoxDecoration().listStyle(),
        // margin: EdgeInsets.symmetric(vertical:kFormPaddingAllSmall.h),

        padding: EdgeInsets.all(kFormPaddingAllLarge.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VerticalSpace(kFormPaddingAllLarge.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: blueColor,
                                borderRadius: BorderRadius.circular(12)
                            ),
                            padding: 8.paddingHorizontal+4.paddingVert,
                            child:
                            BlackRegularText(label: _entity.status,fontSize: 13,)
                        ),
                        4.height,
                        BlackRegularText(label: _entity.date,fontSize: 13,fontWeight: FontWeight.w300,)
                      ],
                    ),
                    Column(
                      children: [
                        BlackMediumText(label: '${tr(_entity.car.vehicleType.category??'')}',fontSize: 13,),
                        BlackRegularText(label:'${_entity.price} ${tr(LocaleKeys.currency)}',fontSize: 16,labelColor: purpleColor,)
                      ],
                    )
                  ],
                ),
                // Text(_entity.driverName,style:const TextStyle().regularStyle().boldStyle()),
                // VerticalSpace(kFormPaddingAllSmall.h),
                // Row(
                //   children: [
                //     Container(
                //       height:8,
                //       width: 8,
                //       decoration:const BoxDecoration(shape: BoxShape.circle,color: Colors.grey),
                //     ),
                //     HorizontalSpace(kFormPaddingAllSmall.h),
                //     Expanded(child: Text('${ _entity.date??''} , ${ _entity.createdAt??''}',style: const TextStyle().descriptionStyle(fontSize: 10).blackStyle().ellipsisStyle(),maxLines: 2)),
                //   ],
                // ),
              ],
            ),
            4.height,
            Divider(height: 1,color: dividerColor.withOpacity(0.2),endIndent: 40,indent: 40,),

            4.height,
            VerticalSpace(kFormPaddingAllLarge.w),
            Row(
              children: [
                Container(
                  height:8,
                  width: 8,
                  decoration:const BoxDecoration(shape: BoxShape.circle,color: Colors.green),
                ),
                HorizontalSpace(kFormPaddingAllSmall.h),
                Expanded(child: Text( _entity.fromAddress??'',style: const TextStyle().descriptionStyle(fontSize: 10).blackStyle().ellipsisStyle(),maxLines: 2)),
              ],
            ),
            VerticalSpace(kFormPaddingAllLarge.w),

            Row(

              children: [
                Container(
                  height:8,
                  width: 8,
                  decoration:const BoxDecoration(shape: BoxShape.circle,color: Colors.red),
                ),
                HorizontalSpace(kFormPaddingAllSmall.h),
                Expanded(child: Text( _entity.toAddress??'',style: const TextStyle().descriptionStyle(fontSize: 10).blackStyle().ellipsisStyle(),maxLines: 2)),
              ],
            ),
            VerticalSpace(kFormPaddingAllLarge.w),
            16.height,
            InkWell(
              onTap: () {
                showReport(context, entity: _entity);
              },
              child: Container(
                margin: 8.paddingHorizontal,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.01),
                        blurRadius: 10,
                        offset: const Offset(5, 8),
                      )
                    ]),
                // margin: EdgeInsets.symmetric(vertical:kFormPaddingAllSmall.h), padding: EdgeInsets.all(kFormPaddingAllLarge.r),
                padding: EdgeInsets.all(kFormPaddingAllLarge.r),
                child: Row(
                  children: [
                    Icon(Icons.report_gmailerrorred),
                    8.width,
                    BlackRegularText(
                      label: tr(LocaleKeys.report),
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                    const Spacer(),
                    // InkWell(
                    //   onTap: () {},
                    //   child: const Icon(
                    //     Icons.arrow_forward_ios,
                    //     color: gray3Color,
                    //   ),
                    // ),
                    8.width,
                  ],
                ),
              ),
            ),
            16.height,
            Row(
              children: [
                Expanded(child:
                _entity.tripStatus!='canceled' && _entity.tripStatus!='driver_cancel'?
                CustomButton(
                  raduis: 30,
                  color: Colors.white,
                  textColor: purpleColor,
                  onTap: (){
                    TripEntity  tripEntity = TripEntity(distance: _entity.distance, driverId: '0', dropAddress: _entity.toAddress, dropLat:double.parse(_entity.toLat.toString()),
                        dropLng: double.parse(_entity.toLng.toString()), expectedTime: _entity.expectedTime, pickupAddress: _entity.fromAddress, pickupLat: double.parse(_entity.fromLat.toString()),
                        pickupLng: double.parse(_entity.fromLng.toString()), userRate: _entity.clientRate, price: _entity.price, status: _entity.status, tripId: _entity.id.toString(),
                        userImage: _entity.driverImage??'', driverName: _entity.driverName, driverMobile: _entity.driverMobile, userName: _entity.clientName, driverRate: _entity.rate.toString(), vehicle: null, driverImage: _entity.driverImage??'', driverAvgYear: '', driverAvgTrips: '', );
                    showRate(context,entity: tripEntity);
                  },
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppImages.star2),
                      HorizontalSpace(4),
                      Text(tr(LocaleKeys.rate2),style: const TextStyle().regularStyle().customColor(purpleColor),),
                    ],
                  ),
                ):SizedBox.shrink(),),
                HorizontalSpace(kFormPaddingAllSmall.h),

                Expanded(child:  CustomButton(onTap: (){
                  print('asdasd');
                  AddressBody _toAddressBody =AddressBody(title: _entity.toAddress??'',address: _entity.toAddress??'',latLng: LatLng(double.parse(_entity.toLat.toString()??'0.0'),double.parse(_entity.toLng.toString()??'0.0')));
                  AddressBody _fromAddress =AddressBody(title: _entity.fromAddress??'',address: _entity.fromAddress??'',latLng: LatLng(double.parse(_entity.fromLat.toString()??'0.0'),double.parse(_entity.fromLng.toString()??'0.0')));
                  // NavigationService.push(Routes.driverSelectCarScreen,arguments: {'from':_toAddressBody,'to':_toAddressBody});
                  BlocProvider.of<SearchCubit>(context,listen: false).setFromLocation(_fromAddress);
                  BlocProvider.of<SearchCubit>(context,listen: false).setToLocation(_toAddressBody);
                  BlocProvider.of<SearchCubit>(context,listen: false).updateLocation(_toAddressBody);

                },
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppImages.re),
                      HorizontalSpace(4),
                      Text(tr(LocaleKeys.reOrder),style: const TextStyle().regularStyle().customColor(Colors.white ),),
                    ],
                  ),)
                ),
              ],
            ),
            16.height,

          ],
        ),
      ),
    );
    //   TapEffect(
    //   onTap: (){
    //     //report
    //   },
    //   child:
    //
    // );
  }
}
