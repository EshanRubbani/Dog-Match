import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawfect/views/Auth/SignUp/signup.dart';
import 'package:pawfect/views/SplashScreen/splashScreen.dart';
import 'package:pawfect/views/home/TabsPage/tabs_page.dart';
import 'package:pawfect/views/Auth/SigninOrSignUp/signUpsignIn.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';  

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale('en'),
      debugShowCheckedModeBanner: false,
      title: 'DogMatch',
      theme: ThemeData(
        fontFamily: 'Popins',
        primarySwatch: Colors.deepOrange,
        brightness: Brightness.light,
      ),
      // home: TabsPage(title: 'tinder',),
      home: SplashScreen(),
    );
  }
}
