
import 'package:equatable/equatable.dart';

class CountryEntity extends Equatable {
  final int _id;
  final String _title;
  final String _code;
  final String _image;


 final String _facebook;
 final String _twitter;
 final String _whatsapp;
 final String _terms;

  @override
  List<Object> get props => [_id, _title,_code,_image];


  const CountryEntity({
    required int id,
    required String title,
    required String code,
    required String image,
    required String facebook,
    required String twitter,
    required String whatsapp,
    required String terms,
  })  : _id = id,
        _title = title,
        _code = code,
        _image = image,
        _facebook = facebook,
        _twitter = twitter,
        _whatsapp = whatsapp,
        _terms = terms;



  String get image => _image ;
  int get id => _id;

  String get terms => _terms;

  String get whatsapp => _whatsapp;

  String get twitter => _twitter;

  String get facebook => _facebook;

  String get code => _code;

  String get title => _title;
}

