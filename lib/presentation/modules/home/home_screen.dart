import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/decoration.dart';
import 'package:q_trip_user/presentation/component/icon_widget.dart';
import 'package:q_trip_user/presentation/component/texts/black_texts.dart';
import 'package:q_trip_user/presentation/component/texts/hint_texts.dart';
import 'package:q_trip_user/presentation/modules/home/widgets/navigation_drawer_widget.dart';
import '../../../core/assets_constant/images.dart';
import '../../../core/resources/color.dart';
import '../../../core/resources/values_manager.dart';
import '../../../core/routing/navigation_services.dart';
import '../../../core/routing/routes.dart';
import '../../../core/trip.dart';
import '../../../core/utils/check_update/check_upgrade.dart';
import '../../../domain/request_body/address_body.dart';
import '../../../generated/locale_keys.g.dart';
import '../search/search_cubit.dart';
import '../trip/widget/header_sheet_widget.dart';
import 'home_cubit.dart';
import 'widgets/home_map.dart';
import 'package:easy_localization/easy_localization.dart';



class DeliveryHomeScreen extends StatefulWidget {
  const DeliveryHomeScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<DeliveryHomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SearchCubit>(context).getAddresses();
    FocusManager.instance.primaryFocus?.unfocus();
    TripHelper.checkMyTrip();
    BlocProvider.of<HomeCubit>(context).getLastTrip(context);
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      UpdateChecker.checkForUpdate(context);
    });
  }
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  Widget build(BuildContext context) {
    AddressBody? userLocationModel= BlocProvider.of<HomeCubit>(context, listen: false).userLocationModel;

    return
      WillPopScope(
        onWillPop: ()async {
          // NavigationService.pushNamedAndRemoveUntil(Routes.layoutScreen);
          return false;
        },
        child:
        Scaffold(
          key: _key,
          drawer: const NavigationDrawerWidget(),

          extendBodyBehindAppBar: true,
          // floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
          // appBar: CustomAppBar(color: Colors.transparent,backBackgroundColor:Theme.of(context).cardColor,isBackButtonExist: true,),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              const HomeMap(),
              Positioned(
                top: 40.h,
                left: 20.w,
                child: IconWidget(
                  onTap: ()=>_key.currentState!.openDrawer(),
                  height: 40.h,
                  width: 40.w,
                  widget: Padding(
                    padding: 8.paddingAll,
                    child: SvgPicture.asset(AppImages.menu),
                  ),),
              ),
              Positioned(
                top: 40.h,
                right: 20.w,
                child:
                IconWidget(
                  height: 40.h,
                  width: 40.w,
                  onTap: (){
                    NavigationService.push(Routes.notificationsScreen);
                  },
                  widget: Padding(
                    padding: 8.paddingAll,
                    child: SvgPicture.asset(AppImages.notification),
                  ),),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(kFormPaddingAllLarge.r),
                    child: FloatingActionButton(
                      backgroundColor: Theme.of(context).cardColor,
                      child:  Icon(Icons.my_location,color: Theme.of(context).primaryColor),
                      onPressed: ()=> BlocProvider.of<HomeCubit>(context, listen: false).getCurrentUserLocation(),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      AddressBody? userLocationModel= BlocProvider.of<HomeCubit>(context, listen: false).userLocationModel;
                      if(userLocationModel==null)return;
                      NavigationService.push(Routes.driverSearchScreen,arguments: {'addressBody':userLocationModel});
                    },
                    child: Container(
                        decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: const BorderRadius.vertical(top: Radius.circular(30))).shadow(),
                        padding: 16.paddingHorizontal+20.paddingTop,
                        child:
                        Column(
                          children: [
                            HeaderSheetWidget(),
                            12.height,
                            BlocConsumer<HomeCubit, HomeState>(builder: (context, state) {
                              HomeCubit cubit = BlocProvider.of<HomeCubit>(context);
                              return  Row(
                                children: [
                                  IconWidget(
                                    height: 40.h,
                                    width: 40.w,
                                    widget: Padding(
                                      padding: 8.paddingAll,
                                      child: Icon(Icons.circle,color: primaryColor,),
                                    ),),
                                  8.width,
                                  Expanded(child: BlackRegularText(label:cubit.userLocationModel?.address??'',fontSize: 13,fontWeight: FontWeight.w300,),
                                  ),
                                ],
                              );
                            }, listener: (context, state) {}),
                            12.height,
                            Container(
                                padding: 16.paddingHorizontal+10.paddingVert,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 10.0,
                                      spreadRadius: 2.0,
                                      offset: Offset(4, 8),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppImages.send),
                                    8.width,
                                    HintRegularText(label: tr(LocaleKeys.whereTo),fontSize: 16,),
                                    Spacer(),
                                    SvgPicture.asset(AppImages.search2),
                                  ],
                                )
                            ),
                            12.height,
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child:  Image.asset(AppImages.home5),
                            ),
                            20.height,
                          ],
                        )
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );


  }
}

