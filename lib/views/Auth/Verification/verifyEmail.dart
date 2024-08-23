import 'package:DogMatch/Helper/Responsive/responsive.dart';
import 'package:DogMatch/views/Auth/Verification/verifyEmailDesktop.dart';
import 'package:DogMatch/views/Auth/Verification/verifyEmailMobile.dart';
import 'package:flutter/material.dart';

class VerifyEmail extends StatelessWidget {
const VerifyEmail({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: ResponsiveNess(mobile: VerifyEmailMobile(), desktop: Verifyemaildesktop()),
    );
  }
}