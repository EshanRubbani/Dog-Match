import 'package:DogMatch/Helper/Responsive/responsive.dart';
import 'package:DogMatch/views/SplashScreen/splashScreenMobile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:DogMatch/views/Auth/SigninOrSignUp/signUpsignIn.dart';
import '../../Helper/Painter/curved_painter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class SplashScreenDesktop extends StatefulWidget {
  const SplashScreenDesktop({Key? key}) : super(key: key);

  @override
  _SplashScreenDesktopState createState() => _SplashScreenDesktopState();
}

class _SplashScreenDesktopState extends State<SplashScreenDesktop> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Get.to(SignInSignUp());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           
             Container(
              height: 300,
              width: 450,
             
      
              child:  Image.asset('assets/logo.png',filterQuality: FilterQuality.high,),
            ),
            Container(
              height: 75,
              child: Container(
                width: 350,
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'Popins',
                  ),
                  child: Center(
                    child: AnimatedTextKit(
                      repeatForever: false,
                      isRepeatingAnimation: false,
                      animatedTexts: [
                        TyperAnimatedText(
                          AppLocalizations.of(context)!.title,
                          textStyle: TextStyle(
                              color: Colors.deepOrange.shade400,
                              fontSize: 45,
                              fontWeight: FontWeight.bold),
                          speed: const Duration(milliseconds: 300),
                        ),
                      ],
                      onTap: () {
                        print("Tap Event");
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            const CircularProgressIndicator(
                strokeWidth: 5,
                backgroundColor: Colors.deepOrange,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
