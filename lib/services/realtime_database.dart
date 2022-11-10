import 'package:firebase_database/firebase_database.dart';
import 'package:random_string/random_string.dart';

class RealtimeDatabase {
  FirebaseDatabase databaseInstance = FirebaseDatabase.instance;

  sendMessage(String roomID, String userID, String messageType, dynamic content) {
    String messageID = randomAlphaNumeric(35);
    int timeStamp = DateTime.now().microsecondsSinceEpoch;

    DatabaseReference _counterRef = databaseInstance.reference().child('chats').child(roomID).child('messages').child("${timeStamp}_$messageID");

    Map messageContent = {
      "user": userID,
      "type": messageType,
      "content": content,
      "timestamp": timeStamp
    };
    _counterRef.set(messageContent);
  }

  getMessageDatabase(String roomID) => databaseInstance.reference().child('chats').child(roomID).child('messages');
}