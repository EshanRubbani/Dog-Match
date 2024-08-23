import 'package:DogMatch/Helper/Constants/Colors.dart';
import 'package:DogMatch/views/Auth/SigninOrSignUp/signUpsignIn.dart';
import 'package:DogMatch/views/home/DetailsPage/details_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class HomePageDesktop extends StatefulWidget {
  const HomePageDesktop({Key? key}) : super(key: key);

  @override
  State<HomePageDesktop> createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> {
  final CardSwiperController controller = CardSwiperController();
  List<Widget> cards = [];
  bool isLoading = true;
  String name = "";

  @override
  void initState() {
    super.initState();
    fetchdata();
    fetchImages();
  }

  Future<void> fetchdata() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("Profiles")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (doc.exists) {
        setState(() {
          name = doc['firstName'];
        });
      } else {
        print("Document does not exist!");
      }
    } catch (e) {
      print("Error fetching document: $e");
    }
  }

 Future<void> fetchImages() async {
  CollectionReference posts = FirebaseFirestore.instance.collection('Posts');
  QuerySnapshot querySnapshot = await posts.get();
  List<QueryDocumentSnapshot> documents = querySnapshot.docs;

  List<Widget> fetchedCards = [];
  for (var doc in documents) {
    var data = doc.data() as Map<String, dynamic>;
    List<dynamic> urls = data['urls'];
    String name = data['name'];
    String age = data['age'];  // 'age' is correctly accessed as a String
    String description = data['description'];
    String interests = data['interests'];
    String owner = data['owner'];  // Correct field name used

    if (urls.isNotEmpty) {
      fetchedCards.add(ExampleCard(
        imageUrl: urls[0] as String,
        name: name,
        age: age,
        description: description,
        interests: interests,
        urls: urls,
        ownerID: owner,  // Make sure to match this with ExampleCard's constructor
      ));
    }
  }

  setState(() {
    cards = fetchedCards;
    isLoading = false;
  });
}

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(),
            Expanded(
              child: Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : Container(
                        width: MediaQuery.of(context).size.width * 0.34,
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: CardSwiper(
                          controller: controller,
                          cardsCount: cards.length,
                          onSwipe: _onSwipe,
                          onUndo: _onUndo,
                          numberOfCardsDisplayed: cards.length,
                          backCardOffset: const Offset(40, 40),
                          padding: const EdgeInsets.all(24.0),
                          cardBuilder: (
                            context,
                            index,
                            horizontalThresholdPercentage,
                            verticalThresholdPercentage,
                          ) =>
                              cards[index],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildHeader() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          const SizedBox(width: 50),
          Text(
            "Welcome $name !",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.019,
              fontWeight: FontWeight.bold,
              fontFamily: "lato",
              color: Colors.white,
            ),
          ),
          const Spacer(),
          buildIcon(Icons.notifications_none_outlined),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Get.offAll(SignInSignUp());
            },
            child: buildIcon(Icons.login_outlined),
          ),
          const SizedBox(width: 50),
        ],
      ),
    );
  }

  Container buildIcon(IconData icon) {
    return Container(
      height: 42,
      width: 42,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Icon(icon, color: Colors.white),
    );
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    return true;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $currentIndex was undone from the ${direction.name}',
    );
    return true;
  }
}

class ExampleCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String age;
  final String description;
  final String interests;
  final List<dynamic> urls;
  final String ownerID;

  ExampleCard({
    required this.imageUrl,
    required this.name,
    required this.age,
    required this.description,
    required this.interests,
    required this.urls,
    required this.ownerID,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(DetailsPage(
          Name: name,
          age: age,
          descripton: description,
          urls: urls,
          interests: interests,
          image: imageUrl,
          ownerID: ownerID,
        ));
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCardImage(),
            buildCardDetails(),
          ],
        ),
      ),
    );
  }

  Container buildCardImage() {
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
      width: 430,
      height: 300,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10), // Curving the edges
          child: Container(
            width: 390,
            height: 260,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              errorBuilder: (context, error, stackTrace) {
                print('Failed to load image: $imageUrl');
                return const Center(child: Text('Failed to load image'));
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Column buildCardDetails() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            const SizedBox(width: 25),
            const Icon(Icons.pets_outlined, color: Colors.grey, size: 25),
            const SizedBox(width: 5),
            Text(
              name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Lato",
                color: KAppColors.darkPrimaryColor,
              ),
              textAlign: TextAlign.start,
            ),
            const Text(
              " , ",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "lato",
                color: KAppColors.darkPrimaryColor,
              ),
            ),
            Text(
              age,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "lato",
                color: KAppColors.darkPrimaryColor,
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
                description,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  fontFamily: "Poppins",
                  color: KAppColors.lightPrimaryColor,
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
