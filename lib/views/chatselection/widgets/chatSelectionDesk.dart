import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:DogMatch/views/chat/chatpage.dart';
import 'package:DogMatch/views/chatselection/widgets/menu_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class ChatSelectionDesk extends StatefulWidget {
  const ChatSelectionDesk({super.key});

  @override
  _ChatSelectionDeskState createState() => _ChatSelectionDeskState();
}

class _ChatSelectionDeskState extends State<ChatSelectionDesk> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  List<DocumentSnapshot> selectedUsers = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser!;
    final userIdentifier = user.email ?? user.phoneNumber;

    return Scaffold(
      body: Stack(
        children: [
          // The scrollable content
          Container(
            height: size.height- 100,
           

            
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Search Bar
                  Center(
                    child: Container(
                      
                      margin: const EdgeInsets.only(top: 40, bottom: 10),
                      width: 400,
                      height: 56,
                      padding: const EdgeInsets.all(16),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: Color(0xFFCBD5E1),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Builder(
                              builder: (context) {
                                return GestureDetector(
                                  
                                  child: TextField(
                                    controller: searchController,
                                    showCursor: true,
                                    decoration: const InputDecoration(
                                      hintText: 'Select Users to Send Message',
                                      border: InputBorder.none,
                                    ),
                                    style: const TextStyle(
                                      color: Color(0xFF64748B),
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    enableInteractiveSelection: true,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                 
                  // For Individual Chats
                  Center(
                    child: SizedBox(
                      width: 400,
                      height: size.height / 1.75,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: getUsersStream(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return const Center(
                                child: Text('No users available'));
                          } else {
                            var users = snapshot.data!.docs;
                            var filteredUsers = users.where((userDoc) {
                              var user = userDoc.data() as Map<String, dynamic>;
                              var fullName =
                                  '${user['firstName'] ?? ''} ${user['lastName'] ?? ''}'
                                      .toLowerCase();
                              return fullName
                                  .contains(searchQuery.toLowerCase());
                            }).toList();
            
                            return ListView.builder(
                              itemCount: filteredUsers.length,
                              itemBuilder: (context, index) {
                                var user = filteredUsers[index].data()
                                    as Map<String, dynamic>;
                                bool isSelected = selectedUsers
                                    .contains(filteredUsers[index]);
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Chatpage(
                                            receiverEmail: user['email'],
                                           
                                          ),
                                        ));
                                  },
                                  child: _buildUserList(
                                      user, isSelected, filteredUsers[index]),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // The fixed button at the bottom
          
        ],
      ),
    );
  }

  Widget _buildUserList(
      Map<String, dynamic> user, bool isSelected, DocumentSnapshot userDoc) {
    if (user["email"] != FirebaseAuth.instance.currentUser!.email) {
      return Container(
        width: 400,
        height: 80,
        margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 5),
        decoration: BoxDecoration(
          border: Border.all(
              color: isSelected ? Colors.deepOrange : Colors.grey.shade300,
              width: 2),
          borderRadius: BorderRadius.circular(10),
          color:
              isSelected ? Colors.deepOrange : Colors.white,
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
                  image: user['userIMG']?.isNotEmpty ?? false
                      ? NetworkImage(user['userIMG']) as ImageProvider
                      : const AssetImage('assets/images/profile.png'),
                  fit: BoxFit.cover,
                ),
              ),
              height: 60,
              width: 60,
            ),
            const SizedBox(width: 15),
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
                      '${user['firstName'] ?? 'First Name'} ${user['lastName'] ?? 'Last Name'}',
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
            Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.only(right: 20),
              child: Checkbox(
                activeColor: Colors.green,
                shape: const CircleBorder(),
                value: isSelected,
                onChanged: (bool? newValue) {
                  setState(() {
                    if (newValue == true) {
                      selectedUsers.add(userDoc);
                    } else {
                      selectedUsers.remove(userDoc);
                    }
                  });
                },
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildGroupList(Map<String, dynamic> groupDetails) {
    return Container(
      width: 400,
      height: 80,
      margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
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
                image: const AssetImage('assets/logo/group.png'),
                fit: BoxFit.cover,
              ),
            ),
            height: 60,
            width: 60,
          ),
          const SizedBox(width: 15),
          SizedBox(
            width: 170,
            height: 60,
            child: Column(
              children: [
                const SizedBox(height: 15),
                SizedBox(
                  width: 170,
                  height: 25,
                  child: Text(
                    '${groupDetails['groupName']}',
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 16,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Stream<QuerySnapshot> getUsersStream() {
    return FirebaseFirestore.instance.collection("Profiles").orderBy('timestamp', descending: true).snapshots();
  }
}

class MyButton extends StatefulWidget {
  final bool index;

  const MyButton({
    super.key,
    required this.index,
  });

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool showContainer = true;

  @override
  Widget build(BuildContext context) {
    return showContainer
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  constraints:
                      const BoxConstraints(minWidth: 380.0, minHeight: 60),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.deepOrange,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.deepOrange),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Type Message",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Inter",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
