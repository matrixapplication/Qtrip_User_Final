
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/decoration.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';

import '../../../../core/resources/color.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../domain/entities/promo_code_entity.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../component/spaces.dart';
import '../promo_cubit.dart';




class PromoItem extends StatelessWidget {
  final PromoCodeEntity _entity;
  const PromoItem({super.key,
    required PromoCodeEntity entity,
  }) : _entity = entity;


  @override
  Widget build(BuildContext context) {
    PromoCodeEntity? selectedPromoCode = context.watch<PromoCubit>().selectedPromoCode;
    return DottedBorder(
      color: selectedPromoCode?.id==_entity.id?primaryColor:primaryColor.withOpacity(0.4),
      borderType: BorderType.RRect,
      radius: const Radius.circular(kFormRadiusSmall),

      strokeCap: StrokeCap.butt,
      dashPattern: const [10],
      padding:  EdgeInsets.all(kFormPaddingAllSmall),

      child: GestureDetector(
        onTap: ()=>
          BlocProvider.of<PromoCubit>(context,listen: false).setPromoCode(_entity),
        child: Container(
          color: selectedPromoCode?.id==_entity.id?primaryColor.withOpacity(0.08):Colors.grey.withOpacity(0.05),
         child:  Padding(
           padding: EdgeInsets.all(kFormPaddingAllSmall.r),
           child: Row(
             children: [

               Container(
                   height:80.r,
                   width:100.r,
                   alignment: Alignment.center,
                   decoration: BoxDecoration().listStyle().radius(radius: kFormRadiusSmall).customColor(selectedPromoCode?.id==_entity.id?primaryColor:primaryColor.withOpacity(0.05)),
                   child: Text(_entity.promoCode,style: TextStyle().regularStyle().copyWith(
                       color: selectedPromoCode?.id==_entity.id?Colors.white:Colors.black
                   ),)
               ),
               HorizontalSpace(kScreenPaddingNormal.w),
               Expanded(
                 child: Text(
                   '${tr(LocaleKeys.usePromoCode)} ${_entity.discount} ${_entity.discountType=='value'? '${tr(LocaleKeys.currency)}':'%'}',
                   style: const TextStyle(fontSize: 14, color: Colors.black54),
                 ),
               ),
               HorizontalSpace(kScreenPaddingNormal.w),
             ],
           ),
         ),
        ),
      ),
    );
  }


}
