import 'package:DogMatch/Helper/GoogleLoginController/glogincontroller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:DogMatch/Helper/LangController/langcontroller.dart';
import 'package:DogMatch/Helper/Responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:DogMatch/views/Auth/SignIn/signIn.dart';
import 'package:DogMatch/views/Auth/SignUp/signup.dart';
import 'package:DogMatch/views/home/HomePage/home_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../Helper/Painter/curved_painter.dart';
import '../../home/TabsPage/tabs_page.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class SignUpsigninMobile extends StatefulWidget {
  const SignUpsigninMobile({Key? key}) : super(key: key);

  @override
  State<SignUpsigninMobile> createState() => _SignUpsigninMobileState();
}

class _SignUpsigninMobileState extends State<SignUpsigninMobile> {
  @override
  Widget build(BuildContext context) {
    final LocalizationController localizationController = Get.find();
    bool isEnglish = Get.locale?.languageCode == 'en';

    void _onLanguageChanged(bool value) {
      setState(() {
        isEnglish = value;
      });
      Get.find<LocalizationController>()
          .changeLanguage(isEnglish ? 'en' : 'el');
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.20,
            margin: const EdgeInsets.only(bottom: 60),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                end: const Alignment(0.0, 0.4),
                begin: const Alignment(0.0, -1),
                colors: <Color>[
                  Colors.pink,
                  const Color.fromARGB(255, 255, 87, 34).withOpacity(0.9)
                ],
              ),
            ),
          ),
          CustomPaint(
            size: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.20,
            ),
            painter: CurvedPainter(),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      isEnglish ? 'Greek' : 'Greek',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(width: 10),
                    Switch(
                      value: isEnglish,
                      onChanged: _onLanguageChanged,
                    ),
                    SizedBox(width: 10),
                    Text(
                      isEnglish ? 'English' : 'English',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: 15,
                    )
                  ],
                ),
                 Container(
                  height: 20,
                ),
                Container(
                
                               
                    width: 150,   
                  child: Image.asset('assets/logo.png'),
                ),
                Container(
                  height: 75,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          AppLocalizations.of(context)!.title,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lato',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        
                        Container(
                          width: MediaQuery.of(context).size.width / 2 + 80,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 87, 34)
                                      .withOpacity(0.6),
                              elevation: 15.0,
                            ),
                            onPressed: () {
                              Get.to(SignUp());
                            },
                            child: Hero(
                              tag: "SignUp",
                              child: Text(
                                AppLocalizations.of(context)!.register,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Popins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Hero(
                          tag: "SignIn",
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2 + 80,
                            height: 60,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 87, 34)
                                        .withOpacity(0.6),
                                elevation: 15.0,
                              ),
                              onPressed: () {
                                Get.to(SignIn());
                              },
                              child: Text(
                                AppLocalizations.of(context)!.login,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Popins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Text(
                            AppLocalizations.of(context)!.or,
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Popins',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2 + 80,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 87, 34)
                                      .withOpacity(0.6),
                              elevation: 15.0,
                            ),
                            onPressed: () async {
                              try {
                                final GoogleSignInAccount? googleUser =
                                    await GoogleSignIn().signIn();
                                if (googleUser != null) {
                                  final GoogleSignInAuthentication googleAuth =
                                      await googleUser.authentication;

                                  final AuthCredential credential =
                                      GoogleAuthProvider.credential(
                                    accessToken: googleAuth.accessToken,
                                    idToken: googleAuth.idToken,
                                  );

                                  // Sign in to Firebase with the Google user's credentials
                                  UserCredential userCredential =
                                      await FirebaseAuth.instance
                                          .signInWithCredential(credential);
                                  User? user = userCredential.user;

                                  if (user != null) {
                                    final userDoc = FirebaseFirestore.instance
                                        .collection('Profiles')
                                        .doc(userCredential.user!.uid);

                                    // Check if the document exists
                                    DocumentSnapshot docSnapshot =
                                        await userDoc.get();

                                    if (docSnapshot.exists) {
                                      // Update the document if it exists
                                      await userDoc.update({
                                        'firstName': googleUser.displayName,
                                        'lastName': googleUser.displayName,
                                        "email": googleUser.email,
                                        'dp': FirebaseAuth
                                            .instance.currentUser!.photoURL,
                                      });
                                    } else {
                                      // Create the document if it doesn't exist, without overwriting existing data
                                      await userDoc.set({
                                        'firstName': googleUser.displayName,
                                        'lastName': googleUser.displayName,
                                        "email": googleUser.email,
                                        'dp': FirebaseAuth
                                            .instance.currentUser!.photoURL,
                                      }, SetOptions(merge: true));
                                    }

                                    Get.snackbar("Success",
                                        "Account has been successfully created");

                                    Get.to(TabsPage());
                                  } else {
                                    Get.snackbar("Error",
                                        "Something went wrong. Please Try Again.");
                                  }
                                } else {
                                  // The user canceled the sign-in
                                  Get.snackbar("Error", "Cancelled By User");
                                }
                              } catch (error) {
                                // Handle error
                                print(error);
                              }
                            },
                            child: const Text(
                              "Google", // Replace with localized string if available
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Popins',
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
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
}
