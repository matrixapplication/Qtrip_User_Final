import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:q_trip_user/domain/logger.dart';

import '../../../core/routing/navigation_services.dart';
import '../../../core/routing/routes.dart';
import '../../../core/utils/globals.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/message_model.dart';
import '../../../domain/entities/message_entity.dart';
import '../../../domain/request_body/massage_body.dart';
import '../../../domain/usecase/chat/get_message_list_usecase.dart';
import '../../../domain/usecase/chat/send_message_usecase.dart';
import '../../../domain/usecase/trip/get_my_live_trip_usecase.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {

  final GetMessagesUseCase _getMessagesUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  final GetMyLiveTripUseCase _getMyLiveTripUseCase;

  ChatCubit({
    required GetMessagesUseCase getMessagesUseCase,
    required SendMessageUseCase sendMessageUseCase,
    required GetMyLiveTripUseCase getMyLiveTripUseCase,
  })  : _getMessagesUseCase = getMessagesUseCase,
        _getMyLiveTripUseCase = getMyLiveTripUseCase,
        _sendMessageUseCase = sendMessageUseCase,
        super(ChatInitial());

  ///variables
  StreamSubscription? _streamTripSubscription;
  StreamSubscription? _streamChatSubscription;

  late String _tripId  ;
  ///getters


  //set trip id
  init(String tripId) {_tripId=tripId;_getMessages(tripId: tripId);_getTrip(tripId: tripId);}

  ///colling api functions

  _getMessages({required String tripId}) async {
     emit(ChatLoading());

    _streamChatSubscription = _getMessagesUseCase.call(tripId: tripId).listen((event) {
      if(event.snapshot.exists){
        List<MessageEntity> massages=[];
        for(var snapshot in event.snapshot.children){massages.add(MessageModel.fromSnapshot(snapshot));}
        emit(MassagesGotSuccessfully(massages: massages));
      } else {
        emit(MassagesGotSuccessfully(massages: []));
      }
    });
  }

  final  DatabaseReference _reference = FirebaseDatabase.instance.ref().child('trips');
  updateIsRead(MessageEntity document) {

    final ref =_reference.child(_tripId).child('chat');

    if(document.senderId.toString()!= 'user-${kUser!.id.toString()}' && document.isRead == false ){
      log('_updateIsRead', '${document.senderId} -- ${ kUser!.id.toString()}');
      ref.child(document.messageId).update({'isRead': true});    }
  }
  int _getUnReadMessageCount(QuerySnapshot chat) {
    int count = 0 ;
    for(var element in chat.docs){
      if(element['sender_id'].toString() != kUser!.id.toString()){
        if(!element['isRead']){
          count++;
        }else{
          return count;

        }
      }
    }
    return count;
  }
  //sore chat massages
  Future<ResponseModel> storeMassage({required String massage}) async {
    emit(ChatSendLoading());
    ResponseModel responseModel =await _sendMessageUseCase.call(massageBody: MassageBody(massage:massage,tripId: _tripId ));
    emit(ChatInitial());
    return responseModel;
  }
  Future<ResponseModel> storeLocation({required LatLng latLng}) async {
    emit(ChatSendLoading());
    ResponseModel responseModel =await _sendMessageUseCase.call(massageBody: MassageBody(latLng:latLng,tripId: _tripId ));
    emit(ChatInitial());
    return responseModel;
  }

  _getTrip({required String tripId}) {
    _streamTripSubscription = _getMyLiveTripUseCase.call(tripId).listen((event) {
      if (!event.snapshot.exists) {
        NavigationService.pushNamedAndRemoveUntil(Routes.driverHomeScreen);
      }
    });
  }

  @override
  Future<void> close() {_streamChatSubscription?.cancel();_streamTripSubscription?.cancel();return super.close();}
  void dispose() {_streamChatSubscription?.cancel();_streamTripSubscription?.cancel();}
}
