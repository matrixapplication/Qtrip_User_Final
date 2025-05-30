import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';

import '../../../../core/resources/color.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../component/texts/black_texts.dart';

class VehiclesTypeWidget extends StatefulWidget {
  final String image;
  final String title;
  final String price;
  final String description;
  final bool value;
  final bool? groupValue;
  final void Function(bool?)? onChanged;
  const VehiclesTypeWidget({Key? key, required this.value, this.groupValue, required this.onChanged, required this.image, required this.title, required this.description, required this.price}) : super(key: key);

  @override
  _DriverTypeWidgetState createState() => _DriverTypeWidgetState();
}

class _DriverTypeWidgetState extends State<VehiclesTypeWidget> {
  @override
  Widget build(BuildContext context) {
    bool isSelected = widget.value ==widget.groupValue!;
    return
      DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(25),
      strokeCap: StrokeCap.square,
      strokeWidth: 1,
      color: isSelected?primaryColor:Colors.transparent,
      dashPattern: const [5,5],
      child:
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color:isSelected? const Color(0xffFCF4FF):Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(5,8)
            )
          ]
        ),
        width: double.infinity,
        height: 70.h,
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 16.width,
                  SvgPicture.asset(widget.image,
                    // width: 60.w,
                    // height: 30.h,
                  ),
                  16.width,
                  BlackBoldText(label: widget.title,fontSize: 16,),
                  // Radio(
                  //   value: widget.value,
                  //   groupValue: widget.groupValue,
                  //   onChanged: widget.onChanged,
                  // ),
                  // 16.width,

                ],
              ),

            ),
            5.height,
            BlackRegularText(label: widget.description,fontSize: 13,),

          ],
        )
      ),
    );
  }
}
