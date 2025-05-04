import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:q_trip_user/core/extensions/num_extensions.dart';

import '../../../core/resources/values_manager.dart';
import '../../../data/model/base/response_model.dart';
import '../../../domain/entities/country_entity.dart';
import '../../../domain/logger.dart';
import '../../../generated/locale_keys.g.dart';
import '../../component/component.dart';
import '../../component/images/custom_image.dart';
import '../widgets/sheet_header.dart';
import 'country_picker_cubit.dart';

class CountryPickerSheet extends StatefulWidget {
  final List<CountryEntity> defaultList;
  final CountryEntity? defaultValue;
  final bool isMultiChoice;

  const CountryPickerSheet({Key? key,
    required this.defaultList,
    required this.defaultValue,
    required this.isMultiChoice,
  }) : super(key: key);

  @override
  State<CountryPickerSheet> createState() => _CountryPickerSheetState();
}


class _CountryPickerSheetState extends State<CountryPickerSheet> {
  final tag = 'CountryPickerCubit';
  late CountryPickerCubit _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = BlocProvider.of<CountryPickerCubit>(context, listen: false);
    _viewModel.getList(context,false);

  }

  @override
  Widget build(BuildContext context) {
    ResponseModel<List<CountryEntity>>?  responseModel=   context.watch<CountryPickerCubit>().responseModel;
    List<CountryEntity>?  selectedList =   context.watch<CountryPickerCubit>().selectedList;
    CountryEntity?  selected=   context.watch<CountryPickerCubit>().selected;

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.only(bottom: 32, top: 4),
      decoration:  BoxDecoration(borderRadius:const BorderRadius.vertical(top: Radius.circular(20)), color: Theme.of(context).scaffoldBackgroundColor),
      child:
      Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SheetHeader(
              title: tr(LocaleKeys.countries),
              onCancelPress: () => Navigator.pop(context),
            ),
            const Divider(height: 8),
            Expanded(child: ScreenStateLayout(
              isLoading:responseModel == null,
              error: responseModel?.error,
              isEmpty: (responseModel?.data?.length??0)==0,
              onRetry: () => _viewModel.getList(context,true),
              builder: (context) =>
                  buildBody(
                      context,
                      selectedItemIds:selectedList!.map((e) => e.id).toList(),
                      model:responseModel?.data??[],
                      selectedItem:selected
                  ),
            ),),
            const VerticalSpace(kScreenPaddingNormal),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kScreenPaddingNormal),
              child: CustomButton(title: tr(LocaleKeys.submit),onTap: () =>Navigator.pop(context, widget.isMultiChoice ? selectedList : selected)),

            )
          ]),
    );
  }

  Widget buildBody(BuildContext context,
      {List<int?>? selectedItemIds,
        required List<CountryEntity> model,
        CountryEntity? selectedItem}) {
    return model.isEmpty
        ? const SizedBox.shrink()
        : Container(
      constraints: BoxConstraints(
        maxHeight: deviceHeight / 2,
      ),
      child: ListView(
          shrinkWrap: true,
          children: model.map((e) =>  _buildSingleChoiceItem(context, selectedItem, e)).toList()),
    );
  }

  Widget _buildSingleChoiceItem(BuildContext context, CountryEntity? selectedItem, CountryEntity model) {
    log(tag, 'selectedModel = ${selectedItem?.title}');
    return RadioListTile<int>(
      groupValue: selectedItem?.id,
      title: Row(
        children: [
          Text(model.title),
          HorizontalSpace(kFormPaddingAllSmall.w),
          const Spacer(),
          CustomImage(imageUrl: model.image,width: 38.w,height: 28.h,radius: 4),
        ],
      ),
      value: model.id,
      onChanged: (value) {
        log(tag, 'on dashboard_item selected');
        _viewModel.onSelected(model);
      },
    );
  }
}

Future<dynamic> showCountryPicker(BuildContext context,
    {required List<CountryEntity> defaultList,
    required CountryEntity? defaultValue,
    required bool isMultiChoice}) async {
  return showModalBottomSheet(
  // return showMaterialModalBottomSheet(
  //   expand: false,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => CountryPickerSheet(
      defaultList: defaultList,
      defaultValue: defaultValue,
      isMultiChoice: isMultiChoice,
    ),
  );
}
