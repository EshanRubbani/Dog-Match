import 'package:DogMatch/Helper/Responsive/responsive.dart';
import 'package:DogMatch/views/Auth/ProfileImageUpload/dpUploadDesktop.dart';
import 'package:DogMatch/views/Auth/ProfileImageUpload/dpUploadMobile.dart';
import 'package:flutter/material.dart';
class DpUpload extends StatelessWidget {
const DpUpload({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: ResponsiveNess(mobile: DpUploadMobile(), desktop: DpUploadDesktop()),
    );
  }
}