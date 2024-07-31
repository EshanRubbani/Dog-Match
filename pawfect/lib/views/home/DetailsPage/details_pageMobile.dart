import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../MatchPage/match_page.dart';

class DetailsPageMobile extends StatefulWidget {
  final String Name;
  final String age;
  final String descripton;
  final String interests;
  final String image;
  final List<dynamic> urls ;


  const DetailsPageMobile({
    Key? key,
   required this.Name, required this.age, required this.descripton, required this.interests, required this.image, required this.urls,
  }) : super(key: key);


  @override
  _DetailsPageMobileState createState() => _DetailsPageMobileState();
}

class _DetailsPageMobileState extends State<DetailsPageMobile> {
  
  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);

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
                actionsIconTheme: IconThemeData(opacity: 0.0),
                toolbarHeight: 56,
                titleSpacing: 0,
                centerTitle: false,
                leading: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 40,
                    width: 40,
                    margin: EdgeInsets.only(left: 16),
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
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.all(0),
                  title: Container(
                    height: 67,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
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
                                SizedBox(width: 2),
                                Text(
                                  localization!.detailsPageTitle,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Container(
                                  height: 12,
                                  width: 12,
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blue[300],
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                      ),
                                      Center(
                                        child: Icon(
                                          Icons.check,
                                          size: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.pink,
                                  size: 14,
                                ),
                                Text(
                                  localization.locationLabel,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          height: 34,
                          width: 34,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.green[300],
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              Container(
                                height: 18,
                                width: 18,
                                color: Colors.white,
                              ),
                              Center(
                                child: Container(
                                  height: 28,
                                  width: 28,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  '9.2',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                            padding: EdgeInsets.only(bottom: 86),
                            child: Image.network(
                              "https://w0.peakpx.com/wallpaper/623/426/HD-wallpaper-cute-dog-for-blurry-background-pet-dog-pet-animal.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 150,
                            margin: EdgeInsets.only(bottom: 60),
                            width: double.infinity,
                            decoration: new BoxDecoration(
                              gradient: new LinearGradient(
                                end: const Alignment(0.0, 0.4),
                                begin: const Alignment(0.0, -1),
                                colors: <Color>[
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
                            padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                            margin: EdgeInsets.only(bottom: 100),
                            width: double.infinity,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                SizedBox(width: 8),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: AspectRatio(
                                    aspectRatio: 1.4,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        "https://plus.unsplash.com/premium_photo-1667030783942-05351fd6c3fc?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: AspectRatio(
                                    aspectRatio: 1.4,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        "https://plus.unsplash.com/premium_photo-1667673941713-ad4d4751c93b?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: AspectRatio(
                                    aspectRatio: 1.4,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        "https://plus.unsplash.com/premium_photo-1666878155781-f86514e5808b?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                              ],
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
                    Divider(
                      height: 1,
                      thickness: 1,
                      indent: 32,
                      endIndent: 32,
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            localization!.interestsLabel,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            localization.similarLabel,
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(8),
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                            decoration: BoxDecoration(
                              color: Colors.deepOrange.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.shopping_cart_rounded,
                                  color: Colors.deepOrange,
                                  size: 16,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  localization.shoppingInterest,
                                  style: TextStyle(
                                    color: Colors.deepOrange,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(8),
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                            decoration: BoxDecoration(
                              color: Colors.deepOrange.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.library_music,
                                  color: Colors.deepOrange,
                                  size: 16,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  localization.musicInterest,
                                  style: TextStyle(
                                    color: Colors.deepOrange,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(8),
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                            decoration: BoxDecoration(
                              color: Colors.deepOrange.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.local_drink_sharp,
                                  color: Colors.deepOrange,
                                  size: 16,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  localization.coffeeInterest,
                                  style: TextStyle(
                                    color: Colors.deepOrange,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(8),
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.menu_book_rounded,
                                  color: Colors.deepOrange,
                                  size: 16,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  localization.booksInterest,
                                  style: TextStyle(
                                    color: Colors.deepOrange,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(8),
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.airplanemode_active,
                                  color: Colors.deepOrange,
                                  size: 16,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  localization.travelInterest,
                                  style: TextStyle(
                                    color: Colors.deepOrange,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(8),
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.sports_basketball,
                                  color: Colors.deepOrange,
                                  size: 16,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  localization.basketballInterest,
                                  style: TextStyle(
                                    color: Colors.deepOrange,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localization!.description,
                        style: TextStyle(
                          color: Colors.grey[600],
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 800),
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
            ),
          ),
        ],
      ),
    );
  }
}
