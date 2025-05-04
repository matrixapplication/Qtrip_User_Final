import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/color.dart';
import 'package:q_trip_user/core/resources/resources.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';
import 'package:q_trip_user/core/routing/navigation_services.dart';
import 'package:q_trip_user/core/routing/routes.dart';
import 'package:q_trip_user/core/utils/globals.dart';
import 'package:q_trip_user/presentation/component/icon_widget.dart';
import 'package:q_trip_user/presentation/component/images/custom_image.dart';
import 'package:q_trip_user/presentation/component/texts/black_texts.dart';
import '../../../../core/assets_constant/images.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../setting/profile/profile_cubit.dart';
import '../home_cubit.dart';

enum MenuScreenEnum {setting,home,wallet,language,history,logOut}

class NavigationDrawerWidget extends StatelessWidget {
  const   NavigationDrawerWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Theme.of(context).cardColor,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            _buildProfileWidget(context),
            _buildMenuItem(context: context, title: tr(LocaleKeys.editProfile), icon: Icons.person,image: AppImages.edit2, onTap: () {
              NavigationService.push(Routes.profileScreen);
            }),

        Padding(padding: 12.paddingStart+30.paddingTop,
          child:  Text(tr(LocaleKeys.more),style:const TextStyle().regularStyle().blackStyle().copyWith(
              fontWeight: FontWeight.w500
          ),),
        ),
            12.height,
            _buildMenuItem(context: context, title: tr(LocaleKeys.myTrips), icon: CupertinoIcons.house_fill, image: AppImages.clock, onTap: () { NavigationService.push(Routes.myTripsScreen);}),
            // _buildMenuItem(context: context, title: tr(LocaleKeys.currentTrip), icon: CupertinoIcons.house_fill, image: AppImages.re, onTap: () {
            //   BlocProvider.of<HomeCubit>(context).getLastTrip(context);
            //
            //   // LayoutCubit layoutCubit =getIt<LayoutCubit>();
            //   // layoutCubit.getTrips();
            //   // context.pop();
            // }),
            _buildMenuItem(context: context, title:tr(LocaleKeys.payment), icon: CupertinoIcons.house_fill, image: AppImages.payment, onTap: () {NavigationService.push(Routes.walletScreen);}),
            // _buildMenuItem(context: context, title: tr(LocaleKeys.help), icon: CupertinoIcons.house_fill, image:AppImages.help,onTap: () {}),
            _buildMenuItem(context: context, title: tr(LocaleKeys.settings), icon: CupertinoIcons.house_fill, image: AppImages.setting, onTap: () { NavigationService.push(Routes.settingScreen);}),
            _buildMenuItem(context: context, title: tr(LocaleKeys.aboutUs), icon: CupertinoIcons.house_fill, image: AppImages.about, onTap: () { NavigationService.push(Routes.aboutUsScreen);}),
            _buildMenuItem(context: context, title: tr(LocaleKeys.privacyPolicy), icon: CupertinoIcons.house_fill, image: AppImages.terms, onTap: () {
              NavigationService.push(Routes.privacyPolicyScreen);}),
            _buildMenuItem(context: context, title: tr(LocaleKeys.contactUs2), icon: CupertinoIcons.house_fill, image: AppImages.contact, onTap: () { NavigationService.push(Routes.contactUsScreen);}),
            _buildMenuItem(context: context, title: tr(LocaleKeys.contactUstermsAndConditions), icon: CupertinoIcons.house_fill, image: AppImages.terms, onTap: () {
              NavigationService.push(Routes.termsScreen);
            }),
            20.height

          ],
        ),
      ),
    );
  }

  Widget _buildProfileWidget(BuildContext context){
    return Container(
      color: Colors.white,
      padding:  12.paddingHorizontal+20.paddingTop,
      child:

      BlocConsumer<ProfileCubit,ProfileState>(
        listener: (context,state){},
        builder: (context,state){
          return
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Stack(
                      children: [
                        Padding(padding: EdgeInsets.only(bottom: 12),
                          child:
                          CustomImage(imageUrl:  kUser?.image??'',height: 65.h,
                            width: 65.h,radius: 100,),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(kFormRadiusLarge),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 2.r,horizontal: 5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 17,
                                    ),
                                    BlackRegularText(label: kUser?.rate??'',fontSize: 13,fontWeight: FontWeight.w500,),
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),

                    const Spacer(),
                    IconWidget(
                      onTap: ()=>context.pop(),
                    )
                  ],
                ),
                10.height,
                Padding(padding: 12.paddingStart,
                  child:  Text(kUser?.name??'',style:const TextStyle().regularStyle().blackStyle().copyWith(
                      fontWeight: FontWeight.w500
                  )),
                )
              ],
            );
        },
      )


    );
  }


  Widget _buildMenuItem({required BuildContext context, required String title, required IconData icon, required GestureTapCallback onTap,String? image }) {
    final color = Theme.of(context).hintColor;
    const hoverColor = Colors.white70;
    return ListTile(
      leading:

      SizedBox(width: kTextFieldIconSize,height:kTextFieldIconSize,child:
      image!=null?
      SvgPicture.asset(image??'',height: 50,width: 50,fit: BoxFit.cover,color: primaryColor,):
      Icon(icon, color: primaryColor)),
      // leading: SizedBox(width: kTextFieldIconSize,height:kTextFieldIconSize,child: SvgPicture.asset(image, color: color,width: kTextFieldIconSize,height:kTextFieldIconSize,)),
      title:
      BlackRegularText(label:title ,fontSize: 18,fontWeight: FontWeight.w300,labelColor: blue3Color,),
      hoverColor: Theme.of(context).hoverColor,
      trailing: Container(
        width: kTextFieldIconSize,height:kTextFieldIconSize,
        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child:  Icon(Icons.arrow_forward,color: blackColor.withOpacity(0.8),size: kTextFieldIconSize,),
      ),
      onTap: onTap,
    );
  }



}
