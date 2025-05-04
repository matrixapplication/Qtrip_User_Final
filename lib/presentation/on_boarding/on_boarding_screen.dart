import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/styles.dart';
import 'package:q_trip_user/core/routing/routes.dart';
import 'package:q_trip_user/generated/assets.dart';
import 'package:q_trip_user/presentation/component/component.dart';
import 'package:q_trip_user/presentation/component/texts/black_texts.dart';
import 'package:q_trip_user/presentation/component/texts/primary_texts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/resources/color.dart';
import '../../../core/resources/values_manager.dart';
import '../../../core/routing/navigation_services.dart';
import '../../../generated/locale_keys.g.dart';
import '../../core/utils/language_helper.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController pageController = PageController(initialPage: 0);
  int currentPageIndex = 0;
  Timer? autoPageTimer;

  final List<Map<String, String>> pageViewData = [
    {
      'title': tr(LocaleKeys.onTitle1),
      'description':  tr(LocaleKeys.onDescription1),
      'image': 'assets/images/svg/intro1.svg',
    },
    {
      'title': tr(LocaleKeys.onTitle2),
      'description':  tr(LocaleKeys.onDescription2),
      'image': 'assets/images/svg/intro2.svg',
    },
    {
      'title': tr(LocaleKeys.onTitle3),
      'description':  tr(LocaleKeys.onDescription3),
      'image': 'assets/images/svg/intro3.svg',
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoPageTimer();
  }

  @override
  void dispose() {
    autoPageTimer?.cancel();
    pageController.dispose();
    super.dispose();
  }

  void _startAutoPageTimer() {
    autoPageTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (currentPageIndex < pageViewData.length - 1) {
        pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _goToNextPage() {
    if (currentPageIndex < pageViewData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }else{
      NavigationService.push(Routes.logAsScreen);
    }
  }

  void _goToPreviousPage() {
    if (currentPageIndex > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skipToLastPage() {
    NavigationService.push(Routes.logAsScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            itemCount: pageViewData.length,
            itemBuilder: (context, index) {
              final data = pageViewData[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: kScreenPaddingNormal.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      data['image']!,
                      height: 300.h,
                      fit: BoxFit.contain,
                    ),
                    const VerticalSpace(20),
                    const SizedBox(height: 20),
                    PrimarySemiBoldText(
                      label: data['title']!,
                      fontSize: 26.sp,),
                    const VerticalSpace(10),
                    Padding(
                      padding: 32.paddingHorizontal,
                      child:
                      Text(
                        data['description']!,
                        textAlign: TextAlign.center,
                        style: TextStyles.font16Regular.copyWith(fontSize: 18.sp,fontWeight: FontWeight.w300,color: blackColor,height: 1.2),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // زر التخطي
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 10,
            child: TextButton(
              onPressed: _skipToLastPage,
              child:  BlackRegularText(
                label: LocaleKeys.skip.tr(),
              )
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top-5,
            left: 10,
            child: Image.asset(
              Assets.imagesLogo2,
              width: 100,
              height: 80,
            ),
          ),
          // SmoothPageIndicator
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: pageViewData.length,
                effect: WormEffect(
                  activeDotColor:blue3Color,
                  dotColor: Colors.grey.shade400,
                  dotHeight: 10,
                  dotWidth: 10,
                ),
              ),
            ),
          ),
          // أزرار التنقل
          if (currentPageIndex < pageViewData.length )
            Positioned(
              bottom: 20,
              right:kIsArabic==true?null: 16,
              left:kIsArabic==true?16: null,
              child: FloatingActionButton(
                onPressed: _goToNextPage,
                backgroundColor: primaryColor,
                child: const Icon(Icons.arrow_forward,color: Colors.white,),
              ),
            ),
          if (currentPageIndex > 0)
            Positioned(
              bottom: 20,
              right:kIsArabic==true?16: null,
              left:kIsArabic==true?null: 16,
              child: FloatingActionButton(
                onPressed: _goToPreviousPage,
                backgroundColor: Colors.grey.shade200,
                child:  Icon(Icons.arrow_back,color: Colors.grey.shade400,),
              ),
            ),
        ],
      ),
    );
  }
}
