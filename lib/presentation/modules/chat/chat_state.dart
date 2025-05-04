part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}


class ChatInitial extends ChatState {}
class ChatLoading extends ChatState {}
class ChatSendLoading extends ChatState {}
class ChatVehicleLoading extends ChatState {}

class MassagesGotSuccessfully extends ChatState {
  final List<MessageEntity> _massages ;



  List<MessageEntity> get massages => _massages;

  MassagesGotSuccessfully({
    required List<MessageEntity> massages,
  }) : _massages = massages;
}
