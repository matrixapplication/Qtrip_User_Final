import 'dart:async';
import 'package:flutter/material.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/presentation/component/texts/black_texts.dart';

import '../../core/resources/color.dart';

class ChooseFromListItemWidget extends StatefulWidget {
  final List<ChooseItemListModel> items;
  final double? radius;
  final double? width;
  final double? height;
  final Function(ChooseItemListModel item)? onChoose;

  ChooseFromListItemWidget({
    super.key,
    this.width,
    this.onChoose,
    this.height,
    this.radius,
    required this.items,
  });

  @override
  _ChooseFromListItemWidgetState createState() => _ChooseFromListItemWidgetState();
}

class _ChooseFromListItemWidgetState extends State<ChooseFromListItemWidget> {
  final StreamController<ChooseItemListModel> _controller = StreamController<ChooseItemListModel>();
  late ChooseItemListModel selectedItem;

  @override
  void initState() {
    super.initState();
    // Initially emit the first item if items list is not empty
    selectedItem = widget.items.isNotEmpty ? widget.items[0] : ChooseItemListModel(id: 0, title: '', value: '', value2: '');
    _controller.add(selectedItem);
  }

  // @override
  // void didUpdateWidget(covariant ChooseFromListItemWidget oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   // If items list has been updated with new items, select the first item
  //   if (oldWidget.items != widget.items && widget.items.isNotEmpty) {
  //     selectedItem = widget.items[0];
  //     _controller.add(selectedItem);
  //   }
  // }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  void _chooseItem(ChooseItemListModel item) {
    // Emit the newly chosen item to the stream
    selectedItem = item;
    _controller.add(item);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChooseItemListModel>(
      stream: _controller.stream,
      builder: (context, snapshot) {
        final selectedItem = snapshot.data ?? this.selectedItem;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...widget.items.map((e) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: InkWell(
                  onTap: () {
                    widget.onChoose?.call(e);
                    _chooseItem(e); // Only using the stream
                  },
                  child: Center(
                    child: Container(
                      width: 100,
                      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                      decoration: BoxDecoration(
                        color: selectedItem?.title == e.title ? primaryColor : null,
                        border: Border.all(
                          color: selectedItem?.title == e.title ? primaryColor : Colors.grey.shade300,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(widget.radius ?? 12),
                      ),
                      child: Center(
                        child: BlackBoldText(
                          labelColor: selectedItem?.title == e.title ? Colors.grey.shade300 : Colors.grey.shade700,
                          label: e.title ?? '',
                          fontSize: 11.sp,
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

class ChooseItemListModel {
  final int id;
  final String title;
  final String value;
  final String value2;

  ChooseItemListModel({required this.id, required this.title, required this.value, required this.value2});
}
