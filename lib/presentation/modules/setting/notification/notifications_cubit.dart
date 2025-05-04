import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/model/base/response_model.dart';
import '../../../../data/model/response/notification_model.dart';
import '../../../../domain/logger.dart';
import '../../../../domain/usecase/notification/get_notifications_usecase.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {

  final GetNotificationsUseCase _getNotificationsUseCase;

  NotificationsCubit({
    required GetNotificationsUseCase getNotificationsUseCase,
  }) : _getNotificationsUseCase = getNotificationsUseCase , super(NotificationsInitial());


  ///variables
  bool _isLoadRequestList = true;
  NotificationListModel? _responseModel;
  int _currentPage=1;

  ///getters
  bool get isLoadRequestList => _isLoadRequestList;
  NotificationListModel? get responseModel => _responseModel;




  ///colling api functions
  //get notifications


  getNotifications({bool reload = false, bool isLoadMore = false,int? page }) async {
    _isLoadRequestList = true;
    if (reload) {_responseModel = null;_currentPage = 1; emit(NotificationsLoading());}
    else if (!isLoadMore) {_responseModel = null;}
    else {_currentPage = (_currentPage + 1);}
    _currentPage = page??_currentPage;
    final res = await _getNotificationsUseCase.call(currentPage: _currentPage);
    if (isLoadMore && res.data != null) {
      _responseModel?.list.addAll(res.data?.list ?? []);
    } else {
      _responseModel = res.data;
    }
    _isLoadRequestList = false;
     emit(NotificationsLoading());
  }



}
