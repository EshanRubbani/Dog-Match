import 'package:DogMatch/Helper/Responsive/responsive.dart';
import 'package:DogMatch/views/home/AddPostPage/addDesktop.dart';
import 'package:DogMatch/views/home/AddPostPage/addMobile.dart';
import 'package:flutter/material.dart';


class Add extends StatelessWidget {
const Add({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return const ResponsiveNess(
      desktop: AddDesktop(),
      mobile: AddMobile(),
    );
  }
}