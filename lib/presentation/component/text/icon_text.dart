import 'package:flutter/material.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';

import '../../../core/resources/resources.dart';

class CommonIconTextView extends StatelessWidget {
  final String? text;

  final TextStyle? textStyle;
  final bool underLine;

  final IconData icon;

  final Color? iconColor;
  final Color? textColor;

  final double? iconSize;
  final MainAxisAlignment mainAxisAlignment;
  final double? space;

  const CommonIconTextView({
    Key? key,
    required this.text,
    required this.icon,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.iconSize,
    this.underLine = false,
    this.space,
    this.iconColor,
    this.textColor,
    this.textStyle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Icon(
          icon,
          size: iconSize??kTextFieldIconSize,
          color: iconColor,
        ),
        SizedBox(
          width: space ?? kFormPaddingAllSmall,
        ),
        Text(
          text ?? '',
          style: textStyle??const TextStyle().descriptionStyle().copyWith(color: textColor,    decoration:underLine? TextDecoration.underline:null,),
        )
      ],
    );
  }


}
