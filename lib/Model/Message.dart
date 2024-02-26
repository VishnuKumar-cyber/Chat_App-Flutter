import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String receiverid;
  final String senderid;
  final String senderemail;
  final String message;
  final Timestamp timestamp;

  Message(
      {required this.receiverid,
      required this.message,
      required this.senderemail,
      required this.senderid,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderid,
      'senderEmail': senderemail,
      'receiverId': receiverid,
      'message': message,
      'time': timestamp,
    };
  }
}
