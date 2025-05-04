import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:q_trip_user/core/assets_constant/images.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';
import '../../../core/resources/values_manager.dart';
import '../../../core/utils/contact_helper.dart';
import '../../../core/utils/language_helper.dart';
import '../../../data/injection.dart';
import '../../../domain/entities/trip_entity.dart';
import '../../../generated/locale_keys.g.dart';
import '../../component/icon_widget.dart';
import '../../component/images/custom_person_image.dart';
import '../../component/inputs/custom_text_field_normal.dart';
import '../../component/screen_state_layout.dart';
import '../../component/texts/black_texts.dart';
import 'chat_cubit.dart';
import 'widget/chat_massage_item.dart';
import 'dart:math' as math;

_getData(BuildContext context, { required String tripId}) =>
    BlocProvider.of<ChatCubit>(context, listen: false).init(tripId);



class ChatScreen extends StatefulWidget {
  final TripEntity _entity;

  @override
  State<ChatScreen> createState() => _ChatScreenState();

  const ChatScreen({super.key,
    required TripEntity entity,
  }) : _entity = entity;
}

class _ChatScreenState extends State<ChatScreen> {


  final TextEditingController _messageController = TextEditingController();
  late ChatCubit _viewModel;

  void _onSubmit() async {
    if (_messageController.text.isEmpty) return;
    _viewModel.storeMassage(massage: _messageController.text);
    _messageController.clear();
  }
  void _onSubmitLocation() async {
    final Position res = await  Geolocator.getCurrentPosition();
    _viewModel.storeLocation(latLng: LatLng(res.latitude, res.longitude));

  }
  @override
  void initState() {
    super.initState();
    _viewModel = BlocProvider.of<ChatCubit>(context, listen: false);
    _getData(context, tripId: widget._entity.tripId);
  }

  @override
  Widget build(BuildContext context) {

    return
      WillPopScope(
          onWillPop: ( )async{
            // cubit.setChatValue(false);
            Navigator.pop(context);
            return Future.value(true);
          },
          child: Scaffold(
              // backgroundColor: Colors.white,
              // appBar:  CustomAppBar(title: widget._entity.userName),
              body:
              SafeArea(
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    10.height,
                    Row(
                      children: [
                        10.width,
                        IconWidget(
                          onTap: (){
                            // cubit.setChatValue(false);
                            Navigator.pop(context);
                          },
                          widget: const Icon(Icons.arrow_back),
                        ),
                        Expanded(child:
                        Row(
                          children: [
                            8.width,
                            CustomPersonImage(imageUrl:widget._entity.userImage,size: 50.r),
                            8.width,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BlackMediumText(label: widget._entity.driverName??'',fontSize: 13,),
                                BlackRegularText(label: '${widget._entity.vehicle?.vehicleType??''} ,${widget._entity.vehicle?.brand??''} ,${widget._entity.vehicle?.model??''}',fontSize: 10,),
                                BlackRegularText(label: '${widget._entity.vehicle?.colorName??''} ,${widget._entity.vehicle?.vehicleTypeCategory??''}',fontSize: 10,)
                              ],
                            )
                          ],
                        )
                        ),
                        IconWidget(
                          onTap: (){
                            if ((widget._entity.driverMobile ?? '').isNotEmpty) {
                              ContactHelper.launchCall(widget._entity.driverMobile);
                            }
                          },
                          // height: 50.h,
                          // width: 50.w,
                          icon: Icons.call,
                        ),
                        10.width,

                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(kScreenPaddingNormal.r),
                        child: BlocBuilder<ChatCubit, ChatState>(
                          buildWhen:(previous, current)=> (current is  MassagesGotSuccessfully ||current is ChatLoading),
                          builder: (context, state) {
                            return ScreenStateLayout(
                              emptyBuilder: (context){
                                return Center(child:Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(AppImages.see),
                                    12.height,
                                    Text(
                                      tr( LocaleKeys.noResultFound),
                                      style: const TextStyle().titleStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ));
                              },
                              isEmpty: (state is MassagesGotSuccessfully) ? (state.massages).isEmpty : false,
                              isLoading: (state is ChatLoading),
                              builder: (context) =>
                                  Scrollbar(
                                    child: SingleChildScrollView(
                                      reverse: true,
                                      physics: const BouncingScrollPhysics(),
                                      child: ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        itemCount: (state as MassagesGotSuccessfully).massages.length,
                                        itemBuilder: (context, index) => ChatMassageItem(entity: (state).massages[index]),
                                      ),
                                    ),
                                  ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: 10.paddingStart+10.paddingEnd+8.paddingBottom,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          BlocBuilder<ChatCubit, ChatState>(
                            builder: (context, state) {
                              return
                                IconWidget(
                                  height: 44.w,
                                  width: 44.w,
                                  onTap: (){
                                    _onSubmitLocation();
                                  },
                                  widget: Padding(
                                    padding: 5.paddingAll,
                                    child: const Icon(Icons.location_history,size: 30,),
                                  ),
                                );
                            },
                          ),
                          Expanded(
                            child: CustomTextFieldNormal(
                              controller: _messageController,
                              hint: tr(LocaleKeys.massage),
                            ),
                          ),

                          // HorizontalSpace(kFormPaddingAllLarge.w),
                          BlocBuilder<ChatCubit, ChatState>(
                            builder: (context, state) {
                              return
                                IconWidget(
                                  height: 44.w,
                                  width: 44.w,
                                  onTap: () => _onSubmit(),
                                  widget: Padding(
                                      padding: 10.paddingAll,
                                      child:
                                      kIsArabic==true?
                                      Transform(
                                        alignment: Alignment.center,
                                        transform: Matrix4.rotationY(math.pi),
                                        child:  Opacity(
                                          opacity: 1,
                                          child:  SvgPicture.asset(AppImages.send2),
                                        ),
                                      ):SvgPicture.asset(AppImages.send2)

                                  ),
                                );
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
          ));

  }
}
