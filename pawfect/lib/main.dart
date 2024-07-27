import 'package:DogMatch/Helper/Constants/Constants.dart';
import 'package:DogMatch/Helper/LangController/langcontroller.dart';
import 'package:DogMatch/views/Auth/SignIn/signIn.dart';
import 'package:DogMatch/views/Auth/SignIn/signinDesktop.dart';
import 'package:DogMatch/views/Auth/SignIn/signinMoble.dart';
import 'package:DogMatch/views/Auth/SignUp/signup.dart';
import 'package:DogMatch/views/Auth/SigninOrSignUp/signUpsigninDesktop.dart';
import 'package:DogMatch/views/Auth/Wrapper/authwrapper.dart';
import 'package:DogMatch/views/SplashScreen/splashScreen.dart';
import 'package:DogMatch/views/home/AddPostPage/add.dart';
import 'package:DogMatch/views/home/TabsPage/tabs_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Import the controller

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final LocalizationController localizationController = Get.put(LocalizationController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Get.deviceLocale,
      debugShowCheckedModeBanner: false,
      title: 'DogMatch',
      theme: ThemeData(
        fontFamily: 'Popins',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        primarySwatch: Colors.deepOrange,
        brightness: Brightness.light,
      ),
      home: _buildHomePage(),
    );
  }

  Widget _buildHomePage() {
    User? currentUser = FirebaseAuth.instance.currentUser;
    return currentUser != null ? TabsPage() : SplashScreen();
  }
}
