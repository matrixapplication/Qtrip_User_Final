

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';

import '../../core/assets_constant/images.dart';
import '../../core/functions/get_andriod_vergion.dart';
import '../../core/resources/values_manager.dart';
import '../../core/routing/navigation_services.dart';
import '../../core/routing/routes.dart';
import '../../core/utils/language_helper.dart';
import '../../core/utils/show_toast.dart';
import '../../generated/assets.dart';
import '../../generated/locale_keys.g.dart';
import '../component/custom_button.dart';
import '../component/texts/black_texts.dart';
import '../modules/select_car/widgets/more_item.dart';
import 'base/simple_dialogs.dart';
String? kLangCode;
Future showLanguageDialog(BuildContext context,) async =>
    showCustomDialog(context, _buildBody(context), onDismissCallback: ()=>NavigationService.goBack() ,isCancellable: true);


_buildBody(BuildContext context) {
  bool? isAr = kIsArabic;

  return Padding(
    padding: EdgeInsets.symmetric(vertical: kScreenPaddingNormal.h),
    child: StatefulBuilder(
      builder: (context, setState) {
        return Container(
          color: Colors.white,
          margin: 0.paddingHorizontal,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: 16.paddingHorizontal,
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.clear,
                    color: Colors.black,
                    size: 25.r,
                  ),
                ),
              ),
              BlackRegularText(
                label: tr(LocaleKeys.selectLanguage),
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
              Column(
                children: [
                  RadioListTile(
                    title: BlackRegularText(
                      label: tr(LocaleKeys.arabic),
                      fontSize: 16.sp,
                    ),
                    value: true,
                    groupValue: isAr,
                    onChanged: (bool? value) {
                      setState(() {
                        isAr = value!;
                        kLangCode='ar';
                      });
                    },
                  ),
                  RadioListTile(
                    title: BlackRegularText(
                      label: tr(LocaleKeys.english),
                      fontSize: 16.sp,
                    ),
                    value: false,
                    groupValue: isAr,
                    onChanged: (bool? value) {
                      setState(() {
                        isAr = value!;
                        kLangCode='en';
                      });
                    },
                  ),
                  12.height,
                  Container(
                    margin: 16.paddingHorizontal,
                    child: CustomButton(
                      onTap: () async {
                        if (isAr == true) {
                          await context.setLocale(const Locale('ar')).then((value) {
                            setState(() {}); // تحديث النصوص
                            Future.delayed(const Duration(milliseconds: 1), () {
                              NavigationService.goBack();
                            });

                          });
                        } else {
                          await context.setLocale(const Locale('en')).then((value) {
                            setState(() {}); // تحديث النصوص
                            Future.delayed(const Duration(milliseconds: 1), () {
                              NavigationService.goBack();
                            });
                          });
                        }
                      },
                      raduis: 50,
                      title: tr(LocaleKeys.confirm),
                      width: double.infinity,
                      height: 35.h,
                    ),
                  ),
                  8.height,
                ],
              ),
            ],
          ),
        );
      },
    ),
  );
}
