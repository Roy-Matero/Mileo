import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mileo/map/location_adapter.dart';
import 'package:mileo/models/user_model.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> controller1;

  LocationAdapter _locationAdapter = LocationAdapter();

  //static LatLng _center = LatLng(-15.4630239974464, 28.363397732282127);
  static LatLng _initialPosition;
  final Set<Marker> _markers = {};
  static LatLng _lastMapPosition = _initialPosition;

  bool isPermissionGranted;

  @override
  void initState() {
    super.initState();
    // _getUserLocation();
    _locationAdapter.getUserLocation().then((value) {
      setState(() {
        _initialPosition = value;
      });
    
    _locationAdapter.askLocationPermission().then((value) {
      setState(() {
        isPermissionGranted = value;
      });
    });
    });
  }

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  Widget mapButton(Function function, Icon icon, Color color) {
    return RawMaterialButton(
      onPressed: function,
      child: icon,
      shape: new CircleBorder(),
      elevation: 2.0,
      fillColor: color,
      padding: const EdgeInsets.all(7.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
      body: _initialPosition == null
          ? Container(
              color: Colors.black38,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              child: Stack(children: <Widget>[
                GoogleMap(
                  markers: _markers,
                  mapType: _currentMapType,
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 14.4746,
                  ),
                  onMapCreated: (controller) {
                    _locationAdapter.saveCurrentLocation(
                        user, _initialPosition);
                    controller1.complete(controller);
                  },
                  zoomGesturesEnabled: true,
                  onCameraMove: _onCameraMove,
                  myLocationEnabled: true,
                  compassEnabled: true,
                  myLocationButtonEnabled: false,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      margin: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
                      child: Column(
                        children: <Widget>[
                          mapButton(
                              _onMapTypeButtonPressed,
                              Icon(
                                IconData(0xf473,
                                    fontFamily: CupertinoIcons.iconFont,
                                    fontPackage:
                                        CupertinoIcons.iconFontPackage),
                              ),
                              Colors.green),
                        ],
                      )),
                )
              ]),
            ),
    );
  }
}
