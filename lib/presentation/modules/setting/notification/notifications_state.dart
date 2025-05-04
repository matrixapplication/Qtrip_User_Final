part of 'notifications_cubit.dart';

@immutable
abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}
class NotificationsLoading extends NotificationsState {}
class NotificationsMoreLoading extends NotificationsState {}

class NotificationsGotSuccessfully extends NotificationsState {
  NotificationListModel  data ;

  NotificationsGotSuccessfully({
    required this.data,
  }) ;
}
