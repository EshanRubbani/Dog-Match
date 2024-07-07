import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawfect/views/Auth/SigninOrSignUp/signUpsignIn.dart';
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
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
     Get.to(SignInSignUp());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            margin: EdgeInsets.only(bottom: 60),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                end: const Alignment(0.0, 0.4),
                begin: const Alignment(0.0, -1),
                colors: <Color>[
                  Colors.pink,
                  Color(0xFFFF5722)
                ],
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
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                const SizedBox(
                  height: 400,
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.4 - 100,
                   child: Image.asset('assets/icons/gif/pets.gif')),
                  
                    Container(
                  height: 75,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
  width: 250.0,
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
          TyperAnimatedText(AppLocalizations.of(context)!.title,textStyle: TextStyle(color: Colors.deepOrange.shade400,fontSize: 35,fontWeight: FontWeight.bold),speed: const Duration(milliseconds: 300),),
          
        ],
        onTap: () {
          print("Tap Event");
        },
      ),
    ),
  ),
)
                ),
                 SizedBox(height: 80,),
              const CircularProgressIndicator(
                          strokeWidth: 5,
                          backgroundColor: Colors.deepOrange,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,)
                        ),
              ],
              
            ),
          ),
        ],
      ),
    );
  }
}
