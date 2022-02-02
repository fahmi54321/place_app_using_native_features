import 'dart:io';

//todo 1 (next great_places_provider)
class Place {
  final String id;
  final String title;
  final PlaceLocation? location;
  final File image;

  Place({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
  });
}

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation({ //todo 6 change to const (next location_input)
    required this.latitude,
    required this.longitude,
    this.address = '',
  });
}
