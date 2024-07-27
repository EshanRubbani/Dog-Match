import 'package:DogMatch/views/Auth/ProfileImageUpload/dpUpload.dart';
import 'package:DogMatch/views/Auth/Verification/verifyEmail.dart';
import 'package:DogMatch/views/Auth/Wrapper/authwrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:DogMatch/Helper/Constants/Colors.dart';
import 'package:DogMatch/Helper/Painter/curved_painter.dart';
import 'package:DogMatch/views/Auth/SignIn/signIn.dart';

class SignUpMobile extends StatefulWidget {
  @override
  _SignUpMobileState createState() => _SignUpMobileState();
}

class _SignUpMobileState extends State<SignUpMobile> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            margin: const EdgeInsets.only(bottom: 60),
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                end: Alignment(0.0, 0.4),
                begin: Alignment(0.0, -1),
                colors: <Color>[Colors.pink, Color(0xFFFF5722)],
              ),
            ),
          ),
          CustomPaint(
            size: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.31,
            ),
            painter: CurvedPainter(),
          ),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 275),
                  Container(
                    height: MediaQuery.of(context).size.height - 280,
                    width: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Hero(
                          tag: "Sign Up",
                          child: Text(
                            AppLocalizations.of(context)!.register,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Popins',
                                fontSize: 30,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        Container(
                          height: 480,
                          width: double.infinity,
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          40,
                                      child: TextFormField(
                                        controller: firstNameController,
                                        textInputAction: TextInputAction.next,
                                        onSaved: (firstname) {},
                                        decoration: InputDecoration(
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .firstName,
                                          label: Text(
                                              AppLocalizations.of(context)!
                                                  .firstName),
                                          labelStyle: TextStyle(
                                              color: KAppColors.primaryColor),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      )),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.032,
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          50,
                                      child: TextFormField(
                                        controller: lastNameController,
                                        textInputAction: TextInputAction.next,
                                        onSaved: (lastname) {},
                                        decoration: InputDecoration(
                                          focusColor: KAppColors.secondaryColor,
                                          labelText:
                                              AppLocalizations.of(context)!
                                                  .lastName,
                                          labelStyle: TextStyle(
                                              color: KAppColors.primaryColor),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                              SizedBox(height: 20),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width - 70,
                                  child: TextFormField(
                                    controller: emailController,
                                    textInputAction: TextInputAction.next,
                                    onSaved: (email) {},
                                    decoration: InputDecoration(
                                      focusColor: KAppColors.secondaryColor,
                                      labelText:
                                          AppLocalizations.of(context)!.email,
                                      labelStyle: TextStyle(
                                          color: KAppColors.primaryColor),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  )),
                              SizedBox(height: 20),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width - 70,
                                  child: TextFormField(
                                    controller: passwordController,
                                    textInputAction: TextInputAction.next,
                                    onSaved: (password) {},
                                    decoration: InputDecoration(
                                      focusColor: KAppColors.secondaryColor,
                                      labelText: AppLocalizations.of(context)!
                                          .password,
                                      labelStyle: TextStyle(
                                          color: KAppColors.primaryColor),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  )),
                              SizedBox(height: 20),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width - 70,
                                  child: TextFormField(
                                    controller: confirmPasswordController,
                                    textInputAction: TextInputAction.next,
                                    onSaved: (cpassword) {},
                                    decoration: InputDecoration(
                                      focusColor: KAppColors.secondaryColor,
                                      labelText: AppLocalizations.of(context)!
                                          .confirmPassword,
                                      labelStyle: TextStyle(
                                          color: KAppColors.primaryColor),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  )),
                              SizedBox(height: 30),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.75,
                                height: 60,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromARGB(255, 255, 87, 34)
                                              .withOpacity(0.6),
                                      elevation: 15.0),
                                  onPressed: () {
                                    if (passwordController.text ==
                                            confirmPasswordController.text &&
                                        emailController.text.isNotEmpty) {
                                      signUp(
                                          firstNameController.text,
                                          lastNameController.text,
                                          emailController.text,
                                          passwordController.text);
                                    }
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.register,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Popins',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .alreadyAccount,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Get.to(SignIn());
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!.login,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: KAppColors.primaryColor),
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void signUp(String fname, String lname, String email, String password) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.orangeAccent.shade400,
               
              ),
            ));
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Check if user is not null before accessing uid
      if (userCredential.user != null) {
        await FirebaseFirestore.instance
            .collection('Profiles')
            .doc(userCredential.user!.uid)
            .set({
          'firstName': fname,
          'lastName': lname,
        });
        Navigator.of(context).pop();
        Get.snackbar("Success", "Account has been successfully created");
        Get.offAll(() => DpUpload());
      } else {
        Navigator.of(context).pop();
        Get.snackbar("Error", "Failed to create account");
      }
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      Get.snackbar("Error", e.toString());
    }
  }
}
