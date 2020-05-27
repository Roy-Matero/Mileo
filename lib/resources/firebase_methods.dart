
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseMethods{
  Firestore _firestore = Firestore.instance;
  Future auth() async{
    return await _firestore
                .collection('messages')
                .add({'message': 'First test message'});
  }
}