import 'package:flutter/material.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';

import '../../../generated/assets.dart';

class CustomLogo extends StatelessWidget {
  final double? width;
  final double? height;
  final BoxFit? fit;
  const CustomLogo({Key? key, this.width, this.height, this.fit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(Assets.imagesLogo2,
      width: width??100.h,
      height:height?? 80.h,
      fit: fit??BoxFit.contain,
    );
  }
}
