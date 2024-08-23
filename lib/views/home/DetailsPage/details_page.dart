import 'package:DogMatch/Helper/Responsive/responsive.dart';
import 'package:DogMatch/views/home/DetailsPage/details_pageDesktop.dart';
import 'package:DogMatch/views/home/DetailsPage/details_pageMobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../MatchPage/Match_Page_Desktop.dart';

class DetailsPage extends StatefulWidget {
  final String Name;
  final String age;
  final String descripton;
  final String interests;
  final String image;
  final String ownerID;
  final List<dynamic> urls;

  const DetailsPage({
    Key? key,
    required this.Name,
    required this.age,
    required this.descripton,
    required this.interests,
    required this.image,
    required this.urls, required this.ownerID,
  }) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveNess(
          mobile: DetailsPageMobile(
              
              Name: widget.Name,
              age: widget.age,
              descripton: widget.descripton,
              interests: widget.interests,
              image: widget.image,
              urls: widget.urls,  owneremail: widget.ownerID,),
          desktop: DetailsPageDesktop(name: widget.Name,
              age: widget.age,
              description: widget.descripton,
              interests: widget.interests,
              image: widget.image,
              urls: widget.urls, owner: widget.ownerID,
              )),
    );
  }
}
