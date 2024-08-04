import 'package:DogMatch/views/Auth/SigninOrSignUp/signUpsignIn.dart';
import 'package:DogMatch/views/home/AddPostPage/add.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: user != null
          ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage:
                    NetworkImage(user.photoURL!),
                                   radius: 100,
              ),
              const SizedBox(height: 30),
              Text(
                user.displayName ?? 'No Name',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                user.email ?? 'No Email',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Get.to(const Add());
                },
                child: const Text('Add Post'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Get.offAll(SignInSignUp());
                },
                child: const Text('Sign Out'),
              ),
            ],
          ),
        ),
      )
          : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
