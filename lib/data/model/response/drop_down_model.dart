

import '../../../domain/entities/drop_down_entity.dart';

class DropDownModel extends DropDownEntity {
  const DropDownModel({
    required int id,
    required String title,
     String? category,
  }) : super(id: id, title: title,category: category);

  factory DropDownModel.fromJson(Map<String, dynamic>? json) =>
      DropDownModel(id: json?['id'] ?? -1, title: json?['name'] ?? '',category:json?['category'] ?? '' );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = title;
    return data;
  }
}
