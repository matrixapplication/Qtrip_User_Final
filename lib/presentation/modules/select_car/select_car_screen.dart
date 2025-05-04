
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/presentation/modules/select_car/select_car_cubit.dart';
import 'package:q_trip_user/presentation/modules/select_car/widgets/select_car_map.dart';
import 'package:q_trip_user/presentation/modules/select_car/widgets/select_car_sheet.dart';
import '../../../core/resources/values_manager.dart';
import '../../../core/routing/navigation_services.dart';
import '../../../core/routing/routes.dart';
import '../../../domain/entities/promo_code_entity.dart';
import '../../../domain/request_body/address_body.dart';
import '../../../generated/locale_keys.g.dart';
import '../../component/custom_app_bar.dart';
import '../../component/custom_button.dart';
import '../../component/spaces.dart';

class SelectCarScreen extends StatefulWidget {
  final AddressBody _fromLocationModel;
  final AddressBody _toLocationModel;
  final PromoCodeEntity? _promoCodeEntity;
  const SelectCarScreen({
    required AddressBody fromLocationModel,
    required AddressBody toLocationModel,
    required PromoCodeEntity? promoCodeEntity,
  })
      : _fromLocationModel = fromLocationModel,
        _toLocationModel = toLocationModel,
        _promoCodeEntity = promoCodeEntity;


  @override
  State<SelectCarScreen> createState() => _SelectCarScreenState();


}

class _SelectCarScreenState extends State<SelectCarScreen> {

  late SelectCarCubit _viewModelCubit;

  @override
  void initState() {
    super.initState();
    _viewModelCubit = BlocProvider.of<SelectCarCubit>(context,listen: false);
    _viewModelCubit.init(context,widget._fromLocationModel,widget._toLocationModel,'car');
  }

  @override
  Widget build(BuildContext context) {
    SelectCarState state = context.watch<SelectCarCubit>().state;
    return Scaffold(
      extendBodyBehindAppBar: true,
      
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      appBar: CustomAppBar(color: Colors.transparent,backBackgroundColor:Theme.of(context).cardColor),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    Expanded(child: SelectCarMap()),
                    VerticalSpace(  deviceHeight *0.41  ),
                  ],
                ),
                SelectCarSheet(fromLocationModel: widget._fromLocationModel,toLocationModel: widget._toLocationModel,),
              ],
            ),

          ),
        Padding(padding:20.paddingHorizontal ,
        child:   CustomButton(
          raduis: 16,
          loading: state is SelectCarStoreRequest,
          onTap: (){
            _viewModelCubit.storeTrip().then((value) {
              if(value.isNotEmpty){
                NavigationService.push(Routes.driverTripScreen, arguments: {'tripId':value});
              }
            });
          },title: tr(LocaleKeys.confirm),),
        )
        ],
      ),
    );
  }
}
