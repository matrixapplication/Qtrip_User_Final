
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_trip_user/core/assets_constant/images.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';
import 'package:q_trip_user/presentation/component/animation/tap_effect.dart';
import 'package:q_trip_user/presentation/modules/trip/widget/header_sheet_widget.dart';

import '../../../../core/resources/color.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/routing/navigation_services.dart';
import '../../../../core/routing/routes.dart';
import '../../../../domain/entities/promo_code_entity.dart';
import '../../../../domain/request_body/address_body.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../component/animation/list_animator_data.dart';
import '../../../component/screen_state_layout.dart';
import '../../../component/spaces.dart';
import '../../auth/widgets/driver_type_widget.dart';
import '../../auth/widgets/vehicles_type_widget.dart';
import '../select_car_cubit.dart';
import 'car_item.dart';
import 'more_item.dart';

class SelectCarSheet extends StatelessWidget {
  final AddressBody fromLocationModel;
  final AddressBody toLocationModel;
  SelectCarSheet({required this.fromLocationModel, required this.toLocationModel});


  @override
  Widget build(BuildContext context) {
    // var state =context.watch<SelectCarCubit>().state;
    SelectCarCubit selectCarCubit =  BlocProvider.of<SelectCarCubit>(context);
    if( selectCarCubit.isMale==true){
      BlocProvider.of<SelectCarCubit>(context).selectGender('male');
    }
    else{
      BlocProvider.of<SelectCarCubit>(context).selectGender('female');
    }

    return  SafeArea(
      child: BlocConsumer<SelectCarCubit, SelectCarState>(
        listener: (context,state){},
        buildWhen:(previous, current)=> (current is SelectCarSuccessfully ||current is SelectCarLoading),
        builder: (context, state) {
          return DraggableScrollableSheet(
            initialChildSize:(state is SelectCarSuccessfully)?0.5:0 ,
            minChildSize: (state is SelectCarSuccessfully)?0.5:0,

        maxChildSize: 1,
        builder: (BuildContext context, ScrollController scrollController) {
          return SingleChildScrollView(

            physics: const BouncingScrollPhysics(),
            controller: scrollController,
            child: Container(
              height:deviceHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28),),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  Container(
                    width: 80,
                    height: 4,
                    decoration: BoxDecoration(color:primaryColor, borderRadius: BorderRadius.circular(2)),
                  ),
                  VerticalSpace(kScreenPaddingNormal.h),
                  Padding(padding:20.paddingHorizontal ,
                  child: HeaderSheetWidget(),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child:
                      Padding(
                        padding: EdgeInsets.all(kScreenPaddingNormal.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [Text(tr(LocaleKeys.selectYourRide),style: const TextStyle().regularStyle())]),
                            8.height,
                            StatefulBuilder(builder: (context, setState) {
                              return Row(
                                children: [
                                  5.width,
                                  Expanded(child:
                                  InkWell(
                                    onTap: (){
                                     setState((){selectCarCubit.isCar = true;});
                                      BlocProvider.of<SelectCarCubit>(context,listen: false).getVehicles(fromLocationModel,toLocationModel,'car');
                                    },
                                    child: VehiclesTypeWidget(
                                      image:AppImages.car,
                                      title: tr(LocaleKeys.car),
                                      description: '${selectCarCubit.detailsEntity?.durationText.toString()??''}',
                                      value: true,
                                      groupValue: selectCarCubit.isCar,
                                      onChanged: (value) {

                                      }, price: '',
                                    ),
                                  )),
                                  5.width,
                                  Expanded(child:
                                  InkWell(
                                    onTap: (){
                                      setState((){selectCarCubit.isCar = false;});
                                      BlocProvider.of<SelectCarCubit>(context,listen: false).getVehicles(fromLocationModel,toLocationModel,'motorcycle');
                                    },
                                    child: VehiclesTypeWidget(
                                      image:AppImages.moto,
                                      title: tr(LocaleKeys.motorcycle),
                                      description: '${selectCarCubit.detailsEntity?.durationText.toString()??''}',
                                      value: false,
                                      groupValue: selectCarCubit.isCar,
                                      onChanged: (value) {

                                      }, price: '',
                                    ),
                                  )),
                                  5.width,
                                ],
                              );
                            }),
                            16.height,
                            Container(
                              // height: 260.h,
                              child:
                               ScreenStateLayout(
                                isLoading: selectCarCubit.isLoading==true,
                                isEmpty: (state is SelectCarSuccessfully) ? (state.list??[]).isEmpty : false,
                                error: (state is SelectCarError) ? state.error : null,
                                builder: (context) {
                                  return  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        ...(state as SelectCarSuccessfully).list.map((e) => VehicleItem(selectedId:selectCarCubit.body.vehicleTypeId ,entity: e, onTap:BlocProvider.of<SelectCarCubit>(context).onUpdateCar ,),),
                                      ],
                                    ),
                                  );
                                }

                              ),
                            ),
                            16.height,
                            Text(tr(LocaleKeys.selectYourDriver),style: const TextStyle().regularStyle()),
                            8.height,
                            StatefulBuilder(builder: (context, setState) {
                              return Row(
                                children: [
                                  5.width,
                                  Expanded(child:
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        selectCarCubit.isMale = true;
                                      });
                                      BlocProvider.of<SelectCarCubit>(context).selectGender('male');
                                    },
                                    child: DriverTypeWidget(
                                      image:AppImages.male,
                                      title: 'Car',
                                      description: 'Lorem Ipsum',
                                      value: true,
                                      groupValue: selectCarCubit.isMale,
                                      onChanged: (value) {
                                        setState(() {
                                          selectCarCubit.isMale = value!;
                                        });
                                      },
                                    ),
                                  )),
                                  5.width,
                                 Expanded(child:
                                  InkWell(
                                   onTap: (){
                                     setState(() {
                                       selectCarCubit.isMale = false;
                                     });
                                     BlocProvider.of<SelectCarCubit>(context).selectGender('female');
                                   },
                                   child: DriverTypeWidget(
                                     image:AppImages.female,
                                     title: 'Motorcycle',
                                     description: 'Lorem Ipsum',
                                     value: false,
                                     groupValue: selectCarCubit.isMale,
                                     onChanged: (value) {
                                       setState(() {
                                         selectCarCubit.isMale = value!;
                                       });

                                     },
                                   ),
                                 )),
                                  5.width,
                                ],
                              );
                            }),
                             16.height,
                           BlocConsumer<SelectCarCubit,SelectCarState>(builder: (context, state) {
                             return StatefulBuilder(builder: (context, setState) {
                               final cubit = BlocProvider.of<SelectCarCubit>(context);
                               if(cubit.radioValue=='0'){
                                 BlocProvider.of<SelectCarCubit>(context).selectPaymentMethod('cash');
                               }else{
                                 BlocProvider.of<SelectCarCubit>(context).selectPaymentMethod('wallet');
                               }
                               return Column(
                                 children: [
                                   MoreItemWidget(
                                     endWidget:
                                     Radio(
                                       value: '0',
                                       groupValue: cubit.radioValue,
                                       onChanged: ( value){
                                         setState((){
                                           cubit. radioValue=value.toString();
                                         });
                                         BlocProvider.of<SelectCarCubit>(context).selectPaymentMethod('cash');
                                       },
                                     ),
                                     onTap: ()async{
                                       setState((){
                                         cubit.radioValue='0';
                                       });
                                       BlocProvider.of<SelectCarCubit>(context).selectPaymentMethod('cash');
                                      },
                                     svgIcon: AppImages.cash,
                                     label: tr(LocaleKeys.cash),
                                   ),
                                   16.height,
                                   MoreItemWidget(
                                     endWidget:
                                     Radio(
                                       value: '1',
                                       groupValue: cubit.radioValue,
                                       onChanged: (value){
                                         setState((){
                                           cubit.radioValue=value.toString();
                                         });
                                         BlocProvider.of<SelectCarCubit>(context).selectPaymentMethod('wallet');
                                       },
                                     ),
                                     onTap: ()async{
                                       setState((){
                                         cubit.radioValue='1';
                                       });
                                       BlocProvider.of<SelectCarCubit>(context).selectPaymentMethod('wallet');
                                     },
                                     svgIcon: AppImages.card,
                                     label: tr(LocaleKeys.addCredit),
                                   ),
                                   16.height,
                                   MoreItemWidget(
                                     endWidget: selectCarCubit.body.promoCodeEntity==null?
                                    CustomTapEffect(onTap: ()async{
                                      PromoCodeEntity? promoCodeEntity=await  NavigationService.push(Routes.driverPromoScreen,arguments: { 'promo':  BlocProvider.of<SelectCarCubit>(context,listen: false).body.promoCodeEntity});
                                      BlocProvider.of<SelectCarCubit>(context,listen: false).setPromoCode(promoCodeEntity);

                                    }, child: Icon(Icons.arrow_forward,color: Colors.grey.shade700,)):
                                     Text(selectCarCubit.body.promoCodeEntity!.promoCode,style: TextStyle().regularStyle().activeColor(),),
                                      onTap: ()async{

                                       PromoCodeEntity? promoCodeEntity=await  NavigationService.push(Routes.driverPromoScreen,arguments: { 'promo':  BlocProvider.of<SelectCarCubit>(context,listen: false).body.promoCodeEntity});
                                       BlocProvider.of<SelectCarCubit>(context,listen: false).setPromoCode(promoCodeEntity);
                                     },
                                     svgIcon: AppImages.promo,
                                     label: tr(LocaleKeys.promoCode),
                                   ),
                                 ],
                               );
                             });
                           }, listener: (context, state) {}),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
  },
),
    );
  }
}
