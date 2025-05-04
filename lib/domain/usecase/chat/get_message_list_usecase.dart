import 'package:firebase_database/firebase_database.dart';

import '../../repository/chat_repo.dart';

class GetMessagesUseCase {
  final ChatRepository _repository;

  const GetMessagesUseCase({
    required ChatRepository repository,
  }) : _repository = repository;

  Stream<DatabaseEvent> call({required String tripId}) => _repository.getMessageList(tripId: tripId);
}
