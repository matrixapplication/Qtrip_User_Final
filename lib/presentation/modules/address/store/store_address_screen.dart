import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';
import 'package:q_trip_user/presentation/modules/address/store/store_address_cubit.dart';

import '../../../../core/resources/values_manager.dart';
import '../../../../core/routing/navigation_services.dart';
import '../../../../data/model/base/response_model.dart';
import '../../../../domain/request_body/address_body.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../component/animation/list_animator.dart';
import '../../../component/custom_app_bar.dart';
import '../../../component/custom_button.dart';
import '../../../component/inputs/custom_text_field_normal.dart';
import '../../../component/spaces.dart';
import '../../search/search_cubit.dart';

class StoreAddressScreen extends StatefulWidget {
  final AddressBody _addressBody;
  const StoreAddressScreen({super.key,
    required AddressBody addressBody,
  }) : _addressBody = addressBody;

  @override
  State<StoreAddressScreen> createState() => _StoreAddressScreenState();
}

class _StoreAddressScreenState extends State<StoreAddressScreen> {

  final _addressTitleController = TextEditingController();

  _onSubmit()async{
    ResponseModel responseModel = await BlocProvider.of<StoreAddressCubit>(context).storeAddress(body: widget._addressBody, title: _addressTitleController.text);
    if(responseModel.isSuccess){

      // NavigationService.pushNamedAndRemoveUntil(RoutesDriver.driverSearchScreen);
      BlocProvider.of<SearchCubit>(context).getAddresses();
      NavigationService.goBack();
      NavigationService.goBack();
    }
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<StoreAddressCubit>().state;

    return  Scaffold(
      appBar: CustomAppBar(title: widget._addressBody.addressType.name),
      body: Padding(
        padding: EdgeInsets.all(kScreenPaddingNormal.r),
        child: ListAnimator(
          children: [
            Row(
              children: [
                Material(
                  color: Colors.transparent,
                  child: Ink(
                    decoration: ShapeDecoration(color: Colors.grey[200], shape: const CircleBorder(),),
                    child:  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.location_on,
                        size: 15.r,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                HorizontalSpace(kFormPaddingAllSmall.w),
                Expanded(child: Text(widget._addressBody.title??'',style: const TextStyle().descriptionStyle(),)),
              ],
            ),
            VerticalSpace(kFormPaddingAllLarge.h),
            CustomTextFieldNormal(hint: tr(LocaleKeys.addressTitle),controller: _addressTitleController,defaultValue: widget._addressBody.title),
              CustomButton(
                  title: tr(LocaleKeys.saveAddress),
                  onTap: () => _onSubmit(),
                  loading: (state is StoreAddressLoading))
            ],
        ),
      )
    );
  }
}
