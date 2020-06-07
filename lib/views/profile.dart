import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mileo/map/location_adapter.dart';
import 'package:mileo/models/user_model.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  LocationAdapter _locationAdapter = LocationAdapter();

  static LatLng _initialPosition;

  @override
  void initState() {
    super.initState();
    // _getUserLocation();
    _locationAdapter.getUserLocation().then((value) {
      setState(() {
        _initialPosition = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    return Container(
      child: Center(
          child: FlatButton(
        child: Text('Upload something'),
        onPressed: () {
          if (_initialPosition != null) {
            _locationAdapter.saveCurrentLocation(user, _initialPosition);
          }
        },
      )),
    );
  }
}
