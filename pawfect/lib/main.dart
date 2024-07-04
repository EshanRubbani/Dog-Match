import 'package:flutter/material.dart';
import 'package:pawfect/views/home/TabsPage/tabs_page.dart';
import 'package:pawfect/views/onboarding/onnboarding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Lato',
        primarySwatch: Colors.deepOrange,
        brightness: Brightness.light,
      ),
      // home: TabsPage(title: 'tinder',),
      home: onBoarding(),
    );
  }
}
