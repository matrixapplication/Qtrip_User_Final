import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:q_trip_user/core/assets_constant/images.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/generated/assets.dart';
import 'package:q_trip_user/presentation/component/icon_widget.dart';
import '../../core/resources/values_manager.dart';
import '../../core/routing/navigation_services.dart';
import '../../core/utils/language_helper.dart';
import '../../generated/locale_keys.g.dart';
import '../component/custom_button.dart';
import '../component/texts/black_texts.dart';
import 'base/simple_dialogs.dart';

Future showPickUpImageDialog({final void Function()? onTapCamera,final void Function()? onTapGallery,required BuildContext context}) async =>
    showCustomDialog(context, _buildBody(context: context,onTapCamera: onTapCamera,onTapGallery: onTapGallery), onDismissCallback: ()=>NavigationService.goBack() ,isCancellable: true);


_buildBody({final void Function()? onTapCamera,final void Function()? onTapGallery,required BuildContext context}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: kScreenPaddingNormal.h),
    child: StatefulBuilder(
      builder: (context, setState) {
        return Container(
          color: Colors.white,
          margin: 16.paddingHorizontal,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconWidget(
                    onTap: ()=>Navigator.pop(context),
                    widget: Icon(
                      Icons.clear,
                      color: Colors.black,
                      size: 25.r,
                    ),
                  ),
                  BlackRegularText(
                    label: tr(LocaleKeys.selectImage),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),

                  30.width,
                ],
              ),
              5.height,
              BlackRegularText(
                label: tr(LocaleKeys.selectImageMess),
                fontSize: 12.sp,
                fontWeight: FontWeight.w300,
              ),
              20.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: onTapCamera,
                    child: Column(
                      children: [
                        IconWidget(
                          widget: Padding(
                            padding: 8.paddingAll,
                            child: SvgPicture.asset(AppImages.camera),
                          ),
                        ),
                        12.height,
                        BlackRegularText(label: tr(LocaleKeys.camera),fontSize: 16,)
                      ],
                    ),
                  ),
                  32.width,
                  InkWell(
                    onTap: onTapGallery,
                    child: Column(
                      children: [
                        IconWidget(
                          widget:
                          Padding(
                            padding: 8.paddingAll,
                            child: SvgPicture.asset(AppImages.gallery),
                          ),
                        ),
                        12.height,
                        BlackRegularText(label: tr(LocaleKeys.gallery),fontSize: 16,)
                      ],
                    ),
                  )
                ],
              ),
              16.height,

            ],
          ),
        );
      },
    ),
  );
}
