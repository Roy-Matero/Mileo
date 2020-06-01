import 'package:flutter/material.dart';
import 'package:mileo/models/user_model.dart';
import 'package:provider/provider.dart';

import 'chat_page.dart';
import 'message_service.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  MessageService _messageService = MessageService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return SafeArea(
          child: Scaffold(
          extendBody: true,
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                iconSize: 30,
                onPressed: () {
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) => SearchUser()));
                },
              ),
              SizedBox(width: 30),
            ],
          ),
          body: Container(
            child: FutureBuilder<List<User>>(
              future: _messageService.getContacts(user),
              builder: (context,  snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    padding: EdgeInsets.all(20),
                    itemCount: snapshot.data.length ?? 0,
                    itemBuilder: (context, index) {
                      return ContactTile(contact: snapshot.data[index],);
                      // return ListTile(
                      //   title: Text(snapshot.data[index].displayName),
                      // );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )),
    );
  }
}

class ContactTile extends StatelessWidget {
  const ContactTile({Key key, @required this.contact}) : super(key: key);

  final User contact;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
         leading: CircleAvatar(
          //  backgroundImage: NetworkImage(
          //    searchedUser.photoUrl
          //  ),
          backgroundColor: Colors.white,
         ),
         title: Text(contact.name),
         onTap: (){
           Navigator.of(context).push(
             MaterialPageRoute(builder: (context) => ChatScreen(receiver: contact,))
           );
         },
       ),
    );
  }
}