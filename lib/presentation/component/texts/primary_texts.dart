
import 'package:flutter/cupertino.dart';

import '../../../core/resources/color.dart';
import '../../../core/resources/styles.dart';


class PrimaryBoldText extends StatelessWidget {
  final String label;
  final TextAlign textAlign;
  final TextStyle? labelStyle;
  final Color? labelColor;
  final double? fontSize;

  const PrimaryBoldText({
    Key? key,
    required this.label,
    this.textAlign = TextAlign.start,
    this.labelStyle,
    this.labelColor,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: textAlign,
      style: labelStyle ??
          TextStyles.font21Bold.copyWith(fontSize: (fontSize!=null?fontSize!-2:null)  ?? 21, color: labelColor??primaryColor),
    );
  }
}

class PrimaryRegularText extends StatelessWidget {
  final String label;
  final TextAlign textAlign;
  final TextStyle? labelStyle;
  final Color? labelColor;
  final double? fontSize;

  const PrimaryRegularText({
    Key? key,
    required this.label,
    this.textAlign = TextAlign.start,
    this.labelStyle,
    this.labelColor,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: textAlign,
      style: labelStyle ??
          TextStyles.font16Regular.copyWith(fontSize: (fontSize!=null?fontSize!-2:null)  ?? 16, color: labelColor??primaryColor),
    );
  }
}
class PrimaryMediumText extends StatelessWidget {
  final String label;
  final TextAlign textAlign;
  final TextStyle? labelStyle;
  final Color? labelColor;
  final double? fontSize;

  const  PrimaryMediumText({
    Key? key,
    required this.label,
    this.textAlign = TextAlign.start,
    this.labelStyle,
    this.labelColor,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: textAlign,
      style: labelStyle ??
          TextStyles.font18Mid.copyWith(fontSize: (fontSize!=null?fontSize!-2:null)  ?? 18, color: labelColor??primaryColor),
    );
  }
}

class PrimarySemiBoldText extends StatelessWidget {
  final String label;
  final TextAlign textAlign;
  final TextStyle? labelStyle;
  final Color? labelColor;
  final double? fontSize;

  const PrimarySemiBoldText({
    Key? key,
    required this.label,
    this.textAlign = TextAlign.start,
    this.labelStyle,
    this.labelColor,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: textAlign,
      style: labelStyle ??
         TextStyles.font21SimBold.copyWith(fontSize: (fontSize!=null?fontSize!-2:null)  ?? 21, color: labelColor??primaryColor),
    );
  }
}