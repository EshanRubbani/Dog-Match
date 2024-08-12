// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:DogMatch/views/chat/message.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class ChatService {
//   // Get instance of Firestore
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Get Users Stream
//   Stream<List<Map<String, dynamic>>> getUsersStream() {
//     return _firestore.collection("users").snapshots().map((snapshots) {
//       return snapshots.docs.map((doc) {
//         final user = doc.data();
//         return user;
//       }).toList();
//     });
//   }

// Future<void> sendMessage(String chatId, String message) async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) return;

//     final DocumentReference chatDocRef = _firestore.collection('chats').doc(chatId);
//     final CollectionReference messagesRef = chatDocRef.collection('messages');

//     final newMessage = {
//       'senderID': user.uid,
//       'senderEmail': user.email,
//       'message': message,
//       'timestamp': FieldValue.serverTimestamp(),
//     };

//     // Check if the chat document exists
//     final chatDocSnapshot = await chatDocRef.get();
//     if (chatDocSnapshot.exists) {
//       // If the document exists, update it with the new message
//       await messagesRef.add(newMessage);
//     } else {
//       // If the document doesn't exist, create it and add the first message
//       await chatDocRef.set({
//         'participants': [user.uid, user.email], // Store participants info if needed
//         'createdAt': FieldValue.serverTimestamp(),
//       });
//       await messagesRef.add(newMessage);
//     }
//   }

//   Stream<QuerySnapshot> getMessages(String chatId) {
//     return _firestore.collection('chats').doc(chatId).collection('messages').orderBy('timestamp').snapshots();
//   }

//   // Get chat streams for a specific user
//   Stream<List<Map<String, dynamic>>> getUserChats(String userID) {
//     return _firestore
//         .collection("chats")
//         .where("participants", arrayContains: userID)
//         .orderBy("updatedAt", descending: true)
//         .snapshots()
//         .map((snapshots) {
//           return snapshots.docs.map((doc) => doc.data()).toList();
//         });
//   }
// }
