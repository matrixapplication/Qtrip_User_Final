
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/decoration.dart';
import 'package:q_trip_user/presentation/modules/address/search/store_search_address_cubit.dart';

import '../../../../core/resources/values_manager.dart';
import '../../../../core/utils/constants.dart';
import '../../../../domain/entities/address_entity.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../component/animation/list_animator_data.dart';
import '../../../component/custom_app_bar.dart';
import '../../../component/inputs/custom_text_field_search.dart';
import 'widgets/search_item.dart';

class StoreSearchAddressScreen extends StatefulWidget {
  final AddressType _addressTypes;
  final AddressEntity? _entity;

  @override
  State<StoreSearchAddressScreen> createState() => _StoreSearchAddressScreenState();

  const StoreSearchAddressScreen({
    super.key,
    required AddressType addressTypes,
    required AddressEntity? addressEntity,
  })  : _addressTypes = addressTypes,
        _entity = addressEntity;
}

class _StoreSearchAddressScreenState extends State<StoreSearchAddressScreen> {
  final _searchController = TextEditingController();

 late StoreSearchAddressCubit _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = BlocProvider.of<StoreSearchAddressCubit>(context,listen: false);
    _viewModel.setAddress(widget._entity,widget._addressTypes);
  }

  @override
  Widget build(BuildContext context) {
    var body = context.watch<StoreSearchAddressCubit>().body;
    var placePredictions = context.watch<StoreSearchAddressCubit>().placePredictions;
    return Scaffold(
      appBar: CustomAppBar(
        height: 120,
        flexibleSpace:Container(
            height: 200.h,
            decoration: BoxDecoration(boxShadow: [ BoxShadow(color: Theme.of(context).hintColor, spreadRadius: 1, blurRadius: 5)]).customColor(Theme.of(context).cardColor),
            padding: EdgeInsets.all(kScreenPaddingNormal.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              CustomTextFieldSearch(
                hint: tr(LocaleKeys.enterPickupLocation),
                controller: _searchController,
                onChange: (input) => _viewModel.searchForPlaces(context, input),
                defaultValue: body?.title,
                suffixDataWidget:body == null?null: GestureDetector(
                  onTap: (){
                    _searchController.text='';
                    _viewModel.setAddress(null,widget._addressTypes);
                  },
                  child: const Icon(Icons.close),
                ),
              ),
            ],
            ),
          ),
      ),
      body: Container(
        width: deviceWidth,
        decoration: const BoxDecoration().shadow().customColor(Theme.of(context).cardColor),
        child: ListAnimatorData(
          itemCount: placePredictions.length,
          scrollDirection:Axis.vertical ,
            itemBuilder: (context, index)=>SearchItem(addressBody: placePredictions[index])
        ),
      ),
    );
  }
}
