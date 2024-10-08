
import 'package:flutter/material.dart';

class Profileavator extends StatefulWidget {
  final String profileUrl;
  const Profileavator({ Key? key, required this.profileUrl }) : super(key: key);

  @override
  _ProfileavatorState createState() => _ProfileavatorState();
}

class _ProfileavatorState extends State<Profileavator> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.deepOrange,
      radius: 15,
      foregroundImage:       NetworkImage(widget.profileUrl),

      
    );
  }
}