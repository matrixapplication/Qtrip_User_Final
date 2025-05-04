import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/resources/color.dart';
import '../../core/routing/navigation_services.dart';
import '../../generated/locale_keys.g.dart';
import 'input_decoration.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Icon? prefixIcon;
  final IconButton? suffixIcon;
  final bool? enabled;
  final int? maxLines;
  final bool? isPassword;
  final double? borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? validationMessage;
  final Color? hintColor;
  final String?  hintFontFamily  ;
  final Color? prefixIconColor;
  final double? contentHorizontalPadding;
  final double? contentVerticalPadding;
  final Color? fillColor;
  final Color? borderColor;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final String? Function(String?)? validationFunc;
  final void Function(String)? onFieldSubmitted;
  final TextStyle? hintStyle;
  final void Function(String)? onChanged;
   const CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    this.prefixIconColor,
    this.fillColor,
    this.contentHorizontalPadding,
    this.contentVerticalPadding,
    this.maxLines,
    this.hintFontFamily,
    this.validationMessage,
    this.isPassword,
    this.borderColor,
    this.fontWeight,
    this.fontSize,
    this.borderRadius,
    this.enabled,
    this.textInputType,
    this.textInputAction,
    this.validationFunc,
    this.hintStyle,
    this.hintColor,
    this.suffixIcon,
    this.onFieldSubmitted,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isVisibility = false;
     if(isPassword==true){
       isVisibility=true;
     }
    return
      StatefulBuilder(builder: (context,setState){
        return   TextFormField(
          onFieldSubmitted: onFieldSubmitted,
          controller: controller,
          obscureText:  isVisibility,
          maxLines: maxLines ?? 1,
          decoration:
          customInputDecoration(
            fontSize: fontSize,
            fontWeight: fontWeight,
            hintStyle:hintStyle ,
            hintText: hintText,
            contentHorizontalPadding: contentHorizontalPadding,
            contentVerticalPadding: contentVerticalPadding,
            borderRadius: borderRadius,
            borderColor: borderColor,
            prefixIconColor: prefixIconColor,
            prefixIcon: prefixIcon,
            hintFontFamily: hintFontFamily,
            suffixIcon: isPassword==true ?
            IconButton(
              icon: Icon(
                isVisibility==true ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: isVisibility==true ?  hintColor:primaryColor,
              ),
              onPressed: () {
                isVisibility = !isVisibility;
                setState(() {});
              },
            ) :
           null,
            enabled: enabled,
            hintColor: hintColor,
            fillColor: fillColor,
          ),
          validator:validationFunc??(value) {
            if (value == null || value.isEmpty) {
              return LocaleKeys.this_field_required.tr();
            }
            return null;
          } ,
          onSaved: (String? val) {
            controller.text = val!;
          },

          cursorWidth: 1,
          textInputAction: textInputAction ?? TextInputAction.next,
          keyboardType: textInputType ?? TextInputType.text,
          onChanged:onChanged ,
        );
      });
  }
}
InputDecoration customInputDecration({
  String? hintText,
  TextEditingController? controller,
  Icon? prefixIcon,
  Color? prefixIconColor,
  Color? fillColor,
  double? contentHorizontalPadding,
  double? contentVerticalPadding,
  int? maxLines,
  String? hintFontFamily,
  String? validationMessage,
  bool? isPassword,
  Color? borderColor,
  FontWeight? fontWeight,
  double? fontSize,
  double? borderRadius,
  bool? enabled,
  TextInputType? textInputType,
  TextInputAction? textInputAction,
  String? Function(String?)? validationFunc,
  TextStyle? hintStyle,
  Color? hintColor,
  IconButton? suffixIcon,
}) {
  bool isBorderEnabled = enabled ?? true;
  return InputDecoration(
    hintText: hintText,
    filled: true,
    fillColor: fillColor,
    contentPadding: EdgeInsets.symmetric(
      horizontal: contentHorizontalPadding ?? 16.0,
      vertical: contentVerticalPadding ?? 12.0,
    ),
    border: isBorderEnabled ? OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor ?? Colors.black, // Adjust the color here
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
    ) : InputBorder.none, // Use InputBorder.none when not enabled
    enabledBorder: isBorderEnabled ? OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor ?? Colors.black, // Adjust the color here
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
    ) : InputBorder.none, // Use InputBorder.none when not enabled
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor ?? Theme.of(NavigationService.navigationKey.currentContext!).primaryColor, // Adjust the color here
        width: 2.0,
      ),
      borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
    ),

    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
    ),
    hintStyle: hintStyle,
    prefixIcon: prefixIcon,
    prefixIconColor: prefixIconColor,
    suffixIcon: suffixIcon,
    errorStyle: TextStyle(fontSize: 12.0),
    counterText: '',
  );
}
