
import 'package:flutter/cupertino.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';

import '../../../core/resources/values_manager.dart';



class SheetHeader extends StatelessWidget {
  final VoidCallback onCancelPress;

  final String title;

  const SheetHeader({Key? key,
    required this.onCancelPress,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding:  const EdgeInsets.all(kScreenPaddingNormal),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle().titleStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          GestureDetector(
            onTap: onCancelPress ,
            child:const Icon(CupertinoIcons.clear_circled_solid),
          ),
        ],
      ),
    );

  }
}
