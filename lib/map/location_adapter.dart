import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as LocLib;
import 'package:mileo/models/user_model.dart';

class LocationAdapter {
  Geoflutterfire geo = Geoflutterfire();
  Firestore _firestore = Firestore.instance;
  LatLng initialPosition;

  LocLib.Location location = LocLib.Location();
  bool _serviceEnabled;
  LocLib.PermissionStatus permissionGranted;
  LocLib.LocationData locationData;

  Future<bool> askLocationPermission() async {
    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      print(_serviceEnabled);
      _serviceEnabled = await location.requestService();
      if (_serviceEnabled) {
        return true;
      }
    }
    return true;
  }

  Future<LatLng> getUserLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    initialPosition = LatLng(position.latitude, position.longitude);
    return initialPosition;
  }

  Future saveCurrentLocation(User user, LatLng currentLatLng) async {
    GeoFirePoint currentLocation = geo.point(
        latitude: currentLatLng.latitude, longitude: currentLatLng.latitude);
    await _firestore.collection('locations').document(user.uid).setData({
      'uid': user.uid,
      'location': currentLocation.data,
    });
  }

  Future getUsersAround() async {}
}
