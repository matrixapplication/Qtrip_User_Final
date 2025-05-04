
import '../../../domain/entities/country_entity.dart';

class CountryModel extends CountryEntity {
  const CountryModel(
      {required super.id,
      required super.title,
      required super.code,
      required super.image,
      required super.facebook,
      required super.twitter,
      required super.whatsapp,
      required super.terms});

  factory CountryModel.fromJson(Map<String, dynamic>? json) => CountryModel(
        id: json?['id'] ?? 0,
        title: json?['title'] ?? '',
        code: json?['code'] ?? '',
        image: json?['image'] ?? '',
        facebook: json?['facebook'] ?? '',
        terms: json?['taam'] ?? '',
        twitter: json?['twitter'] ?? '',
        whatsapp: json?['whatsapp'] ?? '',
      );
}
