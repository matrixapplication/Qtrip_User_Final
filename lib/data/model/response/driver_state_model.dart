
import '../../../domain/entities/driver_state_entity.dart';



class DriverStateModel extends DriverStateEntity{

  const DriverStateModel({
    required num distance,
    required num trips,
    required num duration,

  }) : super(
      distance : distance,
      trips : trips,
      duration : duration);



  factory DriverStateModel.fromJson(Map<String, dynamic>? json ) {
    return DriverStateModel(
      distance: json?["distance"] ?? 0,
      trips: json?["trips"] ?? 0,
      duration: json?["duration"] ??0,

    );
  }

}
