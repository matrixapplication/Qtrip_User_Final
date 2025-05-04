
import '../../../domain/entities/pagination_entity.dart';

//"pagination": {
//         "current_page": 2,
//         "total_pages": 1,
//         "per_page": 10,
//         "total_items": 3,
//     }

class PaginationModel extends PaginationEntity {
  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      PaginationModel(
          currentPage: json["current_page"] ?? 1,
          lastPage: json["total_pages"] ?? 1,
          perPage: json["per_page"] ?? 1,
          total: json["total_items"] ?? 1,
          hasMorePages: ((json["total_pages"] ?? 1) > (json["current_page"] ?? 1)));

  const PaginationModel({
    required super.currentPage,
    required super.lastPage,
    required super.perPage,
    required super.total,
    required super.hasMorePages,
  });
}
