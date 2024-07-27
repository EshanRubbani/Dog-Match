import 'package:DogMatch/views/Auth/ProfileImageUpload/dpUpload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:DogMatch/Helper/Constants/Colors.dart';
import 'package:DogMatch/views/Auth/SignIn/signIn.dart';

class SignupDesktop extends StatefulWidget {
  const SignupDesktop({Key? key}) : super(key: key);

  @override
  _SignupDesktopState createState() => _SignupDesktopState();
}

class _SignupDesktopState extends State<SignupDesktop> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool _obscureText = true;
   bool _obscureText1 = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

   void _togglePasswordVisibility1() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 1.7,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icons/gif/pets.gif',
                  height: MediaQuery.of(context).size.height * 0.6),
              const SizedBox(height: 30),
              Text(
                AppLocalizations.of(context)!.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 450,
                child: Text(
                  AppLocalizations.of(context)!.descriptionApp,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato',
                  ),
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
                  const Color.fromARGB(255, 255, 87, 34).withOpacity(0.9)
                ],
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        height: 100,
                        width: 350,
                        child: Hero(
                          tag: "Sign Up",
                          child: Text(
                            AppLocalizations.of(context)!.signup,
                            textAlign: TextAlign.center,
                            style:  TextStyle(
                                color: Colors.white,
                                fontFamily: 'Popins',
                                fontSize: MediaQuery.of(context).size.width / 70,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                      
                      Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                           
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 7 -
                                      15,
                                  child: TextFormField(
                                    controller: firstNameController,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)!
                                          .firstName,
                                      label: Text(AppLocalizations.of(context)!
                                          .firstName),
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 25),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 7 -
                                      15,
                                  child: TextFormField(
                                    controller: lastNameController,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      focusColor: KAppColors.secondaryColor,
                                      labelText: AppLocalizations.of(context)!
                                          .lastName,
                                      labelStyle: TextStyle(color: Colors.black),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 3.5,
                              child: TextFormField(
                                controller: emailController,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  focusColor: KAppColors.secondaryColor,
                                  labelText:
                                      AppLocalizations.of(context)!.email,
                                 labelStyle: TextStyle(color: Colors.black),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 3.5,
                              child: TextFormField(
                                controller: passwordController,
                                textInputAction: TextInputAction.done,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.black,
                                    ),
                                    onPressed: _togglePasswordVisibility,
                                  ),
                                  labelText:
                                      AppLocalizations.of(context)!.password,
                                  labelStyle:
                                      const TextStyle(color: Colors.black),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 3.5,
                              child: TextFormField(
                                controller: confirmPasswordController,
                                textInputAction: TextInputAction.next,
                                
                                decoration: InputDecoration(
                                  focusColor: KAppColors.secondaryColor,
                                  labelText: AppLocalizations.of(context)!
                                      .confirmPassword,
                                  labelStyle: TextStyle(color: Colors.black),
                                   suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureText1
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.black,
                                    ),
                                    onPressed: _togglePasswordVisibility1,
                                  ),
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
                              width: MediaQuery.of(context).size.width / 3.5,
                              height: 60,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 87, 34)
                                          .withOpacity(0.6),
                                  elevation: 15.0,
                                ),
                                onPressed: () {
                                  if (passwordController.text ==
                                          confirmPasswordController.text &&
                                      emailController.text.isNotEmpty) {
                                    signUp(
                                      firstNameController.text,
                                      lastNameController.text,
                                      emailController.text,
                                      passwordController.text,
                                    );
                                  }
                                },
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
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.alreadyAccount,
                                  
                                  style: const TextStyle(fontSize: 18,color: Colors.white),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.to(SignIn());
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.login,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color:Colors.black  ,
                                    ),
                                  ),
                                ),
                              ],
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
        ),
      ],
    );
  }

  void signUp(String fname, String lname, String email, String password) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.orangeAccent.shade400,
        ),
      ),
    );

    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        await FirebaseFirestore.instance
            .collection('Profiles')
            .doc(userCredential.user!.uid)
            .set({
          'firstName': fname,
          'lastName': lname,
        });
        Navigator.of(context).pop();
        Get.snackbar("Success", "Account has been successfully created");
        Get.offAll(() => const DpUpload());
      } else {
        Navigator.of(context).pop();
        Get.snackbar("Error", "Account creation failed");
      }
    } catch (e) {
      Navigator.of(context).pop();
      Get.snackbar("Error", e.toString());
    }
  }
}
