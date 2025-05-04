

import 'package:firebase_database/firebase_database.dart';

import '../../../domain/repository/chat_repo.dart';
import '../../../domain/request_body/massage_body.dart';

class ChatRepositoryImp implements ChatRepository{


  late DatabaseReference _reference;

  ChatRepositoryImp(){
    _reference =  FirebaseDatabase.instance.ref().child('trips');
  }


  @override
  Future<bool> sendMessage({required MassageBody massageBody}) async {
    final newKey = _reference.child(massageBody.tripId).child('chat').push().key;
    massageBody.pushMessageId(newKey??'');

    if (newKey == null) return false;
    await _reference.child(massageBody.tripId).child('chat').child(newKey).set(massageBody.toJson());
    return true;
  }

  @override
  Stream<DatabaseEvent> getMessageList({required String tripId}) =>_reference.child(tripId).child('chat').onValue;


}
