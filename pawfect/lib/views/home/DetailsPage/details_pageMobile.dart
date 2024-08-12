import 'package:DogMatch/views/chat/chat_service.dart';
import 'package:DogMatch/views/home/MatchPage/Match_Page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';

class DetailsPageMobile extends StatefulWidget {
  final String Name;
  final String age;
  final String descripton;
  final String interests;
  final String image;
  final String owneremail;
  final List<dynamic> urls;

  const DetailsPageMobile({
    Key? key,
    required this.Name,
    required this.age,
    required this.descripton,
    required this.interests,
    required this.image,
    required this.urls,
    required this.owneremail,
  }) : super(key: key);

  @override
  _DetailsPageMobileState createState() => _DetailsPageMobileState();
}

class _DetailsPageMobileState extends State<DetailsPageMobile> {
  int _selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    final ChatService _chatService = ChatService();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                expandedHeight: MediaQuery.of(context).size.height * 0.60,
                floating: true,
                pinned: true,
                snap: true,
                collapsedHeight: 116,
                actionsIconTheme: const IconThemeData(opacity: 0.0),
                toolbarHeight: 56,
                titleSpacing: 0,
                centerTitle: false,
                leading: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.all(0),
                  title: Container(
                    height: 67,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 2),
                                Text(
                                  widget.Name,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  " , ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.age,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  background: Container(
                    height: MediaQuery.of(context).size.height * 0.50,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 86),
                            child: Image.network(
                              widget.urls[_selectedImageIndex],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 150,
                            margin: const EdgeInsets.only(bottom: 60),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                end: Alignment(0.0, 0.4),
                                begin: Alignment(0.0, -1),
                                colors: [
                                  Colors.transparent,
                                  Colors.black,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 120,
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                            margin: const EdgeInsets.only(bottom: 100),
                            width: double.infinity,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.urls.length +
                                  2, // Include extra items for the padding at start and end
                              itemBuilder: (context, index) {
                                if (index == 0 ||
                                    index == widget.urls.length + 1) {
                                  return const SizedBox(width: 8);
                                }
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedImageIndex = index - 1;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AspectRatio(
                                      aspectRatio: 1.4,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.network(
                                          widget.urls[index - 1],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const Divider(
                      height: 1,
                      thickness: 1,
                      indent: 32,
                      endIndent: 32,
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            localization!.interestsLabel,
                            style: const TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                     Text(
                                  widget.interests,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Description",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                      Center(
                        child: Text(
                          widget.descripton,
                          style: TextStyle(
                            color: Colors.grey[600],
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 64,
                    width: 64,
                    margin: const EdgeInsets.fromLTRB(16, 16, 10, 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Colors.deepOrange,
                        size: 28,
                      ),
                    ),
                  ),
                  FirebaseAuth.instance.currentUser!.email != widget.owneremail
                      ? Container(
                          height: 64,
                          width: 64,
                          margin: const EdgeInsets.fromLTRB(10, 16, 16, 16),
                          decoration: BoxDecoration(
                            gradient: new LinearGradient(
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
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: IconButton(
  onPressed: () async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MatchPage(
          name: widget.Name,
          image: widget.image,
          urls: widget.urls,
          age: widget.age,
          description: widget.descripton,
          interests: widget.interests,
          ownerID: widget.owneremail,
        ),
      ),
    );

    // Assuming you have the userID of the interested profile
    String interestedUserEmail = widget.owneremail; // Replace with the actual user ID

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
    String owneruid = await _chatService.getUserUIDByEmail(widget.owneremail);

    print(widget.owneremail);
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
  icon: const Icon(
    Icons.favorite_rounded,
    color: Colors.white,
    size: 28,
  ),
)

                        )
                      : Container(
                          height: 64,
                          width: 64,
                        )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
