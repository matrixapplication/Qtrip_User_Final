import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';

class IconWidget extends StatelessWidget {
  final void Function()? onTap;
  final double? width;
  final Color? color;
  final double? height;
  final Widget? widget;
  final IconData? icon;
  final EdgeInsets? margin;
  const IconWidget({super.key, this.onTap, this.width, this.height, this.color, this.widget, this.icon,  this.margin,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.grey.withOpacity(0.08),
      highlightColor: Colors.grey.withOpacity(0.08),
      child:Container(
        margin: margin??EdgeInsets.symmetric(horizontal: 5.w),
        width: width??40.w,
        height: height??40.w,
        decoration: BoxDecoration(
          color: color?? Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.02),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(4,6),
            ),
          ],
          borderRadius: BorderRadius.circular(10.w),
        ),
        child:
        widget??
         Icon(icon??Icons.arrow_back, color: Colors.black,),
      ),
    );
  }
}
