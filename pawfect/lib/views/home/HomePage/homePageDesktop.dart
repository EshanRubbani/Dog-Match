import 'package:DogMatch/Helper/Constants/Colors.dart';
import 'package:DogMatch/views/Auth/SigninOrSignUp/signUpsignIn.dart';
import 'package:DogMatch/views/home/DetailsPage/details_page.dart';
import 'package:DogMatch/views/home/MatchPage/match_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  @override
  void initState() {
    super.initState();
    fetchImages();
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
      String age = data['age'];
      String description = data['description'];
      String interests = data['interests'];

      if (urls.isNotEmpty) {
        fetchedCards.add(ExampleCard(
          imageUrl: urls[0] as String,
          name: name,
          age: age,
          description: description,
          interests: interests,
          urls: urls,
        ));
      }
    }

    setState(() {
      cards = fetchedCards;
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
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  SizedBox(width: 50),
                  Text(
                    "Welcome ${FirebaseAuth.instance.currentUser!.email.toString()}! ",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.019,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 42,
                    width: 42,
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(Icons.notifications_none_outlined,
                        color: Colors.white),
                  ),
                  SizedBox(width: 10),
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
                  SizedBox(width: 50),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.34,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: cards.isNotEmpty
                      ? CardSwiper(
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
                        )
                      : Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    onPressed: controller.undo,
                    child: const Icon(Icons.rotate_left),
                  ),
                  FloatingActionButton(
                    onPressed: () => controller.swipe(CardSwiperDirection.left),
                    child: const Icon(Icons.keyboard_arrow_left),
                  ),
                  FloatingActionButton(
                    onPressed: () =>
                        controller.swipe(CardSwiperDirection.right),
                    child: const Icon(Icons.keyboard_arrow_right),
                  ),
                  FloatingActionButton(
                    onPressed: () => controller.swipe(CardSwiperDirection.top),
                    child: const Icon(Icons.keyboard_arrow_up),
                  ),
                  FloatingActionButton(
                    onPressed: () =>
                        controller.swipe(CardSwiperDirection.bottom),
                    child: const Icon(Icons.keyboard_arrow_down),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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

  ExampleCard({
    required this.imageUrl,
    required this.name,
    required this.age,
    required this.description,
    required this.interests,
    required this.urls,
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
        ));
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Container(
                width: 430,
                height: 300,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  errorBuilder: (context, error, stackTrace) {
                    print('Failed to load image: $imageUrl');
                    return Center(child: Text('Failed to load image'));
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
            Row(
              children: [
                SizedBox(width: 10),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                    color:KAppColors.darkPrimaryColor,
                  ),
                  textAlign: TextAlign.start,
                ),
                Text(" , ",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                    color:KAppColors.darkPrimaryColor,
                  ),),
                Text(
                  age,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                     color:KAppColors.darkPrimaryColor,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
             Row(
               children: [
                 SizedBox(width: 10),
                 Text(
                      description ,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        fontFamily: "Poppins",
                        color:KAppColors.lightPrimaryColor,
                      ),
                      textAlign: TextAlign.start,
                    ),
               ],
             ),
          ],
        ),
      ),
    );
  }
}
