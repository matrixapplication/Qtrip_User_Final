import 'package:equatable/equatable.dart';

import 'drop_down_entity.dart';

class DriverStateEntity extends Equatable {
  final num _distance;
  final num _trips;
  final num _duration;

  const DriverStateEntity({
    required num distance,
    required num trips,
    required num duration,
  })  : _distance = distance,
        _trips = trips,
        _duration = duration;

  @override
  List<Object> get props => [
    _distance,
    _trips,
    _duration,
  ];

  num get distance => _distance;
  num get trips => _trips;
  num get duration => _duration;



}
