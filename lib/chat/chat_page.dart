import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mileo/auth/auth_service_adapter.dart';
import 'package:mileo/models/user_model.dart';

import 'message_model.dart';
import 'message_service.dart';

class ChatScreen extends StatefulWidget {
  final User receiver;

  const ChatScreen({Key key, this.receiver}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController textFieldController = TextEditingController();

  bool isWritting = false;

  User sender;

  String _currentUserId;

  AuthServiceAdapter authServiceAdapter = AuthServiceAdapter();

  MessageService _messageService = MessageService();

  @override
  void initState() {
    super.initState();
    authServiceAdapter.currentUser().then((User currentUser) {
      _currentUserId = currentUser.uid;

      setState(() {
        sender = User(uid: currentUser.uid);
      });
    });
  }

  Widget messageList() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('messages')
          .document(_currentUserId)
          .collection(widget.receiver.uid)
          .orderBy('timeStamp', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        }
      if(snapshot.data.documents.length == 1){
        _messageService.addContact(sender, widget.receiver);
      }
        return ListView.builder(
          padding: EdgeInsets.all(10),
          reverse: true,
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) {
            return chatMessageItem(snapshot.data.documents[index]);
          },
        );
      },
    );
  }

  Widget chatMessageItem(DocumentSnapshot snap) {
    Message _message = Message.fromMap(snap.data);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      alignment: _message.senderId == _currentUserId
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: _message.senderId == _currentUserId
          ? senderLayout(_message)
          : receiverLayout(_message),
    );
  }

  Widget senderLayout(Message message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          height: 40,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(20)),
          child: Center(child: getMessage(message)),
        ),
      ],
    );
  }

  Widget receiverLayout(Message message) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          backgroundImage: NetworkImage("https://bit.ly/2JUW5lG"),
        ),
        SizedBox(width: 10),
        Container(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: getMessage(message),
          ),
        ),
      ],
    );
  }

  Widget getMessage(Message message) {
    return Text(
      message.message,
      style: TextStyle(
        fontSize: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          widget.receiver.name,
          style: TextStyle(),
        ),
      ),
      body: SafeArea(
          child: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Flexible(
            child: messageList(),
          ),
          chatControls(),
        ],
      )),
    );
  }

  Widget chatControls() {
    changeIsWritting(bool val) {
      setState(() {
        isWritting = val;
      });
    }

    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {},
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: textFieldController,
              style: TextStyle(
                fontSize: 20,
              ),
              onChanged: (val) {
                (val.length > 0 && val.trim() != '')
                    ? changeIsWritting(true)
                    : changeIsWritting(false);
              },
              decoration: InputDecoration(
                hintText: 'Type a message',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.black45,
              ),
            ),
          ),
          isWritting
              ? Container()
              : IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () {},
                ),
          isWritting
              ? Container()
              : IconButton(
                  icon: Icon(Icons.photo),
                  onPressed: () {},
                ),
          isWritting
              ? Container(
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          colors: [Colors.blue, Colors.blueAccent])),
                  child: IconButton(
                    icon: Icon(
                      Icons.send,
                      size: 25,
                    ),
                    onPressed: () => sendMessage(),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  void sendMessage() {
    var text = textFieldController.text;

    Message _message = Message(
        receiverId: widget.receiver.uid,
        senderId: sender.uid,
        message: text,
        timeStamp: Timestamp.now(),
        type: 'text');

    setState(() {
      isWritting = false;
    });

    _messageService.addMessageToDb(_message, sender, widget.receiver);
    textFieldController.clear();
  }
}