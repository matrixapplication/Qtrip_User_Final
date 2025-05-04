import 'package:flutter/material.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/decoration.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';

import '../../../../core/resources/values_manager.dart';
import '../../../component/spaces.dart';

class AddressItem extends StatelessWidget {
  final String _title;final IconData _icon;final GestureTapCallback? _onTap;


  const AddressItem({
    required String title,
    required IconData icon,
    required GestureTapCallback? onTap,
  })  : _title = title,
        _icon = icon,
        _onTap = onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        decoration: const BoxDecoration().radius().shadow().borderStyle(color: Theme.of(context).cardColor ).customColor(Theme.of(context).primaryColor),
        padding: EdgeInsets.symmetric(horizontal:kFormPaddingAllLarge.w,vertical: kFormPaddingAllSmall.h),
        child: Center(child: Row(
          children: [
            Icon(_icon,color: Theme.of(context).cardColor),
            HorizontalSpace(kFormPaddingAllSmall.w),
            Text(  _title.length > 10 ? _title.substring(0, 10)+'...' : _title,style: const TextStyle().regularStyle().colorWhite())
            ],
          ),
        ),
      ),
    );
  }
}
