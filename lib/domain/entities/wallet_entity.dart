
import 'package:equatable/equatable.dart';

class WalletEntity extends Equatable {
  final int _id;
  final num _amount;
  final String _message;
  final String _data;



  @override
  List<Object> get props => [_id, _message, _amount, _data];

  const WalletEntity({
    required int id,
    required String message,
    required String data,
    required num amount,
  })  : _id = id,_amount = amount,_data = data,
        _message = message;

  String get message => _message ;
  String get data => _data ;
  int get id => _id;
  num get amount => _amount;
}

