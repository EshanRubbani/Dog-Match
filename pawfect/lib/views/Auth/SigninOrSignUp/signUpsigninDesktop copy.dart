import 'package:flutter/material.dart';
import 'package:DogMatch/Helper/LangController/langcontroller.dart';
import 'package:get/get.dart';
import 'package:DogMatch/views/Auth/SignIn/signIn.dart';
import 'package:DogMatch/views/Auth/SignUp/signup.dart';
import '../../../Helper/Painter/curved_painter.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class SignUpsigninDesktop extends StatelessWidget {
  const SignUpsigninDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocalizationController localizationController = Get.find();

    return Stack(
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
                  child: Image.asset('assets/icons/gif/pets.gif'),
                ),
              ),
              Container(
                height: 75,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        AppLocalizations.of(context)!.title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lato',
                        ),
                      ),
                    ),
                    Center(
                      child: DropdownButton<String>(
                        value: Get.locale?.languageCode ?? 'en',
                        items: [
                          const DropdownMenuItem(
                              value: 'en', child: Text('English')),
                          const DropdownMenuItem(
                              value: 'el', child: Text('Greek')),
                        ],
                        onChanged: (String? value) {
                          if (value != null) {
                            localizationController.changeLanguage(value);
                          }
                        },
                      ),
                    ),
                  ],
                ),
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
                            elevation: 15.0,
                          ),
                          onPressed: () {
                            Get.to(SignUp());
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
                          width: MediaQuery.of(context).size.width / 2 + 80,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 87, 34)
                                      .withOpacity(0.6),
                              elevation: 15.0,
                            ),
                            onPressed: () {
                              Get.to(SignIn());
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
                            color: Colors.black,
                            fontFamily: 'Popins',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
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
                            elevation: 15.0,
                          ),
                          onPressed: () {},
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
      ],
    );
  }
}
