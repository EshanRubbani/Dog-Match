import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:pawfect/Helper/Constants/Colors.dart';
import 'package:pawfect/Helper/Painter/curved_painter.dart';
import 'package:pawfect/views/Auth/SignIn/signIn.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
          SingleChildScrollView(
            child: Container(
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
                        Hero(
                          tag: "Sign Up",
                          child: Text(
                            AppLocalizations.of(context)!.register,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Popins',
                                fontSize: 30,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        Container(
                          height: 480,
                          width: double.infinity,
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          40,
                                      child: TextFormField(
                                        controller: firstNameController,
                                        textInputAction: TextInputAction.next,
                                        onSaved: (firstname) {},
                                        decoration: InputDecoration(
                                          hintText: AppLocalizations.of(context)!.firstName,
                                          label: Text(AppLocalizations.of(context)!.firstName),
                                          labelStyle: TextStyle(
                                              color: KAppColors.primaryColor),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      )),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.032,
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          50,
                                      child: TextFormField(
                                        controller: lastNameController,
                                        textInputAction: TextInputAction.next,
                                        onSaved: (lastname) {},
                                        decoration: InputDecoration(
                                          focusColor: KAppColors.secondaryColor,
                                          labelText: AppLocalizations.of(context)!.lastName,
                                          labelStyle: TextStyle(
                                              color: KAppColors.primaryColor),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                              SizedBox(height: 20),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width - 70,
                                  child: TextFormField(
                                    controller: emailController,
                                    textInputAction: TextInputAction.next,
                                    onSaved: (email) {},
                                    decoration: InputDecoration(
                                      focusColor: KAppColors.secondaryColor,
                                      labelText: AppLocalizations.of(context)!.email,
                                      labelStyle: TextStyle(
                                          color: KAppColors.primaryColor),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  )),
                              SizedBox(height: 20),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width - 70,
                                  child: TextFormField(
                                    controller: passwordController,
                                    textInputAction: TextInputAction.next,
                                    onSaved: (password) {},
                                    decoration: InputDecoration(
                                      focusColor: KAppColors.secondaryColor,
                                      labelText: AppLocalizations.of(context)!.password,
                                      labelStyle: TextStyle(
                                          color: KAppColors.primaryColor),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  )),
                              SizedBox(height: 20),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width - 70,
                                  child: TextFormField(
                                    controller: confirmPasswordController,
                                    textInputAction: TextInputAction.next,
                                    onSaved: (cpassword) {},
                                    decoration: InputDecoration(
                                      focusColor: KAppColors.secondaryColor,
                                      labelText: AppLocalizations.of(context)!.confirmPassword,
                                      labelStyle: TextStyle(
                                          color: KAppColors.primaryColor),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  )),
                              SizedBox(height: 30),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.75,
                                height: 60,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromARGB(255, 255, 87, 34)
                                              .withOpacity(0.6),
                                      elevation: 15.0),
                                  onPressed: () {},
                                  child:  Text(
                                    AppLocalizations.of(context)!.register,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Popins',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.alreadyAccount,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Get.to(SignIn());
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!.login,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: KAppColors.primaryColor),
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
