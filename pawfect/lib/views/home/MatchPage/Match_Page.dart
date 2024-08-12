import 'package:DogMatch/Helper/Responsive/responsive.dart';
import 'package:DogMatch/views/home/MatchPage/Match_Page_Desktop.dart';
import 'package:DogMatch/views/home/MatchPage/Match_Page_Mobile.dart';
import 'package:flutter/material.dart';

class MatchPage extends StatefulWidget {
  final String name;
  final String age;
  final String description;
  final String interests;
  final String image;
  final String ownerID;
  final List<dynamic> urls;
  const MatchPage(
      {Key? key,
      required this.name,
      required this.age,
      required this.description,
      required this.interests,
      required this.image,
      required this.urls, required this.ownerID})
      : super(key: key);

  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveNess(
      desktop: MatchPageDesktop(
        
        image: widget.image,
        urls: widget.urls,
        name: widget.name, owner: widget.ownerID,
      ),
      mobile: MatchPageMobile(
        image: widget.image,
        urls: widget.urls,
        name: widget.name, owner: widget.ownerID,
      ),
    );
  }
}
