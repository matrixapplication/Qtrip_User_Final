import 'package:flutter/material.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';

import '../../../../core/resources/color.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../component/spaces.dart';
import '../../../component/svg_icon.dart';


class MoreItemWidget extends StatelessWidget {
  final String? _label;
  final String? _desc;
  final String? _svgIcon;
  final Color? _color;
  final VoidCallback? _onTap;
  final Widget? _endWidget;
  final double? _margin;


  const MoreItemWidget({super.key,
     Color? color,
     String label='',
     String? desc,
     String? svgIcon,
     VoidCallback? onTap,
     Widget? endWidget,
     double? margin,
  })  : _label = label,
        _color = color,
        _desc = desc,
        _svgIcon = svgIcon,
        _onTap = onTap,
        _endWidget = endWidget,
        _margin = margin;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: 16.paddingHorizontal,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(3,6)
              )
            ]
          ),
          // margin: EdgeInsets.symmetric(horizontal: _margin ?? kScreenPaddingNormal),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(kFormRadiusSmall)),
              onTap: _onTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: kScreenPaddingNormal),
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          if (_svgIcon != null) ...[
                            HorizontalSpace(kFormPaddingAllSmall.w),
                            SVGIcon(_svgIcon!,color: primaryColor,),
                          ],
                          HorizontalSpace(kScreenPaddingNormal.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_label ?? '', style:const TextStyle().regularStyle(fontSize: 14)),
                              if(_desc!=null)
                                Text(_desc ?? '', style:const TextStyle().descriptionStyle()),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h, // اضبط ارتفاع الـ Radio ليكون محدودًا
                      child: _endWidget ?? Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryColor,
                        size: 15.r,
                      ),
                    ),

                    // _endWidget ?? Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryColor, size: 15.r,),
                  ],
                ),
              ),
            ),
          ),
        ),
        const VerticalSpace(kFormPaddingAllSmall),

      ],
    );
  }
}
