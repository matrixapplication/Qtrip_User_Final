
import 'package:equatable/equatable.dart';

import '../../core/utils/language_helper.dart';

class DropDownEntity extends Equatable {
  final int _id;
  final String _title;
  final String? _category;




  @override
  List<Object> get props => [_id, _title,_category??''];

  const DropDownEntity({
    required int id,
    required String title,
     String? category,
  })  :
        _id = id,
        _category = category,
        _title = title;

  String get title => _title ;
  int get id => _id;
  String? get category => _category;
}

