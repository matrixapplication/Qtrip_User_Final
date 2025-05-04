
import 'package:flutter/material.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/decoration.dart';
import 'package:q_trip_user/presentation/component/component.dart';

import '../../../core/resources/resources.dart';
import 'custom_image.dart';



class ItemPickedImage extends StatelessWidget {
  final String? _path;
  final GestureTapCallback? _onRemovePressed;
  const ItemPickedImage({super.key,
    required String? path,
    required GestureTapCallback? onRemovePressed,
  })  : _path = path,
        _onRemovePressed = onRemovePressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: _onRemovePressed,
      child: Container(
        decoration: const BoxDecoration().listStyle(),
        height: 150,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomImage(imageUrl: _path, height: 150.h),
            Visibility(visible: _onRemovePressed != null, child: Container(  decoration: const BoxDecoration().listStyle().customColor(Colors.black45.withOpacity(.3)),),),
            Visibility(visible: _onRemovePressed != null, child: const Icon(Icons.clear, color: Colors.white, size: kTextFieldIconSize)),
          ],
        ),
      ),
    );
  }
}
