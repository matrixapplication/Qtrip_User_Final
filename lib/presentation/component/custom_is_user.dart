import 'package:flutter/cupertino.dart';

import '../../core/assets_constant/images.dart';
import '../../main.dart';

class CustomIsUser extends StatelessWidget {
  const CustomIsUser({super.key, required this.isUser, required this.widget, this.hasLogo});
  final bool isUser;
  final bool? hasLogo;
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return isUser==true?widget:
             hasLogo!=null?

             Image.asset(AppImages.logoW2,
               height: MediaQuery.of(context).size.height*0.2,
             )
                 :
               SizedBox.shrink();
  }
}
