import 'package:DogMatch/Helper/Constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:DogMatch/Helper/LangController/langcontroller.dart';
import 'package:DogMatch/views/Auth/SignIn/signIn.dart';
import 'package:DogMatch/views/Auth/SignUp/signup.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class SignUpsigninDesktop extends StatefulWidget {
  const SignUpsigninDesktop({Key? key}) : super(key: key);

  @override
  State<SignUpsigninDesktop> createState() => _SignUpsigninDesktopState();
}

class _SignUpsigninDesktopState extends State<SignUpsigninDesktop> {
  bool isEnglish = Get.locale?.languageCode == 'en';

  void _onLanguageChanged(bool value) {
    setState(() {
      isEnglish = value;
    });
    Get.find<LocalizationController>().changeLanguage(isEnglish ? 'en' : 'el');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.7,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width / 2,
                    margin: const EdgeInsets.only(top: 5),
                   
                    child: Row(
                      
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          isEnglish ? 'Greek' : 'English',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(width: 10),
                        Switch(
                          value: isEnglish,
                          onChanged: _onLanguageChanged,

                          
                        ),
                        SizedBox(width: 10),
                        Text(
                          isEnglish ? 'English' : 'Greek',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.6 - 30,
                          width: MediaQuery.of(context).size.width / 2,
                          child: Image.asset('assets/icons/gif/pets.gif'),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.title,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Lato',
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: 100,
                                width: 450,
                                child: Text(
                                  AppLocalizations.of(context)!.descriptionApp,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Lato',
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    end: const Alignment(0.0, 0.4),
                    begin: const Alignment(0.0, -1),
                    colors: <Color>[
                      Colors.pink,
                      const Color.fromARGB(255, 255, 87, 34).withOpacity(0.9),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 350,
                      child: Text(
                        AppLocalizations.of(context)!.signinsingup,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width / 70 + 5,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lato',
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3.5,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 255, 87, 34).withOpacity(0.6),
                          elevation: 15.0,
                        ),
                        onPressed: () {
                          Get.to(() => SignUp());
                        },
                        child: Hero(
                          tag: "SignUp",
                          child: Text(
                            AppLocalizations.of(context)!.register,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Popins',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Hero(
                      tag: "SignIn",
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3.5,
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 255, 87, 34).withOpacity(0.6),
                            elevation: 15.0,
                          ),
                          onPressed: () {
                            Get.to(() => SignIn());
                          },
                          child: Text(
                            AppLocalizations.of(context)!.login,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Popins',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: Text(
                        AppLocalizations.of(context)!.or,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Popins',
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3.5,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 255, 87, 34).withOpacity(0.6),
                          elevation: 15.0,
                        ),
                        onPressed: () {
                          // Add Google sign-in functionality here
                        },
                        child: const Text(
                          "Google", // Replace with localized string if available
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Popins',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
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
    );
  }
}
