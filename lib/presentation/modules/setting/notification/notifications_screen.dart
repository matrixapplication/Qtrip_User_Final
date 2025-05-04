import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/presentation/modules/setting/notification/widget/notification_item.dart';
import '../../../../core/resources/resources.dart';
import '../../../../data/model/base/response_model.dart';
import '../../../../data/model/response/notification_model.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../component/component.dart';
import '../../../component/pagination_list.dart';
import 'notifications_cubit.dart';




_getData(BuildContext context, bool reload, {bool isLoadMore = false})=>
  BlocProvider.of<NotificationsCubit>(context, listen: false).getNotifications( reload: reload,isLoadMore :isLoadMore,page: 1);


class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    _getData(context, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: tr(LocaleKeys.notifications)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VerticalSpace(kScreenPaddingNormal.h),
          Expanded(child: _buildList(context)),
        ],
      ),
    );
  }

  _buildList(BuildContext context){

    NotificationListModel?  responseModel = context.watch<NotificationsCubit>().responseModel;
    bool isLoading = context.watch<NotificationsCubit>().isLoadRequestList;

    return
      RefreshIndicator(
      onRefresh: () async => _getData(context, false,isLoadMore: true),
      child:
     BlocConsumer<NotificationsCubit,NotificationsState>(builder: (context,state){
       return  Padding(
         padding: EdgeInsets.symmetric(horizontal: 16.w),
         child: CustomScreenStateLayout(
           isLoading: responseModel?.list == null,
           isEmpty: (responseModel?.list??[]).isEmpty,
           builder: (context) =>
               CustomPaginationListView(
                 onLoadMore: () => _getData(context, false,isLoadMore: true),
                 isMoreLoading: isLoading,
                 isLoading: responseModel==null,
                 itemCount: (responseModel?.list??[]).length,
                 currentPage: responseModel?.pagination.currentPage??1,
                 hasMorePages: responseModel?.pagination.hasMorePages??false,
                 builder: (context, index) => NotificationItem(entity: responseModel!.list[index]),

               ),
         ),
       );
     },
     listener: (context,state){},)
    );
  }
}
