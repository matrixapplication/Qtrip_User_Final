
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/resources/styles.dart';

import '../../../core/resources/color.dart';

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
  const TabBarWidget({super.key, required this.tabs, this.onTap});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: 
        Column(
          children: [
            TabBar(

              // isScrollable: true,
              indicatorColor:  primaryColor,
              dividerColor: Colors.transparent,
              unselectedLabelStyle:TextStyles.font21SimBold.copyWith(color: blackColor.withOpacity(0.7),fontSize: 14,fontWeight: FontWeight.w300),
              labelStyle: TextStyles.font21SimBold.copyWith(color: primaryColor,fontSize: 16,fontWeight: FontWeight.w600),
              padding: 5.paddingAll,
              indicatorPadding: 0.paddingAll,
              labelPadding:  0.paddingAll ,

              // indicator:  BoxDecoration(
              //   color: context.primaryColor,
              //   // borderRadius: const BorderRadius.all(Radius.circular(8)),
              //   // boxShadow: [
              //   //   BoxShadow(
              //   //     color: Colors.black.withOpacity(0.2),
              //   //     spreadRadius: 1,
              //   //     blurRadius: 1,
              //   //     offset: const Offset(0, 1), // changes position of shadow
              //   //   ),
              //   // ],
              //
              // ),
              indicatorSize: TabBarIndicatorSize.tab,
              onTap: onTap,
              tabs: tabs.map((e) => e.builder()
              ).toList(),
            ),
            Expanded(child: TabBarView(
              // physics: const NeverScrollableScrollPhysics(),
              children: tabs.map((e) => e.page).toList(),
            ),),
          ],
        )
        
      ),
    );
  }

}
