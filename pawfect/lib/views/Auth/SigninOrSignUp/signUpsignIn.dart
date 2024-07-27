import 'package:DogMatch/Helper/Responsive/responsive.dart';
import 'package:DogMatch/views/Auth/SigninOrSignUp/signUpsigninDesktop.dart';
import 'package:DogMatch/views/Auth/SigninOrSignUp/signUpsigninMobile.dart';
import 'package:flutter/material.dart';

class SignInSignUp extends StatefulWidget {
  @override
  _SignInSignUpState createState() => _SignInSignUpState();
}

class _SignInSignUpState extends State<SignInSignUp> {
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: ResponsiveNess(mobile: SignUpsigninMobile(), desktop: SignUpsigninDesktop())    );
  }
}
