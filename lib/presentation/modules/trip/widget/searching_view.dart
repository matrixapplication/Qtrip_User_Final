import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:q_trip_user/core/assets_constant/images.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';
import 'package:q_trip_user/generated/locale_keys.g.dart';
import 'package:q_trip_user/presentation/component/texts/black_texts.dart';

import '../../../../core/resources/values_manager.dart';
import '../../../../domain/entities/trip_entity.dart';
import '../../../../generated/assets.dart';
import '../../../component/spaces.dart';



class SearchingView extends StatefulWidget {
  final TripEntity? _entity;
  const SearchingView({
    required TripEntity? entity,
  }) : _entity = entity;


  @override
  State<SearchingView> createState() => _SearchingViewState();
}

class _SearchingViewState extends State<SearchingView> {
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        10.height,
        Text(tr(LocaleKeys.rideRequestedLocatingYourDriver),style: TextStyle().regularStyle()),
        VerticalSpace(kScreenPaddingNormal.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                width: deviceWidth / 4.2 - 20,
                height: 5,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ),
        // SizedBox(height: 150.r,child: NoDataScreen(itle: '',t)),
        VerticalSpace(kFormPaddingAllLarge.w),
        Image.asset(
        AppImages.empty,
          width: 150.r,
          height: 150.r,
        ),
        BlackRegularText(label: tr(LocaleKeys.searchingForCaptainsNearby),fontSize: 20,),
        BlackRegularText(label: tr(LocaleKeys.pleaseWaitCoupleMinutes),fontSize: 16,fontWeight: FontWeight.w300),
        VerticalSpace(kFormPaddingAllLarge.w),
      ],
    );
  }
}
