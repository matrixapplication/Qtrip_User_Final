import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';

import '../texts/black_texts.dart';
import 'base_form.dart';

class CustomTextFieldNormal extends StatelessWidget {
  final String? suffixText;
  final String? hint;
  final String? defaultValue;
  final String? label;
  final String? iconSVG;
  final String? title;

  final bool readOnly;
  final bool isHorizontal;
  final bool autoValidate;
  final bool noBorder;
  final bool isRequired;
  final bool autofocus;
  final bool enable;

  final int? lines;
  final int? maxLength;

  final double? fontSize;
  final double? radius;
  final double? contentPaddingH;

  final List<TextInputFormatter>? formatter;

  final Widget? icon;
  final Widget? prefixWidget;
  final Widget? suffixData;
  final TextInputType? textInputType;

  final IconData? iconData;
  final IconData? suffixIconData;

  final Color? background;

  final VoidCallback? onTap;
  final ValueChanged<String>? onChange;
  final Function? validateFunc;
  final Function? onSubmit;

  final TextEditingController? controller;
  final TextInputAction? textInputAction;

  CustomTextFieldNormal({
    Key? key,
    this.suffixText,
    this.hint,
    this.title,
    this.defaultValue,
    this.label,
    this.iconSVG,
    this.isHorizontal = false,
    this.autoValidate = false,
    this.readOnly = false,
    this.noBorder = false,
    this.isRequired = true,
    this.textInputType,

    this.autofocus = false,
    this.enable = true,
    this.lines,
    this.maxLength,
    this.fontSize,
    this.radius,
    this.contentPaddingH,
    this.formatter,
    this.icon,
    this.prefixWidget,
    this.suffixData,
    this.iconData,
    this.suffixIconData,
    this.background,
    this.onTap,
    this.onChange,
    this.validateFunc,
    this.onSubmit,
    this.controller,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title!=null?
          Padding(padding: 8.paddingBottom+5.paddingStart,
            child:  BlackRegularText(label: title??'',fontSize: 16.sp,fontWeight: FontWeight.w300,),
          ):const SizedBox.shrink(),
          CustomTextField(
            background: background,
            icon: icon,
            prefixIcon: iconData,
            // prefixWidget:iconSVG==null?null: SizedBox(height: 20.r,width: 20.r,child: Center(child:SVGIcon(iconSVG!,color: Colors.black,)  )),

            isHorizontal: isHorizontal,
            defaultValue: defaultValue,
            hint: hint,
            onTap: onTap,
            maxLength: maxLength,
            readOnly: readOnly,
            autoValidate: autoValidate,
            enable: enable,
            noBorder: noBorder,
            isRequired: isRequired,
            label: label,
            contentPaddingH: contentPaddingH,
            lines: lines,
            fontSize: fontSize,
            radius: radius,
            onChange: onChange,
            suffixIconData: suffixIconData,
            validateFunc: validateFunc ,
            suffixText: suffixText,
            formatter: formatter,
            type:textInputType?? TextInputType.text,
            controller: controller ?? TextEditingController(),
            suffixData: suffixData,
            onSubmit: onSubmit,
            autofocus: autofocus,
            textInputAction: textInputAction,
          )
        ],
      );
  }
}
