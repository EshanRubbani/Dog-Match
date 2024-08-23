import 'package:DogMatch/Helper/Responsive/responsive.dart';
import 'package:DogMatch/views/home/ProfileScreen/profile.dart';
import 'package:DogMatch/views/home/TabsPage/tabs_pageDesktop.dart';
import 'package:DogMatch/views/home/TabsPage/tabs_pageMobile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../HomePage/home_page.dart';

class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> with SingleTickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ResponsiveNess(
            mobile: TabsPageMobile(), desktop: TabsPageDesktop())
    );
  }
}