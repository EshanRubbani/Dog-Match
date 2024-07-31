import 'package:DogMatch/Helper/Constants/Colors.dart';
import 'package:DogMatch/Helper/Painter/curved_painter.dart';
import 'package:DogMatch/views/Auth/SignIn/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';

class ForgotPasswordMobile extends StatefulWidget {
  const ForgotPasswordMobile({Key? key}) : super(key: key);

  @override
  _ForgotPasswordMobileState createState() => _ForgotPasswordMobileState();
}

class _ForgotPasswordMobileState extends State<ForgotPasswordMobile> {
  final TextEditingController emailController = TextEditingController();

  void forgetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
      Get.snackbar("Success", "Password reset email sent successfully. Please check your inbox!");
      Get.to(()=> SignIn());
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                end: const Alignment(0.0, 0.4),
                begin: const Alignment(0.0, -1),
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                const SizedBox(height: 10),
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Container(
                    width: 400.0,
                    child: Text(
                      "Enter your email and we'll send you a link to reset your password",
                      style: const TextStyle(
                        color: KAppColors.mediumPrimaryColor,
                        fontSize: 18,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 70,
                  child: TextFormField(
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      focusColor: KAppColors.secondaryColor,
                      labelText: AppLocalizations.of(context)!.email,
                      labelStyle: TextStyle(color: KAppColors.primaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 70,
                  width: 220,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: KAppColors.primaryColor,
                    ),
                    onPressed: () {
                      if (emailController.text.isNotEmpty) {
                        forgetPassword();
                      }
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Send Email!",
                          style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.outgoing_mail,
                          color: Colors.white,
                        ),
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
