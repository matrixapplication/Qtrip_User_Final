import  'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/color.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';


import '../../../core/resources/values_manager.dart';
import '../../../core/routing/navigation_services.dart';
import '../../../domain/entities/trip_entity.dart';
import '../../../generated/locale_keys.g.dart';
import '../../component/custom_button.dart';
import '../../component/images/custom_person_image.dart';
import '../../component/inputs/custom_text_field_area.dart';
import '../../component/spaces.dart';
import '../../component/texts/black_texts.dart';
import '../widgets/sheet_header.dart';
import 'rate_cubit.dart';

class RateSheet extends StatefulWidget {

  final TripEntity _entity;

  const RateSheet({super.key,
    required TripEntity entity,
  }) : _entity = entity;

  @override
  State<RateSheet> createState() => _RateSheetState();


}

class _RateSheetState extends State<RateSheet> {
  final tag = 'RateSheet';
  late RateSheetCubit _cubit;
  late TextEditingController _noteController ;


  @override
  void initState() {
    _noteController = TextEditingController();
    _cubit = BlocProvider.of<RateSheetCubit>(context, listen: false);
    _cubit.init(widget._entity.tripId);
    super.initState();
  }
  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding:  EdgeInsets.only(bottom: 32+ MediaQuery.of(context).viewInsets.bottom, top: 4),
      decoration: BoxDecoration(borderRadius:const BorderRadius.vertical(top: Radius.circular(20)), color: Colors.white),
      child:
      SingleChildScrollView(
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // SheetHeader(
            //   title: tr(LocaleKeys.rate),
            //   onCancelPress: () => Navigator.pop(context),
            // ),
            // const Divider(height: 8),
            20.height,
             BlackRegularText(label: tr(LocaleKeys.destination),fontSize: 20,
              textAlign: TextAlign.center,),
            5.height,
            Divider(color: Colors.grey.shade300,endIndent: 75.w,indent: 75.w,),

            5.height,
            CustomPersonImage(imageUrl: widget._entity.userImage??'',size: 75.r),
            12.height,

            Text(widget._entity.driverName??"",style:const TextStyle().regularStyle()),
            Container(
              margin: 20.paddingHorizontal,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 7,
                    offset: Offset(3,8)
                  )
                ]
              ),
              padding: 16.paddingHorizontal+10.paddingVert+10.paddingBottom,
              child: Column(
                children: [
                  Text(tr(LocaleKeys.rateYourTrip),style:const TextStyle().regularStyle()),
                  VerticalSpace(kScreenPaddingNormal.h-10),
                  RatingBar(
                    initialRating: 1,
                    itemSize: 32,
                    minRating: 1,
                    ignoreGestures: false,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 8),
                    onRatingUpdate:_cubit.onRateChange,
                    ratingWidget: RatingWidget(
                      full: Icon(CupertinoIcons.star_fill, size: 32, color:Colors.orange.shade300),
                      half: Icon(CupertinoIcons.star_lefthalf_fill, size: 32, color:Colors.orange.shade300),
                      empty: const Icon(CupertinoIcons.star, size: 32, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            5.height,
            Divider(color: Colors.grey.shade300,endIndent: 40,indent: 40,),
            5.height,
            Container(
              margin: 20.paddingHorizontal,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 7,
                        offset: Offset(3,8)
                    )
                  ]
              ),
              padding: 8.paddingHorizontal+5.paddingVert,
              child: CustomTextFieldArea(
                  lines: 5,
                  hint: tr(LocaleKeys.addYourComment),controller: _noteController),
            ),
            VerticalSpace(kScreenPaddingNormal.h-5),
            Row(
              children: [
                16.width,
               Expanded(
                 flex: 2,
                 child:  BlocBuilder<RateSheetCubit, RateState>(
                 builder: (context, state) {
                   return CustomButton(
                       raduis: 16,
                       loading: state is RateLoading,title: tr(LocaleKeys.submit),onTap: ()async{
                     await _cubit.rateTrip( notes: _noteController.text);
                     NavigationService.goBack();
                   });
                 },
               ),),
                8.width,
                Expanded(
                    flex: 1,
                    child: CustomButton(
                       textColor: primaryColor,

                        color: Colors.white,
                        title: tr(LocaleKeys.cancel),onTap: ()async{

                  NavigationService.goBack();
                })),
                16.width,
              ],
            )
          ],
        ),
      )
    );
  }
}

Future<dynamic> showRate(
    BuildContext context, {
      required TripEntity entity,
    }) async {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => FractionallySizedBox(
      heightFactor: 0.8,
      child: SafeArea(
        child: RateSheet(
          entity: entity,
        ),
      ),
    ),
  );
}
