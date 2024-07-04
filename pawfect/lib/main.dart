import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawfect/views/Auth/SignUp/signup.dart';
import 'package:pawfect/views/SplashScreen/splashScreen.dart';
import 'package:pawfect/views/home/TabsPage/tabs_page.dart';
import 'package:pawfect/views/Auth/SigninOrSignUp/signUpsignIn.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Lato',
        primarySwatch: Colors.deepOrange,
        brightness: Brightness.light,
      ),
      // home: TabsPage(title: 'tinder',),
      home: SignUp(),
    );
  }
}
