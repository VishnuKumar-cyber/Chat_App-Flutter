import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/Model/chatBubble.dart';
import 'package:demo_app/Services/chat/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chat extends StatefulWidget {
  final String receivername;
  final String receiveruid;
  final String receiveremail;
  const Chat(
      {super.key,
      required this.receivername,
      required this.receiveruid,
      required this.receiveremail});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController _messagecontroller = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  void sendMessage() async {
    if (_messagecontroller.text.isNotEmpty) {
      await _chatService.sendMessage(
          _messagecontroller.text, widget.receiveruid);
      _messagecontroller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receivername),
        elevation: 10,
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.black,
        shadowColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessagesList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    print(1);
    return StreamBuilder(
      stream:
          _chatService.getMessages(widget.receiveruid, _auth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading');
        }
        if (snapshot.data == null) {
          return const Text('No data available');
        } else {
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        }
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var alignment = (data['senderId'] == _auth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    var time = DateTime.parse(data['time'].toDate().toString());
    String formattedTime = DateFormat.jm().format(time);

    return Container(
      alignment: alignment,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(3.0),
            alignment: alignment,
            child: Text(
              formattedTime,
            ),
          ),
          Container(
            alignment: alignment,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: ChatBubble(message: data['message']),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: TextField(
              controller: _messagecontroller,
              decoration: const InputDecoration(
                labelText: 'Message',
                hintText: 'Enter Message',
              ),
              obscureText: false,
            ),
          ),
        ),
        IconButton(
          onPressed: sendMessage,
          icon: const Icon(
            Icons.arrow_upward_sharp,
            size: 40,
          ),
        ),
      ],
    );
  }
}
