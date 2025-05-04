import 'package:equatable/equatable.dart';

import 'address_entity.dart';

class AddressesEntity extends Equatable{

  final AddressEntity? _home;
  final AddressEntity? _work;
  final List<AddressEntity> _favorites;

  @override
  List<Object> get props => [ _favorites];

  const AddressesEntity({
    required AddressEntity? home,
    required AddressEntity? work,
    required List<AddressEntity> favorites,
  })  : _home = home,
        _work = work,
        _favorites = favorites;

  List<AddressEntity> get favorites => _favorites;

  AddressEntity? get work => _work;
  AddressEntity? get home => _home;
}
