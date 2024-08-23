import 'package:DogMatch/Helper/LangController/langcontroller.dart';
import 'package:DogMatch/views/SplashScreen/splashScreen.dart';
import 'package:DogMatch/views/home/AddPostPage/add.dart';
import 'package:DogMatch/views/home/MatchPage/Match_Page_Desktop.dart';
import 'package:DogMatch/views/home/TabsPage/tabs_page.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Import the controller
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
    // argument for `webProvider`
    webProvider: ReCaptchaV3Provider('6Lf79i0qAAAAAEhi9LBXPpVsrrcmbclszodrYm2A'),
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Safety Net provider
    // 3. Play Integrity provider
    androidProvider: AndroidProvider.playIntegrity,
   
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
      title: 'Dog Match V1',
      theme: ThemeData(
        fontFamily: 'Popins',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        primarySwatch: Colors.deepOrange,
        brightness: Brightness.light,
      ),
      home: _buildHomePage(),
      // home: Add(),
    );
  }

  Widget _buildHomePage() {
    User? currentUser = FirebaseAuth.instance.currentUser;
    return currentUser != null ? TabsPage() : SplashScreen();
  }
}
