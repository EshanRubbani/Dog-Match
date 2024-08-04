import 'package:DogMatch/views/home/ProfileScreen/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../HomePage/home_page.dart';

class TabsPageMobile extends StatefulWidget {
  @override
  _TabsPageMobileState createState() => _TabsPageMobileState();
}

class _TabsPageMobileState extends State<TabsPageMobile> with SingleTickerProviderStateMixin {
  List<Widget> _tabs = [
    HomePage(),
    Center(child: Icon(Icons.chat_bubble_outline)),
    ProfileScreen(),
  ];

  late TabController _controller;
  int _newIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _controller.addListener(() {
      _newIndex = _controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TabBarView(
            children: _tabs,
            controller: _controller,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width *0.85, // Adjust the width as needed
              height: MediaQuery.of(context).size.height *0.07, // Adjust the height as needed
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTabItem(
                    index: 0,
                    icon: CupertinoIcons.home,
                    label: 'Discover',
                    isSelected: _newIndex == 0,
                  ),
                  _buildTabItem(
                    index: 1,
                    icon: Icons.chat_bubble_outline,
                    label: 'Chat',
                    isSelected: _newIndex == 1,
                  ),
                  _buildTabItem(
                    index: 2,
                    icon: SvgPicture.asset(
                      "assets/icons/svg/user.svg",
                      height: 20,
                      color: Colors.grey,
                    ),
                    label: 'User',
                    isSelected: _newIndex == 2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem({
    required int index,
    required dynamic icon,
    required String label,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _newIndex = index;
          _controller.animateTo(index);
        });
      },
      child: Container(
        height: 50,
        width: 50,
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepOrange.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: icon is IconData
              ? Icon(icon, color: isSelected ? Colors.deepOrange : Colors.grey)
              : icon,
        ),
      ),
    );
  }
}
