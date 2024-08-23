// import 'package:DogMatch/views/SplashScreen/splashScreen.dart';
// import 'package:DogMatch/views/home/TabsPage/tabs_page.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class Authwrapper extends StatefulWidget {
//   const Authwrapper({Key? key}) : super(key: key);

//   @override
//   State<Authwrapper> createState() => _AuthwrapperState();
// }

// class _AuthwrapperState extends State<Authwrapper> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: StreamBuilder(
//             stream: FirebaseAuth.instance.idTokenChanges(),
//             builder: (context, snapshot) {
//               print("inside auth wrapper");
//               if(snapshot.hasData){
//                   print("has data sending to tabspage");
//                 return TabsPage();
//               }
//               else{

//                   print("no data sending to splash");
//                 return SplashScreen();
//               }
//             }));
//   }
// }
