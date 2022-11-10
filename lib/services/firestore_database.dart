import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/user.dart';
import 'auth_service.dart';

class FirestoreDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore.collection("users").doc(user.id).set({
        "name": user.name,
        "email": user.email,
        "profileImg": user.profileImg,
        "chatRoomList": []
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteUser(String userId) async {
    try {
      await _firestore.collection("users").doc(userId).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel> getUser(String? uid) async {
    try {
      DocumentSnapshot _doc =
      await _firestore.collection("users").doc(uid).get();
      return UserModel?.fromDocumentSnapshot(documentSnapshot: _doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> isAlreadyRegisterUser(String? uid) async {
    try {
      DocumentSnapshot _doc = await _firestore.collection("users").doc(uid).get();

      if (_doc.data() == null) { return false; } else { return true; }
    } catch (e) {
      return false;
    }
  }

  Future<Map> getUserInfoForChat(String uid) async {
    try {
      DocumentSnapshot _doc = await _firestore.collection("users").doc(uid).get();
      Map miniProfileInfo = {};
      miniProfileInfo["name"] = (_doc.data() as dynamic)['name'];
      miniProfileInfo["profileImg"] = (_doc.data() as dynamic)['profileImg'];

      return miniProfileInfo;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List> getChatList(String? uid) async {
    try {
      DocumentSnapshot _doc = await _firestore.collection("users").doc(uid).get();
      return _doc["chatRoomList"];
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Map> getChatRoom(String uid) async {
    try {
      DocumentSnapshot _doc = await _firestore.collection("chats").doc(uid).get();
      Map chatRoom = {};
      chatRoom["title"] = (_doc.data() as dynamic)['title'];
      chatRoom["memberList"] = (_doc.data() as dynamic)['members'];

      return chatRoom;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> createChatRoom(String title, List memberList, String userID, String roomID) async {
    try {
      await _firestore.collection("chats").doc(roomID).set({
        "title": title,
        "members": memberList,
      });

      DocumentSnapshot _userDoc = await _firestore.collection("users").doc(userID).get();
      List chatList = _userDoc.get("chatRoomList");
      chatList.add(roomID);
      await _firestore.collection("users").doc(userID).update({
        "chatRoomList": chatList,
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}