// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:DogMatch/Helper/Responsive/responsive.dart';
import 'package:DogMatch/views/chatselection/widgets/chatSelectionDesk.dart';
import 'package:DogMatch/views/chatselection/widgets/chatSelectionMobile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatSelectScreen extends StatefulWidget {
  const ChatSelectScreen({super.key});

  @override
  State<ChatSelectScreen> createState() => _ChatSelectScreenState();
}

class _ChatSelectScreenState extends State<ChatSelectScreen> {
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
        
        body: const ResponsiveNess(
          mobile: ChatSelectionMobile(),
          desktop: ChatSelectionDesk(),
        ));
  }
}
