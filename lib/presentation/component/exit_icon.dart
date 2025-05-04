import 'package:flutter/material.dart';

class ExitIcon extends StatelessWidget {
  const ExitIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: ShapeDecoration(color: Colors.grey[400], shape: const CircleBorder(),),
        child: const Padding(
          padding: EdgeInsets.all(1.0),
          child: Icon(
            Icons.close,
            size: 15,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
