import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:q_trip_user/core/assets_constant/images.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/presentation/component/component.dart';
import '../../../core/routing/navigation_services.dart';
import '../../../core/routing/routes.dart';
import '../../../generated/locale_keys.g.dart';
import '../../component/custom_text_row.dart';
import '../../dialog/show_delete_account_dialog.dart';
import '../../dialog/show_langauge_dialog.dart';
import '../../dialog/show_logout_dialog.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: tr(LocaleKeys.settings),  color: Theme.of(context).cardColor),
      body:
      Padding(
        padding: 16.paddingHorizontal+8.paddingVert,
        child: ListAnimator(
          children: [
            CustomTextRowWidget(image: AppImages.pass,title: tr(LocaleKeys.managePassword),onTap: (){NavigationService.push(Routes.changePasswordScreen);},),
            CustomTextRowWidget(image: AppImages.lang,title: tr(LocaleKeys.Language),onTap: (){showLanguageDialog(context);},),
            CustomTextRowWidget(image: AppImages.delete,title: tr(LocaleKeys.deleteAccount),onTap: (){showDeleteAccountDialog(context);},),
            CustomTextRowWidget(image: AppImages.logout,title: tr(LocaleKeys.logOut),onTap: (){ showLogOutDialog(context);},color: Colors.red,),
          ],
        ),
      )
    );
  }
}
