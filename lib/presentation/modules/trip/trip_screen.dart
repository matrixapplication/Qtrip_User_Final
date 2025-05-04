import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/decoration.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';
import 'package:q_trip_user/generated/locale_keys.g.dart';
import 'package:q_trip_user/presentation/component/component.dart';
import 'package:q_trip_user/presentation/component/custom_elevated_button.dart';
import 'package:q_trip_user/presentation/component/icon_widget.dart';
import 'package:q_trip_user/presentation/component/texts/primary_texts.dart';
import 'package:q_trip_user/presentation/modules/trip/trip_cubit.dart';
import 'package:q_trip_user/presentation/modules/trip/widget/trip_sheet.dart';
import '../../../core/resources/color.dart';
import '../../../core/resources/color.dart';
import '../../../core/resources/color.dart';
import '../../../core/resources/color.dart';
import '../../../core/resources/values_manager.dart';
import '../../../core/routing/navigation_services.dart';
import '../../../core/routing/routes.dart';
import '../../../domain/entities/trip_entity.dart';
import '../../component/custom_app_bar.dart';
import '../../component/images/custom_image.dart';
import '../../component/spaces.dart';
import '../../component/texts/black_texts.dart';
import 'widget/trip_car_map.dart';

class TripScreen extends StatefulWidget {
  final String _tripId;
  const TripScreen({
    required String tripId,
  }) : _tripId = tripId;
  @override
  State<TripScreen> createState() => _TripScreenState();


}

class _TripScreenState extends State<TripScreen> {

  late TripCubit _tripCubit;
  static TripEntity? _entity;
  @override
  void initState() {
    _tripCubit = BlocProvider.of<TripCubit>(context,listen: false);
    super.initState();
    _tripCubit.init(context,widget._tripId);
    // TripHelper.checkTrip(widget._tripId);

  }


  @override
  void dispose() {
    _tripCubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _entity = context.watch<TripCubit>().state.tripEntity?? context.watch<TripCubit>().tripEntityCubit;
    final cubit = context.read<TripCubit>();
    final getDistanceTripModel = context.watch<TripCubit>().getDistanceTripModel;
    return WillPopScope(
      onWillPop: ()async {
        NavigationService.pushNamedAndRemoveUntil(Routes.driverHomeScreen);
        return false;
      } ,
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: CustomAppBar(
              color: Colors.transparent,
              backBackgroundColor: Theme.of(context).cardColor,
              onBackPress: () {
                NavigationService.pushNamedAndRemoveUntil(Routes.driverHomeScreen);
              }),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
             Column(
               children: [
                 Expanded(child:
                 Stack(
                    // fit:StackFit.expand,
                   children: [
                     TripCarMap(),
                     Positioned(
                       top: 100.h,
                       bottom: 20.h,
                         child:
                        BlocConsumer<TripCubit,TripState>(
                            listener: (context,state){},
                            builder: (context,state){
                          return  Container(
                              width: deviceWidth,
                              height:deviceHeight   ,
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ...cubit.driversOffers.map((e) => Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black.withOpacity(0.07),
                                                blurRadius: 7,
                                                offset: Offset(4,8)
                                            )
                                          ]
                                      ),
                                      padding: 16.paddingAll,
                                      margin: 16.paddingHorizontal+5.paddingVert,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Stack(
                                                children: [
                                                  Padding(padding: EdgeInsets.only(bottom: 12),
                                                    child:
                                                    CustomImage(imageUrl:e.driverImage, radius: 50, height: 45.h, width: 45.w),                                                  ),
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
                                                              BlackRegularText(label: e.driverRate??'',fontSize: 13,),
                                                            ],
                                                          ),
                                                        ),
                                                      )),
                                                ],
                                              ),

                                              // CustomPersonImage(imageUrl: _entity?.image, size: 50.r),
                                              HorizontalSpace(kFormPaddingAllLarge.h),
                                              Expanded(child:  Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(e.driverName??'', style: const TextStyle().regularStyle()),

                                                ],
                                              ),),
                                              PrimaryBoldText(label: '${e.driverPrice??''} ${LocaleKeys.currency.tr()}',fontSize: 23,),
                                              15.width,
                                              // IconWidget(
                                              //   onTap:(){
                                              //     cubit.removeOffer(e);
                                              //   },
                                              //   widget: Icon(Icons.clear),
                                              // )
                                            ],
                                          ),
                                          5.height,
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              CustomImage(imageUrl:e.driverImage, radius: 12, height: 45.h, width: 80.w,fit: BoxFit.fill,),
                                              10.width,
                                              Expanded(child:  Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('${e.brand} ,${e.model} ,${e.vehicleTypeCategory}', style: const TextStyle().regularStyle(fontSize: 12)),
                                                  Text('${e.manufacturingYear} ,${e.colorName}', style: const TextStyle().regularStyle(fontSize: 12)),
                                                ],
                                              ),
                                              ),
                                              Icon(
                                                Icons.social_distance,
                                                color: primaryColor,
                                                size: 30,
                                              ),
                                              5.width,
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('${getDistanceTripModel?.distance??0} ${tr(LocaleKeys.km)}',style: TextStyle().regularStyle(fontSize: 14,).copyWith(fontWeight: FontWeight.w300),),
                                                  Text('${getDistanceTripModel?.duration??0} ${tr(LocaleKeys.minutes)}',style: TextStyle().regularStyle(fontSize: 14).copyWith(fontWeight: FontWeight.w300),),
                                                ],
                                              )

                                              // Container(
                                              //   decoration: BoxDecoration().radius(radius: 12).customColor(primaryColor.withOpacity(0.05)).copyWith(
                                              //     border: Border.all(color:primaryColor, width: 1),
                                              //   ),
                                              //   // padding: 16.paddingHorizontal+8.paddingVert,
                                              //   child: Row(
                                              //     children: [
                                              //       Padding(
                                              //           padding: 12.paddingHorizontal+5.paddingVert,
                                              //           child: Column(
                                              //             children: [
                                              //               Text('${tr(LocaleKeys.distance)}',style: TextStyle().regularStyle(fontSize: 12),),
                                              //               Text('${getDistanceTripModel?.distance??0} ${tr(LocaleKeys.km)}',style: TextStyle().regularStyle(fontSize: 10),),
                                              //
                                              //             ],
                                              //           )
                                              //       ),
                                              //       Container(
                                              //         height: 25,
                                              //         // width: 5,
                                              //         child: VerticalDivider(width: 2,color: primaryColor,),
                                              //       ),
                                              //       Padding(
                                              //           padding: 12.paddingHorizontal+5.paddingVert,
                                              //           child:Column(
                                              //             children: [
                                              //               Text(tr(LocaleKeys.time),style: TextStyle().regularStyle(fontSize: 12),),
                                              //               Text('${getDistanceTripModel?.duration??0} ${tr(LocaleKeys.minutes)}',style: TextStyle().regularStyle(fontSize: 10),),
                                              //
                                              //             ],
                                              //           )
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),

                                            ],
                                          ),
                                           10.height,
                                           Row(
                                             children: [
                                               Expanded(child: CustomElevatedButton(
                                                 loadingColor: Colors.white,
                                                 isLoading: state.isLoading,
                                                 borderRadius: 10,
                                                 width: 90,
                                                 height: 40.h,
                                                 fontSize: 16,
                                                 onTap: (){
                                                   cubit.acceptOffer(tripId: widget._tripId, driverId: e.driverId??'0', price: e.driverPrice??'0');
                                                 },
                                                 buttonText: tr(LocaleKeys.accept),
                                               )),
                                               10.width,
                                               Expanded(child: CustomElevatedButton(
                                                 isOutline: true,
                                                 loadingColor: Colors.white,
                                                 // isLoading: state.isLoading,
                                                 borderRadius: 10,
                                                 width: 90,
                                                 height: 40.h,
                                                 fontSize: 16,
                                                 onTap: (){
                                                   cubit.removeOffer(e);
                                                 },
                                                 buttonText: tr(LocaleKeys.cancel),
                                               )),
                                             ],
                                           )
                                        ],
                                      ),
                                    )),
                                  ],
                                ),
                              )
                          );
                        }))
                   ],
                 )),



                 VerticalSpace(deviceHeight *0.35  ),

               ],
             ),
              //cash
              TripSheet(entity: _entity),
            ],
          )
          //       body: StreamBuilder<TripEntity?>(
      //       stream: _tripBloc.tripStream,
      //
      //       builder: (context, snapshot) {
      //         TripEntity? entity = snapshot.data;
      //
      //         return Stack(
      //           alignment: Alignment.bottomCenter,
      //           children: [
      //             TripCarMap(),
      //
      //             TripSheet(entity:entity),
      //           ],
      //         );
      //       },
      //     )
      ),
    );
  }
}
