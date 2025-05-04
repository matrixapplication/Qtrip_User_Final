import 'package:flutter/cupertino.dart';
import 'custom_loading_spinner.dart';

class CustomLoadingWidget extends StatelessWidget {
  final Color? color;
  const CustomLoadingWidget({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    // return   SpinKitCircle(
    //   color:color?? AppColors.primaryColor,
    //   size: 50.0,
    // );
    return CustomLoadingSpinner(color: color,);
  }
}
