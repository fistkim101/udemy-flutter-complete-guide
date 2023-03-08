class LocationModel {
  final double logtitude;
  final double latitude;
  String? address;

  LocationModel({
    required this.logtitude,
    required this.latitude,
    this.address,
  });

  @override
  String toString() {
    return 'LocationModel{logtitude: $logtitude, latitude: $latitude, address: $address}';
  }
}
