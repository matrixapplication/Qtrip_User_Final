import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/resources.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';

class PagePopup extends StatelessWidget {
  final PageViewData imageData;

  const PagePopup({Key? key, required this.imageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: <Widget>[
        Expanded(
          flex: 8,
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 120,
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.asset(
                  imageData.assetsImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(tr(imageData.titleText),
              textAlign: TextAlign.center,
              style: const TextStyle().titleStyle(fontSize: 24)),
        ),
        Expanded(
          flex: 2,
          child: FittedBox(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: kScreenPaddingNormal.w),
              width: deviceWidth,
              child: Text(
                tr(imageData.subText),
                textAlign: TextAlign.center,
                style: const TextStyle().descriptionStyle(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PageViewData {
  final String _titleText;
  final String _subText;
  final String _assetsImage;

  const PageViewData({
    required String titleText,
    required String subText,
    required String assetsImage,
  })  : _titleText = titleText,
        _subText = subText,
        _assetsImage = assetsImage;


  String get assetsImage => _assetsImage;

  String get subText => _subText;

  String get titleText => _titleText;
}