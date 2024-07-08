import 'package:DogMatch/views/Auth/SigninOrSignUp/signUpsignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';// Import generated localizations

import 'package:DogMatch/views/home/DetailsPage/details_page.dart';
import '../../Helper/Painter/curved_painter.dart';
import 'MatchPage/match_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int indexPage = 0;
  int indexType = 0;
  int isCurrentItem = 0;

  final List<String> images = [
    "https://w0.peakpx.com/wallpaper/623/426/HD-wallpaper-cute-dog-for-blurry-background-pet-dog-pet-animal.jpg",
    "https://images.unsplash.com/photo-1504826260979-242151ee45b7?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1504826260979-242151ee45b7?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  ];

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            margin: EdgeInsets.only(bottom: 60),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                end: const Alignment(0.0, 0.4),
                begin: const Alignment(0.0, -1),
                colors: <Color>[
                  Colors.pink,
                  Color(0xFFFF5722),
                ],
              ),
            ),
          ),
          CustomPaint(
            size: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.31,
            ),
            painter: CurvedPainter(),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: Colors.transparent,
                actionsIconTheme: IconThemeData(opacity: 0.0),
                toolbarHeight: 56,
                titleSpacing: 0,
                centerTitle: false,
                title: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                       FirebaseAuth.instance.currentUser!.email.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 42,
                            width: 42,
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Icon(Icons.notifications_none_outlined, color: Colors.white),
                          ),
                          SizedBox(width: 5,),
                          Container(
                            height: 42,
                            width: 42,
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: GestureDetector(
                              onTap: () {
                              FirebaseAuth.instance.signOut();
                              Get.offAll(SignInSignUp());
                              },
                              child: Icon(Icons.login_outlined, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: PageView.builder(
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                            child: AspectRatio(
                              aspectRatio: 0.7,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsPage(),
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: Image.network(
                                    images[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 104),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 64,
                      width: 64,
                      margin: EdgeInsets.fromLTRB(16, 16, 10, 16),
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
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.close_rounded,
                          color: Colors.deepOrange,
                          size: 28,
                        ),
                      ),
                    ),
                    Container(
                      height: 64,
                      width: 64,
                      margin: EdgeInsets.fromLTRB(10, 16, 16, 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          end: const Alignment(0.0, 0.4),
                          begin: const Alignment(0.0, -1),
                          colors: <Color>[
                            Colors.pink,
                            Colors.deepOrange,
                          ],
                        ),
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
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MatchPage(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.favorite_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
