import  'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/resources/values_manager.dart';
import '../../../data/model/base/response_model.dart';
import '../../../domain/entities/drop_down_entity.dart';
import '../../../generated/locale_keys.g.dart';
import '../../component/custom_button.dart';
import '../../component/screen_state_layout.dart';
import '../../component/spaces.dart';
import '../widgets/sheet_header.dart';
import 'cancel_response_picker_cubit.dart';

class CancelResponsePickerSheet extends StatefulWidget {
  final String _tripId;

  const CancelResponsePickerSheet({
    super.key,
    required String tripId,
  }) : _tripId = tripId;

  @override
  State<CancelResponsePickerSheet> createState() => _CancelResponsePickerSheetState();

}

class _CancelResponsePickerSheetState extends State<CancelResponsePickerSheet> {
  final tag = 'CancelResponsePickerCubit';
  late CancelResponsePickerCubit pickerViewModelProvider;

  @override
  void initState() {
    super.initState();

    pickerViewModelProvider = BlocProvider.of<CancelResponsePickerCubit>(context, listen: false);
    pickerViewModelProvider.initVieModel(widget._tripId) ;
    pickerViewModelProvider.getList(context,false);

  }

  @override
  Widget build(BuildContext context) {
    ResponseModel<List<DropDownEntity>>?  responseModel=   context.watch<CancelResponsePickerCubit>().responseModel;
    List<DropDownEntity>?  selectedList=   context.watch<CancelResponsePickerCubit>().selectedList;
    DropDownEntity?  selected=   context.watch<CancelResponsePickerCubit>().selected;
    CancelResponsePickerState state = context.watch<CancelResponsePickerCubit>().state;

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.only(bottom: 32, top: 4),
      decoration:  BoxDecoration(borderRadius:const BorderRadius.vertical(top: Radius.circular(20)), color: Theme.of(context).scaffoldBackgroundColor),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SheetHeader(
              title: tr(LocaleKeys.cancel),
              onCancelPress: () => Navigator.pop(context),
            ),
            const Divider(height: 8),
           Expanded(
             child:  ScreenStateLayout(
               isLoading:responseModel == null,
               error: responseModel?.error,
               isEmpty: (responseModel?.data?.length??0)==0,
               onRetry: () => pickerViewModelProvider.getList(context,true),
               builder: (context) =>
                   buildBody(
                       context,
                       selectedItemIds:selectedList!.map((e) => e.id).toList(),
                       model:responseModel?.data??[],
                       selectedItem:selected
                   ),
             ),
           ),
            const VerticalSpace(kScreenPaddingNormal),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kScreenPaddingNormal),
              child: CustomButton(title: tr(LocaleKeys.cancel),loading: state is CancelResponsePickerLoading,onTap: () =>pickerViewModelProvider.cancelTrip()
              ),
            )
          ]),
    );
  }

  Widget buildBody(BuildContext context,
      {List<int?>? selectedItemIds,
      required List<DropDownEntity> model,
      DropDownEntity? selectedItem}) {
    return model.isEmpty
        ? const SizedBox.shrink()
        : Container(
            constraints: BoxConstraints(
              maxHeight: deviceHeight / 2,
            ),
            child: ListView(
                shrinkWrap: true,
                children: model.map((e) =>  buildSingleChoiceItem(context, selectedItem, e)).toList()),
          );
  }



  Widget buildSingleChoiceItem(BuildContext context, DropDownEntity? selectedItem, DropDownEntity model) {
    return RadioListTile<int>(

      groupValue: selectedItem?.id,
      title: Text(model.title),
      value: model.id,
      onChanged: (value) {
        pickerViewModelProvider.onSelected(model);
      },
    );
  }
}

Future<dynamic> showCancelResponsePicker(BuildContext context,
    {required String tripId}) async {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => SafeArea(
        child: CancelResponsePickerSheet(
          tripId: tripId,

    )),
  );
}
