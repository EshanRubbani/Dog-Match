import 'package:DogMatch/Helper/Constants/Colors.dart';
import 'package:DogMatch/views/chat/chat_service.dart';
import 'package:DogMatch/views/home/MatchPage/Match_Page.dart';
import 'package:DogMatch/views/home/MatchPage/Match_Page_Desktop.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

class DetailsPageDesktop extends StatefulWidget {
  final String name;
  final String age;
  final String description;
  final String interests;
  final String image;
  final List<dynamic> urls;
  final String owner;


  const DetailsPageDesktop({
    Key? key,
    required this.name,
    required this.age,
    required this.description,
    required this.interests,
    required this.image,
    required this.urls, required this.owner,
  }) : super(key: key);

  @override
  _DetailsPageDesktopState createState() => _DetailsPageDesktopState();
}

class _DetailsPageDesktopState extends State<DetailsPageDesktop> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
        final ChatService _chatService = ChatService();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 1.7,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    pauseAutoPlayOnTouch: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  items: widget.urls.map((url) {
                    return buildImg(context, url);
                  }).toList(),
                ),
                SizedBox(height: 20),
                FirebaseAuth.instance.currentUser!.email != widget.owner?
                Container(
                  height: 80,
                  width: 280,
                  child: CircleAvatar(
                    
                      child: IconButton(
                    onPressed: () async {
                      Get.to(MatchPage(
                        
                        age: widget.age,
                        description: widget.description,
                        interests: widget.interests,
                        name: widget.name,
                        image: widget.image,
                        urls: widget.urls, ownerID: widget.owner,
                      ));
                          // Assuming you have the userID of the interested profile
    String interestedUserEmail = widget.owner; // Replace with the actual user ID

    // Get the current user's UID
    String currentUserID = FirebaseAuth.instance.currentUser!.uid;

    // Reference to the current user's profile document
    DocumentReference userDoc = FirebaseFirestore.instance.collection('Profiles').doc(currentUserID);

    // Update the 'interestedProfiles' array with the new interested user ID
    await userDoc.update({
      'interestedProfiles': FieldValue.arrayUnion([interestedUserEmail]),
    }).then((_) {
      print("Interested profile added successfully!");
    }).catchError((error) {
      print("Failed to add interested profile: $error");
    });

    // Add liked me to the owner's document
    String owneruid = await _chatService.getUserUIDByEmail(widget.owner);

    print(widget.owner);
    print(owneruid);

    DocumentReference userDoc1 = FirebaseFirestore.instance.collection('Profiles').doc(owneruid);

    // Update the 'likedme' array with the new interested user ID
    await userDoc1.update({
      'likedme': FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.email]),
    }).then((_) {
      print("LIKED ME profile added successfully!");
    }).catchError((error) {
      print("Failed to add LIKED ME profile: $error");
    });
                    },
                    icon: Icon(Icons.favorite_border_rounded,
                        color: KAppColors.darkPrimaryColor),
                  )),
                ): Container(),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.pink,
                    const Color.fromARGB(255, 255, 87, 34).withOpacity(0.9),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: buildsideDetails(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column buildsideDetails() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Pet Name",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: "lato"),
        ),
        const SizedBox(height: 10),
        Container(
          height: 40,
          width: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              widget.name,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: KAppColors.lightPrimaryColor,
                  fontFamily: "lato"),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Pet Age",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: "lato"),
        ),
        const SizedBox(height: 10),
        Container(
          height: 40,
          width: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              widget.age,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: KAppColors.lightPrimaryColor,
                  fontFamily: "lato"),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Pet Interests",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: "lato"),
        ),
        const SizedBox(height: 10),
        Container(
          height: 40,
          width: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              widget.interests,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: KAppColors.lightPrimaryColor,
                  fontFamily: "lato"),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Description",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: "lato"),
        ),
        const SizedBox(height: 10),
        Container(
          constraints: BoxConstraints(
            minHeight: 40,
            minWidth: 350,
            maxWidth: 350,
            maxHeight: 100,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              widget.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: KAppColors.lightPrimaryColor,
                  fontFamily: "lato"),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

Container buildImg(BuildContext context, String url) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    width: 280,
    height: 380,
    child: Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10), // Curving the edges
        child: Container(
          width: 260,
          height: 360,
          child: Image.network(
            url,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Text('Failed to load image'));
            },
          ),
        ),
      ),
    ),
  );
}
