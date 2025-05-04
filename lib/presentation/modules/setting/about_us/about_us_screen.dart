import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:q_trip_user/core/assets_constant/images.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/presentation/component/component.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../get_social_media/get_social_media_screen.dart';
import 'about_us_cubit.dart';


_getData(BuildContext context, {required bool reload}) =>
  BlocProvider.of<AboutUsCubit>(context, listen: false).getAboutUs(reload: reload);




class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {

  @override
  void initState() {
    _getData(context, reload: true);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title:
      tr(LocaleKeys.aboutUs),
      ),
      body: Padding(
        padding:20.paddingAll,
        child:
       Column(
         children: [
           Expanded(child:  BlocBuilder<AboutUsCubit, AboutUsState>(
             buildWhen:(previous, current)=> (current is  AboutUsGotSuccessfully ||current is AboutUsLoading),
             builder: (context, state) => ScreenStateLayout(
               isLoading: (state is AboutUsLoading),
               onRetry: () => _getData(context, reload: true),
               builder: (context) =>
                   ListAnimator(
                     children: [
                       SvgPicture.asset(AppImages.about2,height: 170.h,),
                       16.height,
                       Html(
                         data: (state is AboutUsGotSuccessfully)?state.aboutUs:'',

                       ),
                       // Text((state is AboutUsGotSuccessfully)?state.aboutUs:'',style: const TextStyle().regularStyle(),)
                     ],
                   ),
             ),
           ),),
           const GetSocialMediaWidget(),
         ],
       )
      ),
    );
  }
}
