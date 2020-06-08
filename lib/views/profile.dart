import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
  static LatLng _initialPosition;

  @override
  void initState() {
    super.initState();
    locationAdapter.getUserLocation().then((value) {
      setState(() {
        _initialPosition = value;
      });
    });
  }

  LocationAdapter locationAdapter = LocationAdapter();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    return Container(
      color: Colors.black54,
      child: Center(
        child: CupertinoButton(
          child: Text('Do something'),
          color: Colors.red,
          onPressed: () async{
            if(_initialPosition != null){
              var users = await locationAdapter.getUsersAround(_initialPosition);
              print(users.length);
            }
            else {
              print('Pos is null');
            }
          },
        ),
      ),
    );
  }
}
