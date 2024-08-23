import 'dart:async';

import 'package:DogMatch/Helper/Constants/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:DogMatch/Helper/LangController/langcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:DogMatch/views/home/HomePage/home_page.dart';
import '../../home/TabsPage/tabs_page.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
class Verifyemaildesktop extends StatefulWidget {
const Verifyemaildesktop({ Key? key }) : super(key: key);

  @override
  State<Verifyemaildesktop> createState() => _VerifyemaildesktopState();
}

class _VerifyemaildesktopState extends State<Verifyemaildesktop> {
   bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      FirebaseAuth.instance.currentUser!.sendEmailVerification();
    }
    timer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => checkEmailVerified(),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    if (FirebaseAuth.instance.currentUser!.emailVerified) {
      timer?.cancel();
      setState(() {
        isEmailVerified = true;
      });
      Get.snackbar("Success", "Email Verified Successfully.");
      Get.to(() => TabsPage());
    }
  }

  Future sendVerificationEmail() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.orangeAccent.shade400,
              ),
            ));
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      Navigator.pop(context);
      Get.snackbar("Success",
          "Email Has Been Sent to your Email. Please Check Your Inbox.");
    } catch (e) {
      Navigator.pop(context);
      Get.snackbar("Error", e.toString());
    }
  }

  @override
  Widget build(BuildContext context){
    final LocalizationController localizationController = Get.find();

   return isEmailVerified ? HomePage() : 
      Scaffold(
        body: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.7,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logo.png',
                      height: MediaQuery.of(context).size.height * 0.6),
                  const SizedBox(height: 30),
                  Text(
                    AppLocalizations.of(context)!.title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lato',
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 450,
                    child: Text(
                      AppLocalizations.of(context)!.descriptionApp,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   Text(
                        "Welcome ${FirebaseAuth.instance.currentUser!.email}",
                        style:  TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width / 50,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 2 -200,
                          child:  Text(
                            "Please Verify your Email!. A link will be sent to your Email. Use the link to verify your account.",
                            style: TextStyle(
                                
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width / 70,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 70,
                        width: 250,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: KAppColors.primaryColor),
                            onPressed: sendVerificationEmail,
                            child: const Row(
                              children: [
                                Text(
                                  "Send Verification Email!",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.outgoing_mail,
                                  color: Colors.white,
                                )
                              ],
                            )),
                      )

                  ],
                ),
              ),
            ),
          ],
        ),
      );
   
  }
}