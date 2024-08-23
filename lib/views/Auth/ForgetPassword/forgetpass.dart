import 'package:DogMatch/Helper/Responsive/responsive.dart';
import 'package:DogMatch/views/Auth/ForgetPassword/forgotpassDesktop.dart';
import 'package:DogMatch/views/Auth/ForgetPassword/forgotpassMobile.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: ResponsiveNess(mobile: ForgotPasswordMobile(), desktop: ForgotPasswordDesktop()),
    );
  }
}