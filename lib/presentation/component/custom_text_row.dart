import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/resources/color.dart';
import 'package:q_trip_user/presentation/component/texts/black_texts.dart';

class CustomTextRowWidget extends StatelessWidget {
  final String title;
  final String? image;
  final Color? color;
  final double? fontSize;
  final void Function()? onTap;
  const CustomTextRowWidget({super.key, required this.title, this.fontSize, this.onTap, this.image, this.color});

  @override
  Widget build(BuildContext context) {
    return
    InkWell(
      onTap:onTap,
      child: Container(
        margin: 3.paddingVert,
        padding: 16.paddingHorizontal+12.paddingVert,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 7,
                offset: const Offset(5,8),
              ),
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

           Row(
             children: [
               if(image!=null)
                 ...[
                   SvgPicture.asset(image??'',height: 20, width: 20,),
                   8.width,
                 ],
               BlackRegularText(label: title,fontSize:fontSize?? 17,labelColor: color??blue3Color,),
             ],
           ),
            Icon(Icons.arrow_forward,color: blackColor.withOpacity(0.7)),
          ],
        ),
      ),
    );
  }
}
