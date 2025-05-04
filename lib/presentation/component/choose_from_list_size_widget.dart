import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/presentation/component/texts/black_texts.dart';
import 'package:q_trip_user/presentation/component/texts/hint_texts.dart';

import '../../core/resources/color.dart';
import '../../generated/locale_keys.g.dart';

class ChooseFromListSizesWidget extends StatefulWidget {
  final List<ChooseItemListSizeModel> items;
  final double? radius;
  final double? width;
  final ChooseItemListSizeModel? initialSelection;
  final double? height;
  final Function(ChooseItemListSizeModel item)? onChoose;
  ChooseFromListSizesWidget({
    super.key,
    this.width,
    this.onChoose,
    this.height,
    this.radius,
    required this.items, this.initialSelection,
  });

  @override
  _ChooseFromListItemWidgetState createState() => _ChooseFromListItemWidgetState();
}

class _ChooseFromListItemWidgetState extends State<ChooseFromListSizesWidget> {
  final StreamController<ChooseItemListSizeModel> _controller = StreamController<ChooseItemListSizeModel>();
  late ChooseItemListSizeModel selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem =widget.initialSelection?? widget.items.first;
    _controller.add(selectedItem); // إضافة العنصر المحدد إلى الـ Stream
  }

  @override
  void dispose() {
    _controller.close(); // إغلاق الـ Stream عند الانتهاء
    super.dispose();
  }

  void _chooseItem(ChooseItemListSizeModel item) {
    setState(() {
      selectedItem = item;
    });
    _controller.add(item); // إرسال العنصر المختار إلى الـ Stream
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChooseItemListSizeModel>(
      stream: _controller.stream,
      builder: (context, snapshot) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ...widget.items.map((e) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: InkWell(
                  onTap: () {
                    widget.onChoose?.call(e);
                    _chooseItem(e);

                  },
                  child: Center(
                    child: Container(
                      height: widget.height,
                      width: widget.width,
                      decoration: BoxDecoration(
                        color: selectedItem.title == e.title ? primaryColor : null,
                        border: Border.all(
                          color: selectedItem.title == e.title ? primaryColor : Colors.grey.shade300,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(widget.radius ?? 12),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w) + EdgeInsets.only(top: 4.h),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    BlackBoldText(
                                      labelColor: selectedItem.title == e.title ? Colors.grey.shade300 : Colors.grey.shade700,
                                      label: '${LocaleKeys.size.tr()} :',
                                      fontSize: 11.sp,
                                    ),
                                    5.height,
                                    HintSemiBoldText(
                                      labelColor: selectedItem.title == e.title ? Colors.white : Colors.grey.shade500,
                                      label: '${e.title}',
                                      fontSize: 13.sp,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    BlackBoldText(
                                      labelColor: selectedItem.title == e.title ? Colors.grey.shade300 : Colors.grey.shade700,
                                      label: '${LocaleKeys.price.tr()} :',
                                      fontSize: 11.sp,
                                    ),
                                    5.height,
                                    HintSemiBoldText(
                                      labelColor: selectedItem.title == e.title ? Colors.white : Colors.grey.shade500,
                                      label: '${e.value}',
                                      fontSize: 13.sp,
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.circle,
                                color: selectedItem.title == e.title ? Colors.white : Colors.transparent,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )),
            ],
          ),
        );
      },
    );
  }
}

class ChooseItemListSizeModel {
  final int id;
  final String title;
  final String value;
  final String value2;

  ChooseItemListSizeModel({required this.id, required this.title, required this.value, required this.value2});
}
