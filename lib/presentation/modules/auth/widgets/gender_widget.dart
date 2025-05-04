import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/generated/locale_keys.g.dart';
import 'package:q_trip_user/presentation/component/texts/black_texts.dart';

import '../../../component/custom_radio.dart';

class GenderWidget extends StatefulWidget {
  final String? title;
  final Function(String value)? onChanged;
  const GenderWidget({Key? key, this.title, this.onChanged}) : super(key: key);

  @override
  _GenderWidgetState createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderWidget> {
  bool isMale = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title!=null?
        Padding(padding: 8.paddingBottom+5.paddingStart,
          child:  BlackRegularText(label:  widget.title??'',fontSize: 16.sp,fontWeight: FontWeight.w300,),
        ):const SizedBox.shrink(),
        Row(
          children: [
            Expanded(
              child:
             InkWell(
                onTap: (){
                  setState(() {
                    isMale = true;
                  });
                  widget.onChanged?.call('male');
                },
               child:  CustomRadio(
                 title: tr(LocaleKeys.male),
                 widget:
                 Container(
                     width:110.w,
                     height: 44.h,
                     decoration: BoxDecoration(
                       color: Colors.white,
                       border: Border.all(color: Colors.black38.withOpacity(0.3)),
                       boxShadow: const [
                         // BoxShadow(
                         //   color: Colors.black12,
                         //   blurRadius: 10,
                         //   spreadRadius: 5,
                         //   offset: Offset(0, 3), // changes position of shadow
                         // ),
                       ],
                       borderRadius: BorderRadius.circular(14),
                     ),
                     child:  Center(
                       child: BlackRegularText(
                         label:  tr(LocaleKeys.male),
                         fontSize: 14,
                       ),
                     )
                 ),
                 value: true,
                 groupValue: isMale,
                 onChanged: (bool value) {
                   setState(() {
                     isMale = value;
                   });
                   widget.onChanged?.call('male');

                 },
               ),
             )
            ),
            Expanded(
                child:
                InkWell(
                  onTap: (){
                    setState(() {
                      isMale = false;
                    });
                    widget.onChanged?.call('female');

                  },
                  child: CustomRadio(
                    title: tr(LocaleKeys.female),
                    widget:
                    Container(
                        width:110.w,
                        height: 44.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.black38.withOpacity(0.3)),
                          boxShadow: const [
                            // BoxShadow(
                            //   color: Colors.black12,
                            //   blurRadius: 10,
                            //   spreadRadius: 5,
                            //   offset: Offset(0, 3), // changes position of shadow
                            // ),
                          ],
                        ),
                        child:  Center(
                          child: BlackRegularText(
                            label:  tr(LocaleKeys.female),
                            fontSize: 14,
                          ),
                        )
                    ),

                    value: false,
                    groupValue: isMale,
                    onChanged: (bool value) {
                      setState(() {
                        isMale = value;
                      });
                      widget.onChanged?.call('female');

                    },
                  ),
                ))
          ],
        )
      ],
    );
  }
}
