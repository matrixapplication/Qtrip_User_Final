import 'package:equatable/equatable.dart';
import 'package:q_trip_user/data/model/response/pagination_model.dart';

import '../../../domain/entities/notification_entity.dart';


class NotificationListModel extends Equatable {
  final PaginationModel _pagination;
  final List<NotificationModel> _list;

  @override
  List<Object> get props => [
    _pagination,
    _list,
  ];

  const NotificationListModel({
    required PaginationModel pagination,
    required List<NotificationModel> list,
  })  : _pagination = pagination,
        _list = list;

  List<NotificationModel> get list => _list;

  PaginationModel get pagination => _pagination;

  Map<String, dynamic> toMap() {
    return {
      'pagination': _pagination,
      'data': _list,
    };
  }

  factory NotificationListModel.fromMap(Map<String, dynamic> map) {
    return NotificationListModel(
      pagination:   PaginationModel.fromJson(map['pagination']),
      list: List<NotificationModel>.from((map["data"]??[]).map((x) => NotificationModel.fromJson(x))),

    );
  }
}

class NotificationModel extends NotificationEntity{
  const NotificationModel({
    required int id,
    required String text,
    required String? image,
    required DateTime createdAt,
    required String title,
  }) : super(
            id: id,
            text: text,
            createdAt: createdAt,
            image : image,
            title: title);

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    id: json["id"] ?? -1,
    image: json["image"],
    text: json["message"] ?? '',
    title: json["title"] ?? '',
    createdAt: json["created_at"] == null ? DateTime.now() : DateTime.parse(json["created_at"]),

  );

}