import 'package:DogMatch/views/Auth/Wrapper/authwrapper.dart';
import 'package:DogMatch/views/SplashScreen/splashScreen.dart';
import 'package:DogMatch/views/home/TabsPage/tabs_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';  
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
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
    home: _buildHomePage(),
    );


    
  }
    Widget _buildHomePage() {
    // Check if there is a current user logged in
    User? currentUser = FirebaseAuth.instance.currentUser;

    // Return either TabsPage or SplashScreen based on authentication state
    return currentUser != null ? TabsPage() : SplashScreen();
  }
}
