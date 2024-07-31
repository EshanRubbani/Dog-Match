import 'package:DogMatch/Helper/Constants/Colors.dart';
import 'package:DogMatch/Helper/LangController/langcontroller.dart';
import 'package:DogMatch/Helper/Painter/curved_painter.dart';
import 'package:DogMatch/views/Auth/SignIn/signIn.dart';
import 'package:DogMatch/views/Auth/SignUp/signupDesktop%20copy.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';

class ForgotPasswordDesktop extends StatefulWidget {
  const ForgotPasswordDesktop({Key? key}) : super(key: key);

  @override
  _ForgotPasswordDesktopState createState() => _ForgotPasswordDesktopState();
}

class _ForgotPasswordDesktopState extends State<ForgotPasswordDesktop> {
  final TextEditingController emailController = TextEditingController();

  void forgetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
      Get.snackbar("Success", "Password reset email sent successfully. Please check your inbox!");
      Get.to(()=> SignIn());
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     bool isEnglish = Get.locale?.languageCode == 'en';

  void _onLanguageChanged(bool value) {
    setState(() {
      isEnglish = value;
    });
    Get.find<LocalizationController>().changeLanguage(isEnglish ? 'en' : 'el');
  }
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
                          child: Image.asset('assets/logo.png'),
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
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               
                Container(
                  width: 350.0,
                 
                  child:  Text(
                      AppLocalizations.of(context)!.forgotpassword,
                    textAlign: TextAlign.center,
                   style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width / 65,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lato',
                      ),
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  
                  child: Text(
                                          AppLocalizations.of(context)!.forgotpassword1,
                    style:  TextStyle(
                       color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width / 80,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                   width: MediaQuery.of(context).size.width / 3.5,
                  child: TextFormField(
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      labelText: AppLocalizations.of(context)!.email,
                      labelStyle: TextStyle(color: Colors.black,fontFamily: 'Popins',),
                      floatingLabelStyle: TextStyle(color: Colors.black,fontFamily: 'Popins',),
                       fillColor: Colors.white,
                        filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                         borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  height: 70,
                  width: 220,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: KAppColors.primaryColor,
                    ),
                    onPressed: () {
                      if (emailController.text.isNotEmpty) {
                        forgetPassword();
                      }
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Send Email!",
                          style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.outgoing_mail,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
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
