import 'package:DogMatch/Helper/Constants/Colors.dart';
import 'package:DogMatch/views/chat/chatpage.dart';
import 'package:DogMatch/views/home/TabsPage/tabs_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';

class MatchPageMobile extends StatefulWidget {
  final String image;
  final List<dynamic> urls;
  final String name;
  final String owner;


  const MatchPageMobile({
    Key? key,
    required this.image,
    required this.urls,
    required this.name, required this.owner,
  }) : super(key: key);

  @override
  _MatchPageMobileState createState() => _MatchPageMobileState();
}

class _MatchPageMobileState extends State<MatchPageMobile> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);

    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          end: Alignment(0.0, 0.4),
          begin: Alignment(0.0, -1),
          colors: <Color>[
            Colors.pink,
            Colors.deepOrange,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
          const SizedBox(height: 20),
          buildmatch(context),
        ],
      ),
    ));
  }

  Container buildmatch(BuildContext context) {
    return Container(
        child: Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        const Text(
          "It's a match!",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Lato",
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "You have liked ${widget.name}.",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Lato",
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Send Message to get in touch",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Lato",
            color: Colors.black,
          ),
        ),

         
         SizedBox(height: 15,),
          GestureDetector(
            onTap: (){
              Get.to(Chatpage(receiverEmail: widget.owner));
            },
            child: Container(
              height: 56,
              width: 350,
             
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Center(
                child: Text(
                  "Send Message !",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Container(
            height: 56,
            width: 350,
           
            decoration: BoxDecoration(
               color: Colors.white,
              borderRadius: BorderRadius.circular(100),
            ),
            child: InkWell(
              onTap: () {
                Get.to(TabsPage());
              },
              child: const Center(
                child: Text(
                  "Keep Swiping !",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
      ],
    ));
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
}
