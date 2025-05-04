import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../domain/entities/message_entity.dart';
import '../../../component/spaces.dart';
import '../chat_cubit.dart';
import 'chat_message_location.dart';

class ChatMassageItem extends StatelessWidget {
  final MessageEntity _entity;

  const ChatMassageItem({
    super.key,
    required MessageEntity entity,
  }) : _entity = entity;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChatCubit>(context,listen: false).updateIsRead(_entity);
    return Container(
      child: _entity.isMe
          ? _buildMyMassage(context)
          : _buildOtherUsersMassage(context),
    );
  }

  _buildMyMassage(BuildContext context) {
    return  Row(
      children: [
        HorizontalSpace(32.w),

        // CustomPersonImage(imageUrl: _entity.photo, size: 28.r),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(kFormRadius),
                        topRight: Radius.circular(kFormRadius),
                        bottomLeft: Radius.circular(kFormRadius)),
                  ),
                  padding: EdgeInsets.all(12.r),
                  child:

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(_entity.message!=null && _entity.message!.isNotEmpty)
                        ...[Text(_entity.message??'', style: const TextStyle().descriptionStyle().boldBlackStyle().copyWith(),),
                          VerticalSpace(kFormPaddingAllSmall.h),],
                      if(_entity.lng!=null && _entity.lng!=0&& _entity.lng!=null && _entity.lng!=0)
                        ...[
                          ChatMessageLocation(latLng: LatLng(_entity.lat??0,_entity.lng??0),),
                          VerticalSpace(kFormPaddingAllSmall.h),],
                      Text(_entity.time , style: const TextStyle().descriptionStyle(fontSize: 10).blackStyle().copyWith()),
                    ],
                  )
              ),
              VerticalSpace(kFormPaddingAllSmall.h),
              // Text(DateConverter.isoStringToLocalDate(_entity.time).toTimeIfToday(), style: const TextStyle().descriptionStyle(fontSize: 10).hintStyle()),
            ],
          ),
        ),
      ],
    );
  }

  _buildOtherUsersMassage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).hoverColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(kFormRadius),
                      topRight: Radius.circular(kFormRadius),
                      bottomRight: Radius.circular(kFormRadius)),
                ),
                padding: EdgeInsets.all(12.r),
                child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(_entity.message!=null && _entity.message!.isNotEmpty)
                    ...[Text(_entity.message??'', style: const TextStyle().descriptionStyle().boldBlackStyle(),),
                      VerticalSpace(kFormPaddingAllSmall.h),],
                  if(_entity.lng!=null && _entity.lng!=0&& _entity.lng!=null && _entity.lng!=0)
                    ...[
                      ChatMessageLocation(latLng: LatLng(_entity.lat??0,_entity.lng??0),),
                      VerticalSpace(kFormPaddingAllSmall.h),],
                  Text(_entity.time , style: const TextStyle().descriptionStyle(fontSize: 10).blackStyle()),
                ],
              )
              ),
              VerticalSpace(kFormPaddingAllSmall.h),
              //
              // Text(DateConverter.convertDateDomainData(_entity.time), style: const TextStyle().descriptionStyle().hintStyle()),
            ],
          ),
        ),
        HorizontalSpace(32.w),

        // CustomPersonImage(imageUrl: _entity.photo, size: 28.r),
      ],
    );
  }
}
