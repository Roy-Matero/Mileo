import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as LocLib;
import 'package:mileo/constants/strings.dart';
import 'package:mileo/models/user_model.dart';

class LocationAdapter {
  Geoflutterfire geo = Geoflutterfire();
  static Firestore _firestore = Firestore.instance;
  LatLng initialPosition;

  LocLib.Location location = LocLib.Location();
  bool _serviceEnabled;
  LocLib.PermissionStatus permissionGranted;
  LocLib.LocationData locationData;

  List nearbyUsersList = [];

  CollectionReference locationReference =
      _firestore.collection(LOCATIONS_COLLECTION);

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
        latitude: currentLatLng.latitude, longitude: currentLatLng.longitude);
    await locationReference.document(user.uid).setData({
      'uid': user.uid,
      'position': currentLocation.data,
    });
  }

   getUsersAround(LatLng currentLatLng) async{
    
    GeoFirePoint center = geo.point(
        latitude: currentLatLng.latitude, longitude: currentLatLng.longitude);
    double radius = 100;
    String field = 'position';
    Stream<List<DocumentSnapshot>> stream = geo
        .collection(collectionRef: locationReference)
        .within(
            center: center,
            radius: radius,
            field: field);
    stream.listen((List<DocumentSnapshot> documentsList) {
      // print('Raw length is ${documentsList.length}');
      for (var i = 0; i < documentsList.length; i++) {
        if(! nearbyUsersList.contains(documentsList[i].data)){
          nearbyUsersList.add(documentsList[i].data);
        }
        // print(documentsList[i].data);
      }
      // return documentsList;
    });
    
    if(nearbyUsersList.length != 0){
      return nearbyUsersList;
    }
  }
}
