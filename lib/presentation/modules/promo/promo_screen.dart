
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';
import 'package:q_trip_user/presentation/modules/promo/promo_cubit.dart';
import 'package:q_trip_user/presentation/modules/promo/widgets/promo_item.dart';

import '../../../core/resources/values_manager.dart';
import '../../../core/routing/navigation_services.dart';
import '../../../domain/entities/promo_code_entity.dart';
import '../../../generated/locale_keys.g.dart';
import '../../component/animation/list_animator_data.dart';
import '../../component/custom_app_bar.dart';
import '../../component/custom_loading_spinner.dart';
import '../../component/inputs/custom_text_field_normal.dart';
import '../../component/screen_state_layout.dart';
import '../../component/spaces.dart';

_getData(BuildContext context, { required PromoCodeEntity? entity}) =>
    BlocProvider.of<PromoCubit>(context, listen: false).init(entity);

class PromoScreen extends StatefulWidget {
  final PromoCodeEntity? _promoCodeEntity;

  const PromoScreen({
    required PromoCodeEntity? promoCodeEntity,
  }) : _promoCodeEntity = promoCodeEntity;

  @override
  State<PromoScreen> createState() => _PromoScreenState();



}

class _PromoScreenState extends State<PromoScreen> {
  late PromoCubit _viewModel;
  @override
  void initState() {
    super.initState();
    _viewModel = BlocProvider.of<PromoCubit>(context, listen: false);
    _getData(context, entity: widget._promoCodeEntity);
  }

  @override
  Widget build(BuildContext context) {
      var status =  context.watch<PromoCubit>().state;

      return WillPopScope(
        onWillPop: ()async{
          NavigationService.goBack( _viewModel.selectedPromoCode);
/*        NavigationService.goBack({
          'from': widget._fromLocationModel,
          'to': widget._toLocationModel,
          'promo': _viewModel.selectedPromoCode
        });*/
        return true;
      },
        child: Scaffold(
          backgroundColor: Colors.white,
        appBar: CustomAppBar(title: tr(LocaleKeys.promoCode)),
        body: Padding(
          padding: EdgeInsets.all(kScreenPaddingNormal.r),
          child: Column(
            children: [
              CustomTextFieldNormal(
                controller: _viewModel.promoController,
                hint: tr(LocaleKeys.enterPromoCode),
                suffixData: GestureDetector(
                  onTap: () {
                    BlocProvider.of<PromoCubit>(context,listen: false).checkPromoCode(promoCode: _viewModel.promoController.text).then((response) {
                      if(response.isSuccess && response.data!=null){
                        NavigationService.goBack( _viewModel.selectedPromoCode);

                      }
                    });
                  },
                  child:status is PromoAppleLoading?CustomLoadingSpinner(size: 20.r,): FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      tr(LocaleKeys.apply),style: TextStyle().regularStyle().activeColor(),
                  ),)
                ),
              ),
              VerticalSpace(kScreenPaddingNormal.h),
              Expanded(
                child: BlocBuilder<PromoCubit, PromoState>(
                  buildWhen:(previous, current)=> (current is  PromosGotSuccessfully ||current is PromoLoading),

                  builder: (context, state) {
                    return ScreenStateLayout(
                      isEmpty: (state is PromosGotSuccessfully) ? (state.responseModel.data??[]).isEmpty : false,
                      isLoading: (state is PromoLoading),
                      builder: (context) =>  ListAnimatorData(
                          itemCount: (state is PromosGotSuccessfully)?state.responseModel.data!.length:0,
                          scrollDirection:Axis.vertical ,
                          itemBuilder: (context, index)=> PromoItem( entity: (state as PromosGotSuccessfully).responseModel.data![index])),
                    );
                  },
                ),
              ),
              VerticalSpace(kScreenPaddingNormal.h),
              // CustomButton(onTap: (){},)
            ],
          ),
        ),
    ),
      );
  }
}
