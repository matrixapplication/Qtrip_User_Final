class DestanceTripModel {
  String? originAddress;
  String? destinationAddresses;
  int? distance;
  int? duration;

  DestanceTripModel(
      {this.originAddress,
        this.destinationAddresses,
        this.distance,
        this.duration});

  DestanceTripModel.fromJson(Map<String, dynamic> json) {
    originAddress = json['origin_address'];
    destinationAddresses = json['destination_addresses'];
    distance = json['distance'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['origin_address'] = this.originAddress;
    data['destination_addresses'] = this.destinationAddresses;
    data['distance'] = this.distance;
    data['duration'] = this.duration;
    return data;
  }
}
