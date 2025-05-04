import 'package:equatable/equatable.dart';
class VehicleEntity extends Equatable{

  final int _id;
  final String _name;
  final String _description;
  final dynamic _price;
  final dynamic _priceAfterDiscount;
  final String _image;

  const VehicleEntity({
    required int id,
    required String name,
    required String description,
    required dynamic priceAfterDiscount,
    required dynamic price,
    required String image,
  })  : _id = id,
        _name = name,
        _description = description,
        _priceAfterDiscount = priceAfterDiscount,
        _price = price,
        _image = image;


  @override
  List<Object?> get props => [_id, _name, _description, _price, _image, _priceAfterDiscount];

  String get image => _image;

  dynamic get price => _price;

  String get description => _description;

  String get name => _name;

  int get id => _id;

  dynamic get priceAfterDiscount => _priceAfterDiscount;
}
class ImageEntity extends Equatable{



  final String _image;
  final int _id;


  @override
  List<Object?> get props => [_image,_id];

  int get id => _id;
  String get image => _image;

  const ImageEntity({
    required String image,
    required int id,
  })
      : _image = image,
        _id = id;
}

