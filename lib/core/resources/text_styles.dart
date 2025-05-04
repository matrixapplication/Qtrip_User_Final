import 'package:flutter/material.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';


import '../resources/resources.dart';
import '../resources/color.dart';


extension TextCustom on TextStyle {


  TextStyle textFamily({String? fontFamily} ) => (this).copyWith(fontFamily: fontFamily);
  TextStyle underLineStyle() => (this).copyWith(decoration: TextDecoration.underline);
  TextStyle ellipsisStyle({int line = 1}) => (this).copyWith( overflow: TextOverflow.ellipsis,);
  TextStyle heightStyle({double height = 1}) => (this).copyWith( height: height);

  TextStyle boldBlackStyle() => (this).copyWith(fontWeight: FontWeight.bold,color: Colors.black);
  TextStyle boldActiveStyle() => (this).copyWith(fontWeight: FontWeight.bold,color: primaryColor);
  TextStyle highlightStyle() => (this).copyWith(color: hoverColor);

  TextStyle errorStyle() => (this).copyWith(color: errorColor);
  TextStyle blackStyle() => (this).copyWith(color: Colors.black);
  TextStyle activeColor() => (this).copyWith(color: primaryColor);
  TextStyle customColor(Color color) => (this).copyWith(color: color);
  TextStyle colorWhite() => (this).copyWith(color: Colors.white);
  TextStyle liteColor() => (this).copyWith(color: cardColor);
  TextStyle activeLiteColor() => (this).copyWith(color: primaryColorLight);
  TextStyle activeDarkColor() => (this).copyWith(color: primaryColorDark);
  TextStyle hintStyle() => (this).copyWith(color: textSecondary);
  TextStyle darkTextStyle() => (this).copyWith(color: textPrimaryDark);

  TextStyle boldStyle() => (this).copyWith(fontWeight: FontWeight.bold);
  TextStyle semiBoldStyle({double height = 1}) => (this).copyWith( fontWeight: FontWeight.w600,);
  TextStyle boldLiteStyle() => (this).copyWith(fontWeight: FontWeight.w500);

  TextStyle titleStyle({double fontSize = 16}) => (this).copyWith(fontSize: fontSize.sp-2, color: textPrimary, fontWeight: FontWeight.w700, fontFamily: FontConstants.fontFamily );
  TextStyle regularStyle({double fontSize = 14}) => (this).copyWith(fontSize: fontSize.sp-2, color: textPrimary, fontWeight: FontWeight.w400, fontFamily: FontConstants.fontFamily );
  TextStyle descriptionStyle({double fontSize = 12}) => (this).copyWith(fontSize: fontSize.sp-2, color: textSecondary, fontWeight: FontWeight.w300, fontFamily: FontConstants.fontFamily );


}

