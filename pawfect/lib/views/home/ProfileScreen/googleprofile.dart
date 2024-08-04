import 'package:DogMatch/views/Auth/SigninOrSignUp/signUpsignIn.dart';
import 'package:DogMatch/views/home/AddPostPage/add.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: Image.network("src").image,
                  radius: 100,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "email",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "email",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Get.to(const Add());
                  },
                  child: const Text('Add Post'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Implement sign out functionality
                    FirebaseAuth.instance.signOut();
                    Get.offAll(SignInSignUp());
                  },
                  child: const Text('Sign Out'),
                ),
              ],
            ),
          ),
        ));
  }
}
