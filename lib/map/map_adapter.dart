import 'package:location/location.dart';

class MapAdapter{
  Location location = Location();
  bool _serviceEnabled;
  PermissionStatus permissionGranted;
  LocationData locationData;

  Future<PermissionStatus> askLocationPermission() async{
    _serviceEnabled =  await location.serviceEnabled();

    if(!_serviceEnabled){
      _serviceEnabled = await location.requestService();
    }
  }
  
}