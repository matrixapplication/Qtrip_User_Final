import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/resources/color.dart';
import 'package:q_trip_user/presentation/component/texts/black_texts.dart';

class DeliveryProfileItem extends StatelessWidget {
  final String image;
  final String label;
  final String text;

  const DeliveryProfileItem({Key? key, required this.image,required this.label, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 16.paddingHorizontal+8.paddingVert,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(2, 6),
          ),
        ],

      ),
      child: Column(
        children: [
          SvgPicture.asset(image),
          4.height,
          BlackRegularText(label: label,fontWeight: FontWeight.w300,fontSize: 16),
          4.height,
         BlackMediumText(label: text,fontSize: 16,labelColor: blue4Color,)
        ],
      ),
    );
  }
}
