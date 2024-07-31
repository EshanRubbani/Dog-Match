import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DetailsPageDesktop extends StatefulWidget {
  final String name;
  final String age;
  final String description;
  final String interests;
  final String image;
  final List<dynamic> urls;

  const DetailsPageDesktop({
    Key? key,
    required this.name,
    required this.age,
    required this.description,
    required this.interests,
    required this.image,
    required this.urls,
  }) : super(key: key);

  @override
  _DetailsPageDesktopState createState() => _DetailsPageDesktopState();
}

class _DetailsPageDesktopState extends State<DetailsPageDesktop> {
  @override
  Widget build(BuildContext context) {
     int _currentIndex = 0;
    var localization = AppLocalizations.of(context);
     final List<dynamic> urls1 = [
      "https://w0.peakpx.com/wallpaper/623/426/HD-wallpaper-cute-dog-for-blurry-background-pet-dog-pet-animal.jpg",
        "https://w0.peakpx.com/wallpaper/623/426/HD-wallpaper-cute-dog-for-blurry-background-pet-dog-pet-animal.jpg",
          "https://w0.peakpx.com/wallpaper/623/426/HD-wallpaper-cute-dog-for-blurry-background-pet-dog-pet-animal.jpg",
            "https://w0.peakpx.com/wallpaper/623/426/HD-wallpaper-cute-dog-for-blurry-background-pet-dog-pet-animal.jpg",
     ];
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
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.75,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Stack(
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
                        items: urls1.map((url) {
                          return Container(
                            child: Center(
                              child: Image.network(
                                url,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const CircularProgressIndicator(
                                    color: Colors.red,
                                  );
                                },
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: MediaQuery.of(context).size.height * 0.75,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      Positioned(
                        bottom: 10.0,
                        left: 0.0,
                        right: 0.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: widget.urls.map((url) {
                            int index = widget.urls.indexOf(url);
                            return Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentIndex == index
                                    ? Color.fromRGBO(0, 0, 0, 0.9)
                                    : Color.fromRGBO(0, 0, 0, 0.4),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
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
                    Color.fromARGB(255, 255, 87, 34).withOpacity(0.9),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: "Popins"
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.age,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "localization?.interests ?? ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.interests,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
