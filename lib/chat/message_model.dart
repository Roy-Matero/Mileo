import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Message{
  Message({@required this.message, 
           @required this.type,
           @required this.senderId, 
           @required this.receiverId, 
           @required this.timeStamp,});

  String message;
  String type;
  String senderId;
  String receiverId;
  Timestamp timeStamp;
  String photoUrl;

  factory Message.fromMap(Map<String, dynamic> data){
    return Message(
      message: data['message'],
      type: data['type'],
      senderId: data['senderId'],
      receiverId: data['receiverId'],
      timeStamp: data['timeStamp'],
    );
  }

  Message.imageMessage({this.senderId, this.receiverId, this.type,
          this.message, this.timeStamp, this.photoUrl});

  Map<String, dynamic> toMap(){
    return {
      'message': message,
      'senderId': senderId,
      'receiverId': receiverId,
      'timeStamp': timeStamp,
    };
  }

}