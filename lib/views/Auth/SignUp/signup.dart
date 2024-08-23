import 'package:DogMatch/Helper/Responsive/responsive.dart';
import 'package:DogMatch/views/Auth/ProfileImageUpload/dpUpload.dart';
import 'package:DogMatch/views/Auth/SignUp/signupDesktop.dart';
import 'package:DogMatch/views/Auth/SignUp/signupMobile.dart';
import 'package:DogMatch/views/Auth/SigninOrSignUp/signUpsigninDesktop.dart';
import 'package:DogMatch/views/Auth/SigninOrSignUp/signUpsigninMobile.dart';
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

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveNess(mobile: SignUpMobile(), desktop: SignupDesktop()),
    );
  }
}
