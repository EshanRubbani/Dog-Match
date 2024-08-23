import 'package:DogMatch/Helper/Responsive/responsive.dart';
import 'package:DogMatch/views/Auth/ProfileImageUpload/dpUploadDesktop.dart';
import 'package:DogMatch/views/Auth/ProfileImageUpload/dpUploadMobile.dart';
import 'package:flutter/material.dart';

class DpUpload extends StatelessWidget {
  final String fname;
  final String lname;

  const DpUpload({Key? key, required this.fname, required this.lname})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveNess(
        mobile: DpUploadMobile(fname: fname, lname: lname),
        desktop: DpUploadDesktop(),
      ),
    );
  }
}
