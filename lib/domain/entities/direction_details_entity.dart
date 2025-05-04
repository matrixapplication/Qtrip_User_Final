class DirectionDetailsEntity{
 final String? _distanceText;
 final String? _durationText;
 final int? _distanceValue;
 final int? _durationValue;
 final String? _encodedPoints;

  DirectionDetailsEntity({
     String? distanceText,
     String? durationText,
     int? distanceValue,
     int? durationValue,
     String? encodedPoints,
  })  : _distanceText = distanceText,
        _durationText = durationText,
        _distanceValue = distanceValue,
        _durationValue = durationValue,
        _encodedPoints = encodedPoints;

  String? get encodedPoints => _encodedPoints;

  int? get durationValue => _durationValue;

  int? get distanceValue => _distanceValue;

  String? get durationText => _durationText;

  String? get distanceText => _distanceText;


}