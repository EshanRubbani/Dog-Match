import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawfect/views/home/home_page.dart';
import '../../../Helper/Painter/curved_painter.dart';
import '../../home/TabsPage/tabs_page.dart';

class signInsignUp extends StatefulWidget {
  @override
  _signInsignUpState createState() => _signInsignUpState();
}

class _signInsignUpState extends State<signInsignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.20,
            margin: const EdgeInsets.only(bottom: 60),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                end: const Alignment(0.0, 0.4),
                begin: const Alignment(0.0, -1),
                colors: <Color>[
                  Colors.pink,
                  const Color.fromARGB(255, 255, 87, 34).withOpacity(0.9)
                ],
              ),
            ),
          ),
          CustomPaint(
            size: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.20,
            ),
            painter: CurvedPainter(),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                const SizedBox(
                  height: 180,
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.4 - 100,
                    child: Container(
                        height: 400,
                        width: 150,
                        child: Image.asset('assets/icons/gif/pets.gif'))),
                Container(
                  height: 75,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                      child: Text(
                    "Pawfect",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lato'),
                  )),
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width / 2 + 80,
                            height: 60,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 255, 87, 34)
                                            .withOpacity(0.6),
                                    elevation: 15.0),
                                onPressed: () {},
                                child: const Text(
                                  "Sign up",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Popins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ))),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width / 2 + 80,
                            height: 60,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 87, 34)
                                          .withOpacity(0.6),
                                  elevation: 15.0),
                              onPressed: () {Get.to(TabsPage(title: 'tinder',));},
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Popins',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: const Text(
                            "OR",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Popins',
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width / 2 + 80,
                            height: 60,
                          child: ElevatedButton(
                            
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 87, 34)
                                        .withOpacity(0.6),
                                elevation: 15.0),
                            onPressed: () {},
                            child: const Text(
                              "Google",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Popins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
