import 'package:DogMatch/views/Auth/SigninOrSignUp/signUpsignIn.dart';
import 'package:DogMatch/views/home/AddPostPage/add.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ProfileScreenDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return  Scaffold(
      
      body:     Row(

        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                backgroundImage:
                    NetworkImage(user!.photoURL!),
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
             
                ],
              ),
            ),
          ),
          buildrightside(context)
        ],

      )
      );
  }

  Container buildrightside(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.2 ,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          end: Alignment(0.0, 0.4),
          begin: Alignment(0.0, -1),
          colors: <Color>[
            Colors.pink,
            Colors.deepOrange,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         
          
         
         
          Container(
            height: 56,
            width: 350,
           
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
            ),
            child:  Center(
              child: InkWell(
                onTap: (){
                   Get.to(const Add());
                },
                child: const Text(
                  "Add Post",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Container(
            height: 56,
            width: 350,
           
            decoration: BoxDecoration(
               color: Colors.white,
              borderRadius: BorderRadius.circular(100),
            ),
            child: InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut();
                  Get.offAll(SignInSignUp());
              },
              child: const Center(
                child: Text(
                  "Sign Out",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}

