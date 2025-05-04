import  'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/routing/navigation_services.dart';
import 'package:q_trip_user/presentation/component/texts/black_texts.dart';
import '../../../core/resources/values_manager.dart';
import '../../../domain/entities/trip_history_entity.dart';
import '../../../generated/locale_keys.g.dart';
import '../../component/component.dart';
import '../widgets/sheet_header.dart';
import 'report_cubit.dart';

class  ReportSheet extends StatefulWidget {

  final TripHistoryEntity _entity;

  const  ReportSheet({super.key,
    required TripHistoryEntity entity,
  }) : _entity = entity;

  @override
  State< ReportSheet> createState() => _ReportSheetState();


}
class _ReportSheetState extends State< ReportSheet> {
  final tag = 'Report';
  late  ReportSheetCubit _cubit;
  late TextEditingController _noteController ;


  @override
  void initState() {
    _noteController = TextEditingController();
    _cubit = BlocProvider.of< ReportSheetCubit>(context, listen: false);
    _cubit.init(widget._entity.id.toString());
    super.initState();


  }
  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    _cubit.init(widget._entity.id.toString()??'');
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: EdgeInsets.only(bottom: 32+ MediaQuery.of(context).viewInsets.bottom, top: 4),
      decoration: BoxDecoration(borderRadius:const BorderRadius.vertical(top: Radius.circular(20)), color: Theme.of(context).scaffoldBackgroundColor),
      child:
       SingleChildScrollView(
         padding: 20.paddingHorizontal,
         child:  Column(
           crossAxisAlignment: CrossAxisAlignment.start,

           mainAxisSize: MainAxisSize.min,
           children: <Widget>[
             SheetHeader(
               title: tr(LocaleKeys.report),
               onCancelPress: () => Navigator.pop(context),
             ),
             const Divider(height: 8),
             16.height,
              Center(
               child:   BlackRegularText(label: tr(LocaleKeys.theTripTrouble),fontSize: 16, textAlign: TextAlign.center,),
             ),
             16.height,
              BlackRegularText(label: tr(LocaleKeys.complaintDescription),fontSize: 16, textAlign: TextAlign.start,fontWeight: FontWeight.w300,),
             8.height,
             CustomTextFieldArea(hint: tr(LocaleKeys.complaintDescriptionWrite),controller: _noteController),
             VerticalSpace(kScreenPaddingNormal.h),
             BlocBuilder< ReportSheetCubit,  ReportState>(
               builder: (context, state) {
                 return CustomButton(loading: state is  ReportLoading,title: tr(LocaleKeys.submit),onTap: ()async{
                   await _cubit.rateTrip( report: _noteController.text);
                   NavigationService.goBack();
                 });
               },
             ),
           ],
         ),
       )
    );
  }
}

Future<dynamic> showReport(
    BuildContext context, {
      required TripHistoryEntity entity,
    }) async {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => FractionallySizedBox(
      heightFactor: 0.6,
      child: SafeArea(
        child:  ReportSheet(
          entity: entity,
        ),
      ),
    ),
  );
}
