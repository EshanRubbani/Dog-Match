import 'package:DogMatch/views/chat/chat_service.dart'; // Import the ChatService
import 'package:DogMatch/views/chat/chatpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatSelectionMobile extends StatefulWidget {
  const ChatSelectionMobile({super.key});

  @override
  _ChatSelectionMobileState createState() => _ChatSelectionMobileState();
}

class _ChatSelectionMobileState extends State<ChatSelectionMobile> {
  final ChatService _chatService = ChatService(); // Create an instance of ChatService

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title:  Text("Chat",style: TextStyle(color: Colors.black,fontSize: 24,fontFamily: "lato"),),
        
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                width: 400,
                height: size.height / 2.26,
                child: buildStream(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SingleChildScrollView buildStream() {
    return SingleChildScrollView(
      child: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _chatService.getUsersStream(), // Use ChatService
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users available'));
          } else {
            var users = snapshot.data!;

            return Container(
              color: Colors.white,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  var user = users[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Chatpage(
                            receiverEmail: user['email'],
                          ),
                        ),
                      );
                    },
                    child: _buildUserList(user),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildUserList(Map<String, dynamic> user) {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final userIdentifier = currentUser.uid;

    if (user["userId"] != userIdentifier) {
      return Container(
        width: 400,
        height: 80,
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 2),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 0.2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  image: user['profilePictureUrl']?.isNotEmpty ?? false
                      ? NetworkImage(user['profilePictureUrl']) as ImageProvider
                      : const AssetImage('assets/icons/profile.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              height: 60,
              width: 60,
            ),
            const SizedBox(width: 25),
            SizedBox(
              width: 170,
              height: 60,
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  SizedBox(
                    width: 170,
                    height: 25,
                    child: Text(
                      '${user['firstName'] ?? 'Username'} ${user['lastName'] ?? ''}',
                      style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 16,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                    width: 170,
                    child: Text(
                      user['email'] ?? 'Email',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
