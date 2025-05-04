import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/generated/locale_keys.g.dart';
import 'package:q_trip_user/presentation/component/component.dart';
import 'package:q_trip_user/presentation/modules/my_trips/widgets/my_trips_item.dart';

import '../../../core/resources/values_manager.dart';
import '../../component/animation/list_animator_data.dart';
import '../../component/screen_state_layout.dart';
import 'my_trips_cubit.dart';

class MyTripsScreen extends StatelessWidget {
  const MyTripsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _getData(context, reload: true);

    return
     Scaffold(
       appBar: CustomAppBar(
         title: tr(LocaleKeys.myTrip),
       ),
       backgroundColor: Colors.white,
       body:
       BlocBuilder<MyTripsCubit, MyTripsState>(
         buildWhen:(cubit, current) => (current is  GetMyTripsSuccess ||current is GetMyTripsLoading),
         builder: (context, state) => ScreenStateLayout(
           error: (state is GetMyTripsSuccess) ? state.responseModel.error : null,
           isEmpty: (state is GetMyTripsSuccess) ? (state.responseModel.data ?? []).isEmpty : false,
           isLoading: (state is GetMyTripsLoading),
           onRetry: () => _getData(context, reload: true),
           builder: (context) => ListAnimatorData(
             itemCount: (state as GetMyTripsSuccess).responseModel.data?.length,
             scrollDirection: Axis.vertical,
             padding:  EdgeInsets.all(kScreenPaddingNormal.r),
             loadingWidget: const SizedBox(),
             itemBuilder: (context, index) => MyTripsItemWidget(entity: (state).responseModel.data![index],),
           ),
         ),
       ),
     );
  }
  _getData(BuildContext context, {required bool reload,DateTime? date}) =>
      BlocProvider.of<MyTripsCubit>(context, listen: false).getTrips(reload: reload,date: date);


}
