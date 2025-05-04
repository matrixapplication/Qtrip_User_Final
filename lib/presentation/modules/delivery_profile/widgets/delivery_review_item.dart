import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/color.dart';
import 'package:q_trip_user/presentation/component/images/custom_image.dart';
import 'package:q_trip_user/presentation/component/texts/black_texts.dart';

class DeliveryReviewItem extends StatelessWidget {
  final String image;
  final String label;

  const DeliveryReviewItem({Key? key, required this.image,required this.label,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomImage(imageUrl: image,width: 72.w,height: 72.w,radius: 50,),
          4.height,
          BlackRegularText(label: label,fontWeight: FontWeight.w300,fontSize: 10),

        ],
      ),
    );
  }
}
