
import '../../../data/model/base/response_model.dart';
import '../../repository/chat_repo.dart';
import '../../request_body/massage_body.dart';

class SendMessageUseCase {
  final ChatRepository _repository;

  const SendMessageUseCase({
    required ChatRepository repository,
  }) : _repository = repository;

  Future<ResponseModel> call({required MassageBody massageBody}) async {
    bool isSend = await _repository.sendMessage(massageBody: massageBody);
    if (isSend) {
      return ResponseModel(true, 'successful');
    } else {
      return ResponseModel(false, 'error');
    }
  }
}
