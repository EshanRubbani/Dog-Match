import 'package:DogMatch/views/Auth/SigninOrSignUp/signUpsignIn.dart';
import 'package:DogMatch/views/home/AddPostPage/add.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreenMobile extends StatefulWidget {
  @override
  _ProfileScreenMobileState createState() => _ProfileScreenMobileState();
}

class _ProfileScreenMobileState extends State<ProfileScreenMobile> {
  User? user = FirebaseAuth.instance.currentUser;
  String? firstName;
  String? lastName;
  String? profileImageUrl;
  String? email;
  List<String>? likedMe = [];
  List<String>? interestedProfiles = [];

  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  Future<void> fetchDetails() async {
    if (user != null) {
      // Fetch user profile from Firestore
      final userDoc = await FirebaseFirestore.instance
          .collection('Profiles')
          .doc(user!.uid)
          .get();

      if (userDoc.exists) {
        setState(() {
          firstName = userDoc.data()?['firstName'];
          lastName = userDoc.data()?['lastName'];
          profileImageUrl = userDoc.data()?['dp'];
          email = userDoc.data()?['email'] ?? user!.email;
          likedMe = List<String>.from(userDoc.data()?['likedme'] ?? ["No Data"]);
          interestedProfiles =
              List<String>.from(userDoc.data()?['interestedProfiles'] ?? ["No Data"]);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color.fromARGB(255, 255, 87, 34).withOpacity(0.9),
                ),
            onPressed: () {
              Get.to(const Add());
            },
            child: const Text('Add Post',style: TextStyle(color: Colors.white),),
          ),
          SizedBox(
            width: 20,
          ),
          ElevatedButton(
             style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color.fromARGB(255, 255, 87, 34).withOpacity(0.9),
                ),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Get.offAll(SignInSignUp());
            },
            child: const Text('Sign Out',style: TextStyle(color: Colors.white),),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: user != null
          ? Center(
            child: Container(
            
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (profileImageUrl != null)
                      CircleAvatar(
                        backgroundImage: NetworkImage(profileImageUrl!),
                        radius: 100,
                      ),
                    const SizedBox(height: 30),
                    Text(
                      firstName == lastName || lastName == null
                          ? '$firstName'
                          : '$firstName $lastName',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      email ?? 'No Email',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 30),
                    if (likedMe!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Added Me:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ...likedMe!.map((user) => Text(user)).toList(),
                        ],
                      ),
                    const SizedBox(height: 30),
                    if (interestedProfiles!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Interested Profiles:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ...interestedProfiles!
                              .map((user) => Text(user))
                              .toList(),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
