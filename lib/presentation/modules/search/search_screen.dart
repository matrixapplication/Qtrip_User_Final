import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/decoration.dart';
import 'package:q_trip_user/presentation/modules/search/search_cubit.dart';
import '../../../core/resources/values_manager.dart';
import '../../../core/routing/navigation_services.dart';
import '../../../core/routing/routes.dart';
import '../../../core/utils/constants.dart';
import '../../../domain/entities/address_entity.dart';
import '../../../domain/request_body/address_body.dart';
import '../../../generated/locale_keys.g.dart';
import '../../component/animation/list_animator.dart';
import '../../component/animation/list_animator_data.dart';
import '../../component/custom_app_bar.dart';
import '../../component/exit_icon.dart';
import '../../component/inputs/custom_text_field_search.dart';
import '../../component/spaces.dart';
import '../../dialog/show_address_dialog.dart';
import '../../dialog/show_delete_address_dialog.dart';
import '../address/favorites/widgets/address_item.dart';
import 'widgets/search_item.dart';

class SearchScreen extends StatefulWidget {

 final AddressBody? _addressBody ;
 @override
  State<SearchScreen> createState() => _SearchScreenState();

 const SearchScreen({super.key,
    required AddressBody? addressBody,
  }) : _addressBody = addressBody;
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _fromController;
  late TextEditingController _toController;
  late FocusNode _fromFocusNode;
  late FocusNode _toFocusNode;
  late SearchCubit _viewModelCubit;

  @override
  void initState() {
    super.initState();
    _fromController = TextEditingController();
    _toController = TextEditingController();
    _fromFocusNode = FocusNode();
    _toFocusNode = FocusNode();
    _viewModelCubit = BlocProvider.of<SearchCubit>(context,listen: false);
    _viewModelCubit.setFromLocation(widget._addressBody);

    // _fromFocusNode.addListener(() => _viewModelCubit.searchForPlaces(context, _fromController.text,UpdatePlace.from));
    // _toFocusNode.addListener(()   => _viewModelCubit.searchForPlaces(context, _toController.text  ,UpdatePlace.to));

    _fromFocusNode.addListener(() {
      if(_fromFocusNode.hasFocus) {
        _viewModelCubit.searchForPlaces(context, _fromController.text, UpdatePlace.from);
      }
    });

    _toFocusNode.addListener(() {
      if(_toFocusNode.hasFocus){
        _viewModelCubit.searchForPlaces(context, _toController.text,UpdatePlace.to);
      }

    });
  }

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    _fromFocusNode.dispose();
    _toFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var fromAddressBody = context.watch<SearchCubit>().fromAddressBody;
    var toAddressBody = context.watch<SearchCubit>().toAddressBody;
    var placePredictions = context.watch<SearchCubit>().placePredictions;
    var addressesEntity = context.watch<SearchCubit>().addressesEntity;
    //update text address
      if(fromAddressBody!=null){_fromController.text =fromAddressBody.title??'';}
      if(toAddressBody!=null){_toController.text =toAddressBody.title??'';}

    return Scaffold(
      appBar: CustomAppBar(
        height: 180,
        // bottomSize: 200,
        flexibleSpace:Container(
            height: 200.h,
            decoration: BoxDecoration(boxShadow: [ BoxShadow(color: Theme.of(context).hintColor, spreadRadius: 1, blurRadius: 5)]).customColor(Theme.of(context).cardColor),
            padding: EdgeInsets.all(kScreenPaddingNormal.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              CustomTextFieldSearch(
                hint: tr(LocaleKeys.enterPickupLocation),
                controller: _fromController,
                focusNode: _fromFocusNode,

                onChange: (input) => _viewModelCubit.searchForPlaces(context, input,UpdatePlace.from),
                defaultValue: fromAddressBody?.title,
                suffixDataWidget:fromAddressBody == null?null: GestureDetector(
                  onTap: () {
                    _fromController.text='';
                    _viewModelCubit.setFromLocation(null);
                  },
                  child: const ExitIcon(),
                ),
              ),

              VerticalSpace(kScreenPaddingNormal.h),
              CustomTextFieldSearch(
                hint: tr(LocaleKeys.whereTo),
                controller: _toController,
                focusNode: _toFocusNode,
                defaultValue: toAddressBody?.title,
                onChange: (input) => _viewModelCubit.searchForPlaces(context, input,UpdatePlace.to),
                suffixDataWidget: toAddressBody==null?null:GestureDetector(
                  onTap: () {
                    _toController.clear();
                    _viewModelCubit.setToLocation(null);
                  },
                  child: const ExitIcon()//const Icon(Icons.close),
                        ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 54.h,
            width: deviceWidth,
            padding: EdgeInsets.all(kFormPaddingAllLarge.r),
            decoration: const BoxDecoration().shadow().customColor(Theme.of(context).cardColor),
            alignment: Alignment.centerLeft,
            child: ListAnimator(
              scrollDirection:  Axis.horizontal,
              children: [
                AddressItem(
                  title: addressesEntity?.home?.name ?? tr(LocaleKeys.homeAddress),
                  icon: Icons.home_outlined,
                  onTap: () {
                    if(addressesEntity?.home==null){
                      NavigationService.push(Routes.driverStoreSearchAddressScreen, arguments: {'addressTypes': AddressType.home, 'addressEntity': null});
                    }else{
                      _viewModelCubit.updateLocation(AddressBody.setAddress(entity: addressesEntity!.home!));
                    }
                  },
                  onLongPress: () {
                    if(addressesEntity?.home !=null){
                      showDeleteAddressDialog(context,addressesEntity!.home!);
                    }
                  },
                  onDoubleTap: () {
                    // showAddressDialog(context,addressesEntity!.home!);
                    },
                ),
                AddressItem(
                  title: addressesEntity?.work?.name ?? tr(LocaleKeys.workAddress),
                  icon: Icons.work_outline,
                  onTap: () {
                    if(addressesEntity?.work==null){
                      NavigationService.push(Routes.driverStoreSearchAddressScreen, arguments: {'addressTypes': AddressType.work, 'addressEntity': null});
                    }else{
                      _viewModelCubit.updateLocation(AddressBody.setAddress(entity: addressesEntity!.work!));
                    }
                  },
                  onLongPress: () {
                    if(addressesEntity?.work != null){
                      showDeleteAddressDialog(context,addressesEntity!.work!);
                    }
                    },
                  onDoubleTap: () {
                    // showAddressDialog(context,addressesEntity!.work!);
                    },
                ),
                AddressItem(title: tr(LocaleKeys.favoriteAddresses),icon: Icons.star_border,onTap: ()async{
                  AddressEntity? entity = await NavigationService.push(Routes.driverFavoriteAddressesScreen) as AddressEntity?;
                 if(addressesEntity!=null){
                   _viewModelCubit.updateLocation(AddressBody.setAddress(entity: entity!));
                 }
                },
                  onLongPress: () {
                  // showAddressDialog(context,addressesEntity!.home!);
                  },
                  onDoubleTap: () {  },
                ),

              ],
            ),
          ),
          Expanded(
            child: Container(
              width: deviceWidth,
              decoration: const BoxDecoration().shadow().customColor(Theme.of(context).cardColor),
              child: ListAnimatorData(
                itemCount: placePredictions.length,
                scrollDirection:Axis.vertical ,
                itemBuilder: (context, index)=>SearchItem( addressBody: placePredictions[index])
              ),
            ),
          ),
        ],
      ),
    );
  }

}


