// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:q_trip_user/core/extensions/extensions.dart';
// import 'package:slider_button/slider_button.dart';
// import '../../../core/resources/color.dart';
// import '../../../core/resources/styles.dart';
// import '../texts/black_texts.dart';
// import '../texts/hint_texts.dart';
// class SwipeButtonWidget extends StatelessWidget {
//   final String text;
//   final Widget? icon;
//   final Color? backgroundColor;
//  final Future<bool?> Function() action;
//   const SwipeButtonWidget({super.key, required this.text, this.backgroundColor, this.icon, required this.action, });
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       Padding(
//         padding: 16.paddingHorizontal,
//         child: Center(
//           child:
//          Directionality(
//           textDirection: TextDirection.ltr,
//           child:  SliderButton(
//               radius: 50,
//               width: MediaQuery.sizeOf(context).width*0.8,
//               backgroundColor: backgroundColor??primaryColor,
//               action: action,
//               baseColor: Colors.white,
//               buttonSize: 50,
//               highlightedColor: Colors.black45,
//               alignLabel: Alignment.center,
//               label:Text(text,style: TextStyles.font16Regular.copyWith(color: Colors.black),),
//               // BlackMediumText(
//               //   label:text,
//               //   fontSize: 16,
//               //   labelColor: Colors.white,
//               // ),
//               icon: icon ?? Icon(Icons.arrow_forward, color:backgroundColor ,size: 40,)
//
//           ),
//       )));
//
//   }
// }
