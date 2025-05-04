
import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/notification_model.dart';
import '../../entities/notification_entity.dart';
import '../../repository/notification_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';




class GetNotificationsUseCase  implements BaseUseCase<NotificationListModel>{

  final NotificationRepository repository;

  GetNotificationsUseCase({required this.repository});

  Future<ResponseModel<NotificationListModel>> call({int currentPage = 1}) async {
    return BaseUseCaseCall.onGetData<NotificationListModel>( await repository.getNotifications(currentPage: currentPage), onConvert,tag: 'GetNotificationsUseCase');
  }


  @override
  ResponseModel<NotificationListModel> onConvert(BaseModel baseModel) {

    NotificationListModel data = NotificationListModel.fromMap(baseModel.response);

    return ResponseModel(true, baseModel.message, data: data);
  }
  Future<ResponseModel<List<NotificationEntity>>> callTest() async {
    List<NotificationEntity> list = [
      NotificationEntity(
          id: 1,
          title: 'حدث فيفا قد اقترب',
          text: 'حدث جديد اثناء موسم الرياض حدث جديد اثناء موسم الرياض حدث جديد اثناء موسم الرياض حدث جديد اثناء موسم الرياض ',
          createdAt: DateTime.now(),
          image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQsW9fC5XtPt51m_9r8E8Q1UvDh4IPao_ymAfwuIaO&s',),
      NotificationEntity(
          id: 1,
          title: 'حدث جديد',
          text: 'حدث جديد اثناء موسم الرياض حدث جديد اثناء موسم الرياض حدث جديد اثناء موسم الرياض حدث جديد اثناء موسم الرياض  ',
          createdAt: DateTime.now(),
          image:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQsW9fC5XtPt51m_9r8E8Q1UvDh4IPao_ymAfwuIaO&s',),    ];
    return ResponseModel(true, '', data: list);
  }
}



