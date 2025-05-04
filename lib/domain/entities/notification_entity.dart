import 'package:equatable/equatable.dart';


class NotificationEntity extends Equatable {
  final int _id;
  final String _text;
  final DateTime _createdAt;
  final String _title;
  final String? _image;

  const NotificationEntity({
    required int id,
    required String title,
    required String text,
    required DateTime createdAt,
    required  String? image,
  })  : _id = id,
        _text = text,
        _createdAt = createdAt,
        _image = image,
        _title = title;
  @override
  List<Object> get props => [_id, _text, _createdAt, _title];

  String get title => _title;


  DateTime get createdAt => _createdAt;

  String? get image => _image;


  String get text => _text;


  int get id => _id;
}
