import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mileo/constants/strings.dart';
import 'package:mileo/models/user_model.dart';

import 'message_model.dart';

class MessageService{
  Firestore _firestore = Firestore.instance;
  CollectionReference _messagesCollection = Firestore.instance
                                      .collection(MESSAGES_COLLECTION);

  CollectionReference _contactsCollection =
      Firestore.instance.collection(CONTACTS_COLLECTION);

  Future addMessageToDb(Message message, User sender, User receiver) async{
    Map<String, dynamic> messageMap = message.toMap();
    await _messagesCollection
          .document(sender.uid)
          .collection(receiver.uid)
          .add(messageMap);
    return await _messagesCollection
          .document(receiver.uid)
          .collection(sender.uid)
          .add(messageMap);
  }

  Future addContact(User sender, User receiver) async {
    await _contactsCollection
        .document(sender.uid)
        .collection(sender.uid)
        .document(receiver.uid)
        .setData({'user': receiver.uid});
  }

  Stream streamMessage(User sender, User receiver) async*{
    yield await _messagesCollection
                .document(sender.uid)
                .collection(receiver.uid)
                .getDocuments()
                .then((value) => value.documents
                .map((snapshot) => Message.fromMap(snapshot.data)));
  }


  Future<List<User>> getContacts(User sender) async{
     
    List<User> contacts = [];

    List<DocumentSnapshot> docSnap = await _contactsCollection
        .document(sender.uid)
        .collection(sender.uid)
        .getDocuments()
        .then(
            (querySnapshot) =>  querySnapshot.documents);

    for(var i=0; i< docSnap.length; i++){
      contacts.add(await userFromUid(docSnap[i].data.values.first));
    }

    return contacts;
  }

  Future<User> userFromUid(String uid) async {
    User user;
    await Firestore.instance
        .collection(USERS_COLLECTION)
        .where('uid', isEqualTo: uid)
        .getDocuments()
        .then((value) {
          user = User.fromMap(value.documents.first.data);
        });

    return user;
  }
}