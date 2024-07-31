import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:DogMatch/views/Auth/SigninOrSignUp/signUpsignIn.dart';
import '../../Helper/Painter/curved_painter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class SplashScreenMobile extends StatefulWidget {
  @override
  _SplashScreenMobileState createState() => _SplashScreenMobileState();
}

class _SplashScreenMobileState extends State<SplashScreenMobile> {
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 600;
          return Stack(
            children: [
              Container(
                height: isDesktop ? constraints.maxHeight * 0.3 : constraints.maxHeight * 0.4,
                margin: EdgeInsets.only(bottom: isDesktop ? 60 : 40),
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
                  constraints.maxWidth,
                  isDesktop ? constraints.maxHeight * 0.31 : constraints.maxHeight * 0.4,
                ),
                painter: CurvedPainter(),
              ),
              Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isDesktop)
                      SizedBox(
                        height: constraints.maxHeight * 0.3,
                      ),
                    Container(
                      width: constraints.maxWidth,
                      height: isDesktop ? constraints.maxHeight * 0.4 - 100 : constraints.maxHeight * 0.3 - 100,
                      child: Image.asset('assets/logo.png'),
                    ),
                    Container(
                      height: 75,
                      width: constraints.maxWidth,
                      child: Container(
                        width: isDesktop ? 350.0 : 250.0,
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
                                      fontSize: isDesktop ? 45 : 35,
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
                      height: isDesktop ? 100 : 80,
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
            ],
          );
        },
      ),
    );
  }
}
