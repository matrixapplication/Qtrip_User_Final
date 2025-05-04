class AddressLocationModel{
  final int? id;
  final String? country;
  final String? city;
  final String? locality;
  final String? street;
  final String? bigCity;
  final String? lat;
  final String? long;

  AddressLocationModel(
      {this.country,
      this.city,
      this.id,
      this.locality,
      this.street,
      this.bigCity,
      this.lat,
      this.long});
}