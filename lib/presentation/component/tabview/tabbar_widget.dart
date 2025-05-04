
import 'package:flutter/material.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';

import '../../../core/resources/color.dart';
import '../../../core/resources/styles.dart';

class TabItemModel{
  final String label ;
  final String? image ;
  final Widget page ;
  TabItemModel({required this.label ,required this.page, this.image});
  Tab builder(){
    return TabWidgetItemBuilder(this);
  }
}

class TabWidgetItemBuilder extends Tab{
  TabWidgetItemBuilder(TabItemModel model, {Key? key}):super(key: key, text: model.label);
}

class TabBarWidget  extends StatelessWidget{
  final Function(int)? onTap;
  final List<TabItemModel> tabs ;
  const TabBarWidget({super.key ,required this.tabs, this.onTap});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        appBar: AppBar(
          toolbarHeight: 15,
          backgroundColor: Colors.white,
          bottom:
          TabBar(
            // isScrollable: true,
            indicatorColor: primaryColor,
            // dividerColor: dividerColor,
            unselectedLabelStyle:TextStyles.font16Mid.copyWith(
              fontWeight: FontWeight.bold,
              // fontFamily: AppFonts.lateefFont,
              fontSize: 12,
              color:grayColor
            ),
            labelStyle: TextStyles.font16Regular.copyWith(
              fontWeight: FontWeight.bold,

                fontSize: 16,
              color: Colors.white,
            ),
            padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 5.h),
            indicatorPadding: EdgeInsets.zero,
            labelPadding:  EdgeInsets.zero ,
            indicator:  BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black.withOpacity(0.2),
              //     spreadRadius: 1,
              //     blurRadius: 1,
              //     offset: const Offset(0, 1), // changes position of shadow
              //   ),
              // ],

            ),
            indicatorSize: TabBarIndicatorSize.tab,
            onTap: onTap,
            tabs: tabs.map((e) => e.builder()
            ).toList(),
          ),
        ),
        body: TabBarView(
          // physics: const NeverScrollableScrollPhysics(),
          children: tabs.map((e) => e.page).toList(),
        ),
      ),
    );
  }

}
