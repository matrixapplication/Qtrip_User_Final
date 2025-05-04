import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:q_trip_user/generated/locale_keys.g.dart';
import '../../../../../core/extensions/num_extensions.dart';
import '../../../../../core/resources/decoration.dart';
import '../../../../../core/resources/text_styles.dart';
import '../../../../../core/utils/date/date_converter.dart';
import '../../../../../domain/entities/wallet_entity.dart';
import '../../../../../presentation/component/component.dart';

import '../../../../../../core/resources/values_manager.dart';
import '../../../../../../generated/assets.dart';

class WalletItem extends StatelessWidget {
  final WalletEntity _entity;

  const WalletItem({super.key,
    required WalletEntity entity,
  })  : _entity = entity;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kFormRadius)),

      child: Container(
        decoration: const BoxDecoration().listStyle(),
        padding: EdgeInsets.all(kFormPaddingAllLarge.r),

        child: Row(
          children: [
            Image.asset(_entity.amount>0?Assets.imagesWalletAddIcon:Assets.imagesWalletSupIcon,height: 44.r,width: 44.r,),
            HorizontalSpace(kFormPaddingAllLarge.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_entity.message,style: const TextStyle().regularStyle()),
                  VerticalSpace(kFormPaddingAllSmall.h),
                  Text(DateConverter.convertDateDomainData(_entity.data),style: const TextStyle().regularStyle(fontSize: 14).highlightStyle()),
                  VerticalSpace(kFormPaddingAllSmall.h),

                  Text(DateConverter.isoStringToLocalTimeTimeOnly(_entity.data),style: const TextStyle().descriptionStyle(fontSize: 12)),
                ],
              ),
            ),
            HorizontalSpace(kFormPaddingAllLarge.w),

            Text('${_entity.amount} ${tr(LocaleKeys.currency)} ',style: const TextStyle().regularStyle().customColor(_entity.amount>0?Colors.green:Colors.red),),
          ],
        ),
      ),
    );
  }
}
