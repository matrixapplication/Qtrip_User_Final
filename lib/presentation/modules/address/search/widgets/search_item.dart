import 'package:flutter/material.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../domain/request_body/address_body.dart';
import '../../../../component/custom_divider.dart';
import '../../../../component/spaces.dart';
import '../store_search_address_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SearchItem extends StatelessWidget {
  final AddressBody _addressBody;
  const SearchItem({
    super.key,
    required AddressBody addressBody,
  }) : _addressBody = addressBody;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> BlocProvider.of<StoreSearchAddressCubit>(context,listen: false).selectPlaceFromSuggestion(addressBody: _addressBody),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal:kScreenPaddingNormal.w,vertical: kFormPaddingAllLarge.h),
            child: Row(
              children: [
                Material(
                  color: Colors.transparent,
                  child: Ink(
                    decoration: ShapeDecoration(color: Colors.grey[200], shape: const CircleBorder(),),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.location_on,
                        size: 15,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                HorizontalSpace(kScreenPaddingNormal.w),
                Expanded(child: Text(_addressBody.title??'', style: const TextStyle(fontSize: 14, color: Colors.black54),),),
                HorizontalSpace(kScreenPaddingNormal.w),
              ],
            ),
          ),
          // VerticalSpace(kFormPaddingAllSmall.h),
          const CustomDivider(),
        ],
      ),
    );
  }


}
