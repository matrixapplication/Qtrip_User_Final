
import 'package:equatable/equatable.dart';
import 'wallet_entity.dart';

class WalletListEntity extends Equatable {
  final int _currentPage;
  final int _lastPage;
  final num _amount;
  final List<WalletEntity> _list;



  @override
  List<Object> get props => [ _currentPage, _lastPage, _list, _amount];


  const WalletListEntity({
    required int currentPage,
    required int lastPage,
    required num amount,
    required List<WalletEntity> list,
  })
      :
        _currentPage = currentPage,
        _amount = amount,
        _lastPage = lastPage,
        _list = list;

  List<WalletEntity> get list => _list;

  int get lastPage => _lastPage;
  num get amount => _amount;

  int get currentPage => _currentPage;



}

