
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:q_trip_user/core/assets_constant/images.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/decoration.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';

import '../../../core/resources/values_manager.dart';
import '../../../generated/assets.dart';
import '../../../generated/locale_keys.g.dart';
import '../animation/tap_effect.dart';
import '../custom_card.dart';
import '../spaces.dart';

enum GenderType{ male , female }

class GenderSelectorWidget extends StatelessWidget {
  final _tag = 'GenderSelectorWidget';
  final Function(GenderType) _onSelected;
  final GenderType? _selectedValue;

  const GenderSelectorWidget({
    super.key,
    required Function(GenderType) onSelected,
    required GenderType? selectedValue,
  })  : _onSelected = onSelected,
        _selectedValue = selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(tr(LocaleKeys.selectYourGender),style:  Theme.of(context).inputDecorationTheme.labelStyle),
        VerticalSpace(kFormPaddingAllSmall.h),
        Row(
          children: [
            Expanded(child: _buildCard(context,GenderType.male)),
            HorizontalSpace(kFormPaddingAllLarge.w),
            Expanded(child: _buildCard(context,GenderType.female)),
          ],
        ),
      ],
    );
  }

  _buildCard(BuildContext context,GenderType type) {
    bool isSelected = _selectedValue == type;
    return CustomTapEffect(
      onTap: () => _onSelected(type),
      child: CustomCard(
        elevation: isSelected ? 3 : 0,
        child: Container(
          height: 50.h,
          padding: EdgeInsets.all(kFormPaddingAllLarge.r),
          decoration: const BoxDecoration().radius().customColor(Colors.white).borderStyle(color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).hintColor).shadow(radius: isSelected ? 5 : 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(type==GenderType.male?AppImages.male:AppImages.female ,height: 24.r,width: 24.r),
              HorizontalSpace(kFormPaddingAllLarge.w),
              Text(type==GenderType.male?tr(LocaleKeys.male):tr(LocaleKeys.female) ,style: const TextStyle().regularStyle(fontSize: 16).customColor(isSelected ? Theme.of(context).primaryColor : Theme.of(context).hintColor)),
              HorizontalSpace(kFormPaddingAllLarge.w),

            ],
          ),
        ),
      ),
    );
  }
}
