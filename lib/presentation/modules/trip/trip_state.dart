part of 'trip_cubit.dart';

@immutable
class TripState {
  bool _isLoading = false;
  bool refish = false;
  TripEntity? _tripEntity;
  DriverEntity? _driver;
  Set<Polyline> _tripPolyLines={};
  Set<Polyline> _usedTripPolyLines={};
  DirectionDetailsEntity? _directionDetailsEntity;
  DirectionDetailsEntity? _driverDirectionEntity;
  int? _driverArriveDuration;
  int? _arriveDuration;
  double? _driverArriveDistance;
  double? _arriveDistance;


      TripEntity? get tripEntity => _tripEntity;
  DriverEntity? get driver => _driver;

  Set<Polyline> get tripPolyLines => _tripPolyLines;
  Set<Polyline> get usedTripPolyLines => _usedTripPolyLines;
  bool get isLoading => _isLoading;
  DirectionDetailsEntity? get directionDetailsEntity => _directionDetailsEntity;
  DirectionDetailsEntity? get driverDirectionEntity => _driverDirectionEntity;
  int? get driverArriveDuration => _driverArriveDuration;
  int? get arriveDuration => _arriveDuration;
  double? get driverArriveDistance => _driverArriveDistance;
  double? get arriveDistance => _arriveDistance;

  TripState copyWith(
      {
        TripEntity? tripEntity,
      bool? isLoading,
      bool? refish,
      DriverEntity? driver,
      Set<Polyline>? tripPolyLines,
      Set<Polyline>? usedTripPolyLines,
      DirectionDetailsEntity? directionDetailsEntity,
      DirectionDetailsEntity? driverDirectionEntity,
      int? driverArriveDuration,
      int? arriveDuration,
        double? driverArriveDistance,
        double? arriveDistance,
      }) {
    return TripState()
      .._isLoading = isLoading ?? this._isLoading
      ..refish = refish ?? this.refish
      .._tripEntity = tripEntity ?? this._tripEntity
      .._driver = driver ?? this._driver
      .._driverArriveDuration = driverArriveDuration ?? this._driverArriveDuration
      .._driverArriveDistance = driverArriveDistance ?? this._driverArriveDistance
      .._directionDetailsEntity = directionDetailsEntity ?? this._directionDetailsEntity
      .._driverDirectionEntity = driverDirectionEntity ?? this._driverDirectionEntity
      .._arriveDuration = arriveDuration ?? this._arriveDuration
      .._arriveDistance = arriveDistance ?? this._arriveDistance
      .._usedTripPolyLines = usedTripPolyLines ?? this._usedTripPolyLines
      .._tripPolyLines = tripPolyLines ?? this._tripPolyLines;
  }


}

