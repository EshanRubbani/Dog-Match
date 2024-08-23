import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:DogMatch/views/chat/message.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  // Get instance of Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get all Users Stream
  Stream<List<Map<String, dynamic>>> getallUsersStream() {
    return _firestore.collection("Profiles").snapshots().map((snapshots) {
      return snapshots.docs.map((doc) {
        //go through each individual user
        final user = doc.data();
        //return user
        return user;
      }).toList();
    });
  }

Stream<List<Map<String, dynamic>>> getUsersStream() {
  final currentUserUid = FirebaseAuth.instance.currentUser!.uid;
  final _firestore = FirebaseFirestore.instance;

  return _firestore.collection("Profiles").doc(currentUserUid).snapshots().asyncMap((documentSnapshot) async {
    if (documentSnapshot.exists) {
      // Get the data from the current user's document
      final data = documentSnapshot.data() as Map<String, dynamic>;

      // Retrieve the interestedProfiles and likedme arrays
      List<dynamic> interestedProfiles = data['interestedProfiles'] ?? [];
      List<dynamic> likedme = data['likedme'] ?? [];

      // Combine the two arrays and remove duplicates
      final allEmails = interestedProfiles.toSet().union(likedme.toSet()).toList();

      // Fetch the user documents for all emails
      List<Map<String, dynamic>> users = [];

      for (String email in allEmails) {
        final querySnapshot = await _firestore.collection("Profiles")
          .where("email", isEqualTo: email)
          .limit(1) // Limiting to 1 to only fetch the first match
          .get();
          
        if (querySnapshot.docs.isNotEmpty) {
          final docData = querySnapshot.docs.first.data();
          users.add({
            'userId': querySnapshot.docs.first.id,
            'firstName': docData['firstName'] ?? '',
            'lastName': docData['lastName'] ?? '',
            'email': docData['email'] ?? '',
            'profilePictureUrl': docData['dp'] ?? '',
          });
        }
      }

      return users;
    } else {
      return [];
    }
  });
}


//send messgae
  Future<void> sendMessage(String receieverID, String message) async {
    //get current user info
    final String currentuserID = FirebaseAuth.instance.currentUser!.uid;
    final String currentuserEmail = FirebaseAuth.instance.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create a neww messsgae

    Message newMesssage = Message(
        senderID: currentuserEmail,
        receiverID: receieverID,
        senderEmail: currentuserEmail,
        message: message,
        timestamp: timestamp);

    //construct chat room id for to users (sorted to ensure uniqueness)
    List<String> ids = [currentuserID, receieverID];
    ids.sort();
    String chatRoomID = ids.join("_");
    //add new message to database
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMesssage.toMap());

    
  }
  
      //get messages
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
      //construct chatroom id for two users
      List<String> ids = [userID, otherUserID];
      ids.sort();
      String chatRoomID = ids.join("_");
      return _firestore
          .collection("chat_rooms")
          .doc(chatRoomID)
          .collection("messages")
          .orderBy("timestamp", descending: false)
          .snapshots();
    }

//get user uid from email

Future<String> getUserUIDByEmail(String email) async {
  final QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Profiles')
      .where('email', isEqualTo: email)
      .get();

  if (snapshot.docs.isNotEmpty) {
    // Return the UID (which is the document ID)
    return snapshot.docs.first.id;
  } else {
    // If no user found with that email, return null or handle as needed
    return "";
  }
}

}