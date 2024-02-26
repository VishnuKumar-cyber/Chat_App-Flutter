import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/Model/Message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  Future<void> sendMessage(String message, String receiveruid) async {
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      receiverid: receiveruid,
      message: message,
      senderemail: currentUserEmail,
      senderid: currentUserId,
      timestamp: timestamp,
    );

    List<String> ids = [currentUserId, receiveruid];
    ids.sort();
    String chatroomid = ids.join("_");

    await _store
        .collection('chat_rooms')
        .doc(chatroomid)
        .collection('messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    print(2);
    return _store
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
