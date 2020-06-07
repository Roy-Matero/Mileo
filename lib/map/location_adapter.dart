import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mileo/models/user_model.dart';

class LocationAdapter {
  Geoflutterfire geo = Geoflutterfire();
  Firestore _firestore = Firestore.instance;
  LatLng initialPosition;

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
        latitude: currentLatLng.latitude,
        longitude: currentLatLng.latitude);
    await _firestore.collection('locations').document(user.uid).setData({
      'uid': user.uid,
      'location': currentLocation.data,
    });
  }

  Future getUsersAround() async {}
}
