import 'package:flutter/material.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/presentation/component/texts/black_texts.dart';

class TripDetailsWidget extends StatelessWidget {
  final String label;
  final String text;
  const TripDetailsWidget({Key? key, required this.label, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: 16.paddingHorizontal+8.paddingVert,
          decoration: BoxDecoration(
            color: Color(0xffFCF4FF).withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: BlackMediumText(label: label,fontSize: 13,),
          ),
        ),
        8.height,
        BlackRegularText(label: text,fontSize: 13,)
      ],
    );
  }
}
