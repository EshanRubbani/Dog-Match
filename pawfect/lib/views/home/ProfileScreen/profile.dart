import 'package:DogMatch/Helper/Responsive/responsive.dart';
import 'package:DogMatch/views/home/ProfileScreen/profileDesktop.dart';
import 'package:DogMatch/views/home/ProfileScreen/profileMobile.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
 Profile({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:  ResponsiveNess(
        mobile: ProfileScreenMobile(), desktop: ProfileScreenDesktop(),
      ),
    );
  }
}