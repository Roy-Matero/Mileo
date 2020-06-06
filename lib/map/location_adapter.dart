import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationAdapter{
  LatLng initialPosition;
  Future<LatLng> getUserLocation() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
    initialPosition = LatLng(position.latitude, position.longitude);
    return initialPosition;
  }
}