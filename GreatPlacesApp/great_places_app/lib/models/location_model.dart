class LocationModel {
  final String latitude;
  final String logtitude;
  String? address;

  LocationModel({
    required this.latitude,
    required this.logtitude,
    this.address,
  });

  @override
  String toString() {
    return 'LocationModel{logtitude: $logtitude, latitude: $latitude, address: $address}';
  }
}
