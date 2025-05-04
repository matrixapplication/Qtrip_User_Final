

import '../../../domain/entities/addresses_entity.dart';
import 'address_model.dart';
class AddressesModel extends AddressesEntity {
  AddressesModel({
    required super.home,
    required super.work,
    required super.favorites,
  });


  factory AddressesModel.fromJson(Map<String, dynamic> json) => AddressesModel(

    home:(json["home"]??{}).toString()=='{}' ? null:  AddressModel.fromJson(json["home"]),
    work:(json["work"]??{}).toString()=='{}' ? null:  AddressModel.fromJson(json["work"]),
    favorites: List<AddressModel>.from(json["favorites"].map((x) => AddressModel.fromJson(x))),
  );

/*  Map<String, dynamic> toJson() => {
    "home": home.toJson(),
    "work": work.toJson(),
    "favorites": List<dynamic>.from(favorites.map((x) => x.toJson())),
  };*/
}
