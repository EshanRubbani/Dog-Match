import 'package:flutter/material.dart';
import 'package:pawfect/Helper/Painter/curved_painter.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                colors: <Color>[Colors.pink, Color(0xFFFF5722)],
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
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 275),
                Container(
                  height: MediaQuery.of(context).size.height - 280,
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Popins',
                            fontSize: 30,
                            fontWeight: FontWeight.w900),
                      ),
                      Container(
                        color: Colors.red,
                        height: 350,
                        width: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            40,
                                    child: TextFormField(
                                      controller: firstNameController,
                                      textInputAction: TextInputAction.next,
                                      onSaved: (firstname) {},
                                      decoration: InputDecoration(
                                        hintText: "First Name",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400]),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    )),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.032,
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            50,
                                    child: TextFormField(
                                      controller: lastNameController,
                                      textInputAction: TextInputAction.next,
                                      onSaved: (lastname) {},
                                      decoration: InputDecoration(
                                        hintText: "Last Name",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400]),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
