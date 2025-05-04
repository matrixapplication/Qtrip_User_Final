import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/color.dart';
import 'package:q_trip_user/core/resources/decoration.dart';
import 'package:q_trip_user/core/resources/resources.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';
import 'package:q_trip_user/data/model/base/response_model.dart';
import 'package:q_trip_user/generated/locale_keys.g.dart';

import 'package:q_trip_user/core/resources/values_manager.dart';

import '../../../../domain/entities/wallet_list_entity.dart';
import '../../../../generated/assets.dart';
import '../../../component/component.dart';
import '../../../component/pagination_list.dart';
import '../../../component/texts/black_texts.dart';
import '../../../dialog/show_recharge_wallet_dialog.dart';
import 'wallet_cubit.dart';
import 'widget/wallet_item.dart';



_getData(BuildContext context, bool reload, {bool isLoadMore = false})=>
    BlocProvider.of<WalletCubit>(context, listen: false).getWallet( reload: reload,isLoadMore :isLoadMore);

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();
    // BlocProvider.of<WalletCubit>(context, listen: false).init(context);
    _getData(context, true);
  }

  @override
  Widget build(BuildContext context) {
    ResponseModel<WalletListEntity?>? responseModel = context.watch<WalletCubit>().responseModel;
    bool isLoading = context.watch<WalletCubit>().isLoadRequestList;

    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title:tr(LocaleKeys.paymentsActivity)),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(kScreenPaddingNormal.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Container(
                padding: 24.paddingAll,
                decoration: BoxDecoration(
                  color: backGroundWhite,
                  borderRadius: BorderRadius.circular(36.r),
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(Assets.svgWallet2,width: 35.w,height: 35.h,color: primaryColor,),
                    8.height,
                    BlackBoldText(label:'${responseModel?.data?.amount??0} ${LocaleKeys.currency.tr()}',fontSize: 23.sp,labelColor: blue4Color,),
                    8.height,
                    BlackRegularText(label:tr(LocaleKeys.yourBalance),fontSize: 16.sp,fontWeight: FontWeight.w300,textAlign: TextAlign.center,),
                    8.height,
                     BlocBuilder<WalletCubit, WalletState>(builder: (context,state){
                       return CustomButton(
                         loading: state is RechargeWalletLoading,
                         raduis: 12,
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Icon(Icons.add,color: Colors.white,),
                             8.width,
                             BlackRegularText(label: tr(LocaleKeys.addMoney),fontSize: 16.sp,fontWeight: FontWeight.w500,labelColor: Colors.white,),
                           ],
                         ),
                         onTap: (){
                           showRechargeWalletDialog(context);
                         },);

                     })

                  ],
                ),
              ),
              VerticalSpace(kScreenPaddingNormal.h),
              Text(tr(LocaleKeys.transactions),style: const TextStyle().regularStyle(),),
              VerticalSpace(kFormPaddingAllLarge.h),
              Expanded(
                child: BlocConsumer<WalletCubit, WalletState>(
                  listener: (context,state){},
                  buildWhen:(cubit, current) => (current is  WalletHistoryGotSuccessfully ||current is WalletLoading),
                  builder: (context, state) =>
                      ScreenStateLayout(
                    error:  responseModel?.error ,
                    isEmpty: (responseModel?.data?.list ?? []).isEmpty ,
                    isLoading: (state is WalletLoading),
                    onRetry: () => _getData(context, true),
                    builder: (context) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: PaginationListView(
                            onLoadMore: () => _getData(context, false,isLoadMore: true),
                            isLoading:  (state is WalletLoading),
                            list: responseModel?.data?.list ??[],
                            currentPage: responseModel?.data?.currentPage??1,
                            totalPages:responseModel?.data?.lastPage??1  ,
                            builder: (BuildContext context, int index) {
                              if (responseModel?.data?.list[index] != null) {
                                return  Padding(
                                  padding: EdgeInsets.symmetric(vertical: kFormPaddingAllSmall.h),
                                  child: WalletItem(entity: responseModel!.data!.list[index]),
                                );
                              } else {return const SizedBox();}
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
