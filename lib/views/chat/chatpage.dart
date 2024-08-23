import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:DogMatch/views/chat/chat_service.dart';
import 'package:DogMatch/views/chat/profileavator.dart';
import 'package:DogMatch/views/chat/bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chatpage extends StatefulWidget {
  final String receiverEmail;

  Chatpage({super.key, required this.receiverEmail});

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ChatService _chatService = ChatService();
  FocusNode myFocusNode = FocusNode();

  late Future<String?> receiverID;

  @override
  void initState() {
    super.initState();
    // Fetch the receiver's UID from the email
    receiverID = _chatService.getUserUIDByEmail(widget.receiverEmail);

    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500), () => _scrollToBottom());
      }
    });
    Future.delayed(const Duration(milliseconds: 500), () => _scrollToBottom());
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  void _sendMessage(String receiverID) async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(receiverID, _messageController.text);
      _messageController.clear();
      _scrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        centerTitle: true,
        title: Text(widget.receiverEmail, style: const TextStyle(color: Colors.black)),
      ),
      body: FutureBuilder<String?>(
        future: receiverID,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text("Error loading chat"));
          }

          final String receiverUID = snapshot.data!;

          return Column(
            children: [
              Expanded(child: _buildMessageList(receiverUID)),
              _buildUserInput(receiverUID),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMessageList(String receiverUID) {
    final String currentUserID = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(currentUserID, receiverUID),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Error"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Colors.deepOrange));
        }
        Future.delayed(const Duration(milliseconds: 500), () => _scrollToBottom());

        return ListView.builder(
          controller: _scrollController,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            return _buildMessageItem(
              snapshot.data!.docs[index],
              index > 0 ? snapshot.data!.docs[index - 1] : null,
            );
          },
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc, DocumentSnapshot? previousDoc) {
  final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  final Map<String, dynamic>? prevData = previousDoc?.data() as Map<String, dynamic>?;
  final bool isCurrentUser = data["senderID"] == FirebaseAuth.instance.currentUser!.uid;
  final bool showAvatar = previousDoc == null || prevData?["senderID"] != data["senderID"];
  final alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

  return Container(
    alignment: alignment,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), // Add some padding
    child: Column(
      crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (showAvatar)
          FutureBuilder<String?>(
            future: _getUserProfileImage(isCurrentUser ? FirebaseAuth.instance.currentUser!.email! : data["senderEmail"]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Icon(Icons.error);
              } else {
                return Profileavator(profileUrl: snapshot.data ?? '');
              }
            },
          ),
        ChatBubble(
          isCurrentUser: isCurrentUser,
          message: data["message"],
          timestamp: data["timestamp"],
        ),
      ],
    ),
  );
}


  Widget _buildUserInput(String receiverUID) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.attach_file, color: Colors.deepOrange, size: 28)),
          const SizedBox(width: 5),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.grey[300],
              ),
              child: TextField(
                focusNode: myFocusNode,
                controller: _messageController,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  hintText: "Write Your Message",
                  suffixIcon: IconButton(onPressed: () => _sendMessage(receiverUID), icon: const Icon(Icons.send, color: Colors.deepOrange)),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(left: 15, top: 12),
                  hintStyle: const TextStyle(color: Color.fromARGB(147, 158, 158, 158)),
                ),
                onEditingComplete: () => _sendMessage(receiverUID),
              ),
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.camera, color: Colors.deepOrange, size: 28)),
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.mic, color: Colors.deepOrange, size: 28)),
        ],
      ),
    );
  }

  Future<String?> _getUserProfileImage(String email) async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Profiles')
          .where('email', isEqualTo: email)
          .get();
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first['dp'] as String?;
      }
      return null;
    } catch (e) {
      print("Error getting user profile image: $e");
      return null;
    }
  }
}
