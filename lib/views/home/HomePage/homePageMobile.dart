import 'package:DogMatch/views/Auth/SigninOrSignUp/signUpsignIn.dart';
import 'package:DogMatch/views/home/MatchPage/Match_Page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart'; // Import generated localizations
import 'package:DogMatch/views/home/DetailsPage/details_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Helper/Painter/curved_painter.dart';

class HomePageMobile extends StatefulWidget {
  @override
  _HomePageMobileState createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  int indexPage = 0;
  int indexType = 0;
  int isCurrentItem = 0;
  List<Map<String, dynamic>> images = [];

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  Future<void> fetchImages() async {
    CollectionReference posts = FirebaseFirestore.instance.collection('Posts');
    QuerySnapshot querySnapshot = await posts.get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;

    List<Map<String, dynamic>> fetchedImages = [];
    for (var doc in documents) {
      var data = doc.data() as Map<String, dynamic>;
      List<dynamic> urls = data['urls'];
      if (urls.isNotEmpty) {
        fetchedImages.add({
          'imageUrl': urls[0] as String,
          'name': data['name'] as String,
          'age': data['age'] as String,
          'description': data['description'] as String,
          'interests': data['interests'] as String,
          'urls': urls,
          'ownerID': data['owner'] as String,
        });
      }
    }

    setState(() {
      images = fetchedImages;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            margin: const EdgeInsets.only(bottom: 60),
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                end: Alignment(0.0, 0.4),
                begin: Alignment(0.0, -1),
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
                actionsIconTheme: const IconThemeData(opacity: 0.0),
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
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 42,
                            width: 42,
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Icon(
                              Icons.notifications_none_outlined,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            height: 42,
                            width: 42,
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                FirebaseAuth.instance.signOut();
                                Get.offAll(SignInSignUp());
                              },
                              child: const Icon(
                                Icons.login_outlined,
                                color: Colors.white,
                              ),
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
                     child: images.isEmpty
                        ? Center(
                            child: Text(
                              "No posts yet",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          )
                        :PageView.builder(
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                            child: AspectRatio(
                              aspectRatio: 0.7,
                              child: InkWell(
                                onTap: () {
                                  Get.to(
                                    DetailsPage(
                                      Name: images[index]['name'],
                                      age: images[index]['age'],
                                      descripton: images[index]['description'],
                                      urls: images[index]['urls'],
                                      interests: images[index]['interests'],
                                      image: images[index]['imageUrl'],
                                      ownerID: images[index]['ownerID'],
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height * 0.7,
                                    color: Colors.grey.shade300,
                                    child: buildCardDetails(context, index),
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
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(16, 16, 16, 104),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Container(
          //             height: 64,
          //             width: 64,
          //             margin: const EdgeInsets.fromLTRB(16, 16, 10, 16),
          //             decoration: BoxDecoration(
          //               color: Colors.white,
          //               borderRadius: BorderRadius.circular(100),
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: Colors.black.withOpacity(0.2),
          //                   spreadRadius: 0,
          //                   blurRadius: 4,
          //                   offset: const Offset(0, 4),
          //                 ),
          //               ],
          //             ),
          //             child: IconButton(
          //               onPressed: () {},
          //               icon: const Icon(
          //                 Icons.close_rounded,
          //                 color: Colors.deepOrange,
          //                 size: 28,
          //               ),
          //             ),
          //           ),
          //           Container(
          //             height: 64,
          //             width: 64,
          //             margin: const EdgeInsets.fromLTRB(10, 16, 16, 16),
          //             decoration: BoxDecoration(
          //               gradient: const LinearGradient(
          //                 end: Alignment(0.0, 0.4),
          //                 begin: Alignment(0.0, -1),
          //                 colors: <Color>[
          //                   Colors.pink,
          //                   Colors.deepOrange,
          //                 ],
          //               ),
          //               borderRadius: BorderRadius.circular(100),
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: Colors.black.withOpacity(0.2),
          //                   spreadRadius: 0,
          //                   blurRadius: 4,
          //                   offset: const Offset(0, 4),
          //                 ),
          //               ],
          //             ),
          //             child: IconButton(
          //               onPressed: () {
          //                 final currentImage = images[indexPage];
          //                 Get.to(
          //                   MatchPage(
          //                     name: currentImage['name'],
          //                     age: currentImage['age'],
          //                     description: currentImage['description'],
          //                     interests: currentImage['interests'],
          //                     image: currentImage['imageUrl'],
          //                     urls: currentImage['urls'],
          //                     ownerID: currentImage['ownerID'],
          //                   ),
          //                 );
          //               },
          //               icon: const Icon(
          //                 Icons.favorite_rounded,
          //                 color: Colors.white,
          //                 size: 28,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Column buildCardDetails(BuildContext context, int index) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.7 - 150,
          child: Image.network(
            images[index]['imageUrl'],
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const SizedBox(width: 25),
            const Icon(Icons.pets_outlined, color: Colors.grey, size: 25),
            const SizedBox(width: 5),
            Text(
              images[index]['name'],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Lato",
                color: Colors.black,
              ),
              textAlign: TextAlign.start,
            ),
            const Text(
              " , ",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "lato",
                color: Colors.black,
              ),
            ),
            Text(
              images[index]['age'],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "lato",
                color: Colors.black,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
        Row(
          children: [
            const SizedBox(width: 25),
            Container(
              width: 365,
              height: 49,
              child: Text(
                images[index]['description'],
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  fontFamily: "Poppins",
                  color: Colors.black,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
