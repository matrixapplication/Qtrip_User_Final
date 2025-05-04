

import 'package:firebase_database/firebase_database.dart';

import '../request_body/massage_body.dart';

abstract class ChatRepository {
  Stream<DatabaseEvent> getMessageList({required String tripId});


  Future<bool> sendMessage({required MassageBody massageBody});
}
