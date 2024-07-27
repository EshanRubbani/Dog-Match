import 'package:DogMatch/Helper/Responsive/responsive.dart';
import 'package:DogMatch/views/Auth/ForgetPassword/forgetpass.dart';
import 'package:DogMatch/views/Auth/SignIn/signinDesktop.dart';
import 'package:DogMatch/views/Auth/SignIn/signinMoble.dart';
import 'package:DogMatch/views/Auth/Wrapper/authwrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:DogMatch/Helper/Constants/Colors.dart';
import 'package:DogMatch/Helper/Painter/curved_painter.dart';
import 'package:DogMatch/views/Auth/SignUp/signup.dart';
import 'package:DogMatch/views/home/TabsPage/tabs_page.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ResponsiveNess(mobile: SigninMoble(), desktop: SigninDesktop())
    );
  }

}
