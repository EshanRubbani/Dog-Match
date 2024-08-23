import 'package:DogMatch/Helper/Responsive/responsive.dart';
import 'package:DogMatch/views/home/HomePage/homePageDesktop.dart';
import 'package:DogMatch/views/home/HomePage/homePageMobile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: ResponsiveNess(mobile: HomePageMobile(), desktop:  HomePageDesktop()),
    );
  }
}