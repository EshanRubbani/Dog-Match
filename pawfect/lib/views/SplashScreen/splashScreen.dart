import 'package:DogMatch/Helper/Responsive/responsive.dart';
import 'package:DogMatch/views/SplashScreen/SplashScreenDesktop.dart';
import 'package:DogMatch/views/SplashScreen/splashScreenMobile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:DogMatch/views/Auth/SigninOrSignUp/signUpsignIn.dart';
import '../../Helper/Painter/curved_painter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(seconds: 5), () {
    //   Get.to(SignInSignUp());
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveNess(mobile: SplashScreenMobile(), desktop: SplashScreenDesktop()),
    );
  }
}
