import 'package:flutter/material.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import '../../core/resources/color.dart';
import 'custom_loading_widget.dart';

class CustomElevatedButton extends StatelessWidget {
  final String buttonText;
  final Function onTap;
  final double? borderRadius;
  final Color? fontColor;
  final double? fontSize;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? loadingColor;
  final bool? isLoading;
  final bool? isOutline;

  const CustomElevatedButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.borderRadius,
    this.fontColor,
    this.isOutline,
    this.fontSize,
    this.borderColor,
    this.backgroundColor,this.height, this.width, this.isLoading, this.loadingColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width??20,height?? 30), // Set your desired width and height
        elevation: 0,
        backgroundColor: isOutline==true? Colors.white:backgroundColor ?? primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
          side: BorderSide(color:isOutline==true? primaryColor: borderColor ?? Colors.transparent),
        ),
      ),
      child:
      isLoading==true?
       Center(child: CustomLoadingWidget(color:isOutline==true? primaryColor: loadingColor??Colors.white,),):
      Text(
        buttonText,
        style: TextStyle(
          color: isOutline==true?primaryColor:fontColor ?? Colors.white,
          fontSize: fontSize ?? 13.sp,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
