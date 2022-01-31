//todo 1 (next location_input)

const GOOGLE_API_KEY = 'AIzaSyDI4X-fug0yawUaQ0I4xeNUXmaSRxlb5B8';

class LocationHelper {
  String generatelocationPreviewImage({
    required double latitude,
    required double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }
}
