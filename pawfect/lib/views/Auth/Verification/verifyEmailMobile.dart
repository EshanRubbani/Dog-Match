import 'dart:async';
import 'package:DogMatch/Helper/Constants/Colors.dart';
import 'package:DogMatch/Helper/Painter/curved_painter.dart';
import 'package:DogMatch/main.dart';
import 'package:DogMatch/views/home/TabsPage/tabs_page.dart';
import 'package:DogMatch/views/home/HomePage/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailMobile extends StatefulWidget {
  const VerifyEmailMobile({Key? key}) : super(key: key);

  @override
  _VerifyEmailMobileState createState() => _VerifyEmailMobileState();
}

class _VerifyEmailMobileState extends State<VerifyEmailMobile> {
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
  Widget build(BuildContext context) {
    return isEmailVerified
        ? HomePage()
        : Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
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
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height:
                              MediaQuery.of(context).size.height * 0.4 - 100,
                          child: Image.asset('assets/logo.png')),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          width: 250.0,
                          child: const DefaultTextStyle(
                            style: TextStyle(
                              fontSize: 30.0,
                              fontFamily: 'Popins',
                            ),
                            child: Center(
                                child: Text(
                              "DogMatch",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: KAppColors.mediumPrimaryColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            )),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Welcome ${FirebaseAuth.instance.currentUser!.email}",
                        style: const TextStyle(
                            color: KAppColors.mediumPrimaryColor,
                            fontSize: 20,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Your Account is not Verified.",
                        style: TextStyle(
                            color: KAppColors.mediumPrimaryColor,
                            fontSize: 18,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 2 + 100,
                          child: const Text(
                            "Please Verify your Email!. A link will be sent to your Email. Use the link to verify your account.",
                            style: TextStyle(
                                color: KAppColors.mediumPrimaryColor,
                                fontFamily: "Poppins",
                                fontSize: 16),
                          )),
                      const SizedBox(
                        height: 10,
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
              ],
            ),
          );
  }
}
