import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/parser.dart';

import '../../../generated/locale_keys.g.dart';
import '../../resources/color.dart';

class UpdateChecker {
  static Dio dio = Dio();

  // ✅ جلب الإصدار الأحدث باستخدام Dio
  static Future<Map<String, dynamic>?> getLatestVersion() async {
    try {
     return await FirebaseFirestore.instance.collection('updates').doc('version_user').get().then((value) {
        print('📍 getLatestVersionversion : ${value.data()}');
        return value.data();
      });
    } catch (e) {
      Firebase.initializeApp();
      getLatestVersion();
      print("Error fetching version: $e");
    }
  }

  static Future<void> checkForUpdate(BuildContext context) async {
    // الحصول على الإصدار الحالي
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;
    // الحصول على الإصدار الأحدث
    Map<String, dynamic>? latestVersion = await getLatestVersion();


    if ( latestVersion != null&&latestVersion['ios_version']!=null&&latestVersion['android_version']!=null &&(Platform.isAndroid && currentVersion != latestVersion['android_version']) || (Platform.isIOS && currentVersion != latestVersion?['ios_version'])) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) =>
            WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: AlertDialog(
                title: Text(tr(LocaleKeys.newUpdate),style:  TextStyle().titleStyle(fontSize: 18).copyWith(fontWeight: FontWeight.w400),),
                content: Text(tr(LocaleKeys.newUpdateMess),style:  TextStyle().regularStyle().copyWith(fontSize: 15),),
                actions: [
                  TextButton(
                    onPressed: () {
                      if (Platform.isAndroid) {
                        launchUrl(Uri.parse(
                            'https://play.google.com/store/apps/details?id=com.QTrip&pcampaignid=web_share'));
                      } else if (Platform.isIOS) {
                        launchUrl(Uri.parse(
                            'https://apps.apple.com/us/app/q-trip-user/id6739780221'));
                      }
                    },
                    child: Text(tr(LocaleKeys.updateNow),style:  TextStyle().regularStyle().copyWith(fontSize: 15,color: primaryColor),),
                  ),
                  if(latestVersion?['is_force']!=null && latestVersion?['is_force']==false)
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(tr(LocaleKeys.later),style:  TextStyle().regularStyle().copyWith(fontSize: 15,color: primaryColor),),
                  ),
                ],
              ),),
      );
    }
  }
}