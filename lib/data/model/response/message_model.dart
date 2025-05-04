
import 'package:firebase_database/firebase_database.dart';

import '../../../core/utils/globals.dart';
import '../../../domain/entities/message_entity.dart';


class MessageModel extends MessageEntity {
  const MessageModel({

    required super.lat,
    required super.lng,
    required super.message,
    required super.messageId,
    required super.time,
    required super.isMe, required super.isRead, required super.senderId,
  });

  factory MessageModel.fromSnapshot(DataSnapshot snapshot) => MessageModel(
    message: (snapshot.child("message").value ?? '').toString(),
    messageId: (snapshot.child("messageId").value ?? '').toString(),
    time: (snapshot.child("time").value ?? '').toString(),
    senderId: (snapshot.child("sender_id").value ?? '').toString(),
    lng : snapshot.child("lng").value!=null?double.tryParse((snapshot.child("lng").value ?? '0').toString()):null,
    lat :snapshot.child("lat").value!=null?double.tryParse( (snapshot.child("lat").value ?? '0').toString()):null,
    isMe: ((snapshot.child("sender_id").value ?? 0).toString() =='user-${kUser?.id}'),
    isRead: (snapshot.child("isRead").value?.toString()=='true'),
  );
}
