import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:q_trip_user/core/assets_constant/images.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/utils/contact_helper.dart';

import '../../data/model/response/social_medail_model.dart';
import '../../generated/assets.dart';
import 'icon_widget.dart';

class SocialMediaWidget extends StatelessWidget {
  final List<SocialMediaModeLink> list;

  const SocialMediaWidget({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: list.map<Widget>((e) => getSocialMediaWidget(title: e.url??'',url: e.url??'')).toList(),
    );
  }
}

Widget getSocialMediaWidget({required String title,required String url}) {
  if (title.contains('facebook')) {
    return socialWidgetsList(url: url)[0];
  } else if (title.contains('x.com')) {
    return socialWidgetsList(url: url)[1];
  } else if (title.contains('tiktok')) {
    return socialWidgetsList(url: url)[2];
  } else if (title.contains('instagram')) {
    return socialWidgetsList(url: url)[3];
  } else {
    return SizedBox.shrink();
  }
}

class SocialModel {
  final String title;
  final Widget widget;

  SocialModel({required this.title, required this.widget});
}

List<Widget> socialWidgetsList({required String url}) => [
  IconWidget(
    width: 40.w,
    onTap: (){
      ContactHelper.launchURL(url);
    },
    height: 40.h,
    widget: Padding(
      padding: 8.paddingAll,
      child: SvgPicture.asset(AppImages.face),
    ),
  ),
  IconWidget(
    width: 40.w,
    onTap: (){
      ContactHelper.launchURL(url);
    },
    height: 40.h,
    widget: Padding(
      padding: 8.paddingAll,
      child: SvgPicture.asset(AppImages.x),
    ),
  ),
  IconWidget(
    width: 40.w,
    onTap: (){
      ContactHelper.launchURL(url);
    },
    height: 40.h,
    widget: Padding(
      padding: 8.paddingAll,
      child: SvgPicture.asset(AppImages.tik),
    ),
  ),
  IconWidget(
    width: 40.w,
    onTap: (){
      ContactHelper.launchURL(url);
    },
    height: 40.h,
    widget: Padding(
      padding: 8.paddingAll,
      child: SvgPicture.asset(AppImages.instgram),
    ),
  ),
];
