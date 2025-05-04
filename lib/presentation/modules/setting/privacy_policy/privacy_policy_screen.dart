import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/resources.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';
import 'package:q_trip_user/generated/locale_keys.g.dart';
import 'package:q_trip_user/presentation/component/component.dart';

import '../../../../core/assets_constant/images.dart';
import '../../../../generated/assets.dart';
import '../../../component/social_media_widget.dart';
import '../../get_social_media/get_social_media_screen.dart';
import 'privacy_policy_cubit.dart';


_getData(BuildContext context, {required bool reload}) =>
  BlocProvider.of<PrivacyPolicyCubit>(context, listen: false).getPrivacyPolicy(reload: reload);




class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {

  @override
  void initState() {
    _getData(context, reload: true);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title: tr(LocaleKeys.privacyPolicy),),
      body: Padding(
        padding: EdgeInsets.all(kScreenPaddingNormal.r),
        child:
        Column(
          children: [
            Expanded(child:
            BlocBuilder<PrivacyPolicyCubit, PrivacyPolicyState>(
              buildWhen:(previous, current)=> (current is  PrivacyPolicyGotSuccessfully ||current is PrivacyPolicyLoading),
              builder: (context, state) => ScreenStateLayout(
                isLoading: (state is PrivacyPolicyLoading),
                onRetry: () => _getData(context, reload: true),
                builder: (context) {
                  return ListAnimator(
                    children: [
                      SvgPicture.asset(AppImages.terms3,height: 170.h,),
                      16.height,
                      Html(
                        data: (state is PrivacyPolicyGotSuccessfully)?state.privacyPolicy:'',
                      ),
                      // Text((state is PrivacyPolicyGotSuccessfully)?state.privacyPolicy:'',style: const TextStyle().regularStyle(),),
                    ],
                  );
                }
              ),
            ),
            ),
            const GetSocialMediaWidget(),
          ],
        )


      ),
    );
  }
}
