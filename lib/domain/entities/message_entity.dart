
import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String? _message;
  final String _time;
  final String _senderId;
  final String _messageId;

  final double? _lat;
  final double? _lng;
  final bool _isMe;
  final bool _isRead;



  @override
  List<Object?> get props => [_senderId,_messageId,_isRead,_message,_time,_isMe,_lat,_lng];

  const MessageEntity({
    String? message,
    required String time,
    required String senderId,
    required String messageId,
    required bool isMe,
    required bool isRead,
    double? lat,
    double? lng,
  })  :
        _message = message,
        _lat = lat,
        _lng = lng,
        _time= time,
        _messageId= messageId,
        _senderId= senderId,
        _isRead= isRead,
        _isMe= isMe;

  String? get message => _message;
  String get messageId => _messageId;
  String get time => _time;
  String get senderId => _senderId;
  bool get isMe => _isMe;
  bool get isRead => _isRead;
  double? get lng => _lng;
  double? get lat => _lat;
}

