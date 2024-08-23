import 'package:DogMatch/views/Auth/ForgetPassword/forgetpass.dart';
import 'package:DogMatch/views/Auth/SignUp/signup.dart';
import 'package:DogMatch/views/home/TabsPage/tabs_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class SigninDesktop extends StatefulWidget {
  SigninDesktop({Key? key}) : super(key: key);

  @override
  State<SigninDesktop> createState() => _SigninDesktopState();
}

class _SigninDesktopState extends State<SigninDesktop> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
              Image.asset('assets/logo.png', height: MediaQuery.of(context).size.height * 0.6),
              SizedBox(height: 30),
              Text(
                AppLocalizations.of(context)!.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: 450,
                child: Text(
                  AppLocalizations.of(context)!.descriptionApp,
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
                children: [
                  Container(
                     height: 100,
                        width: 350,
                    child: Text(
                      AppLocalizations.of(context)!.signinsingup,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width / 70,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lato',
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3.5,
                    child: TextFormField(
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.email,
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
                  SizedBox(height: 30),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3.5,
                    child: TextFormField(
                      controller: passwordController,
                      textInputAction: TextInputAction.done,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText ? Icons.visibility : Icons.visibility_off,
                            color: Colors.black,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                        labelText: AppLocalizations.of(context)!.password,
                        labelStyle: TextStyle(color: Colors.black),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3.5,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 87, 34).withOpacity(0.6),
                        elevation: 15.0,
                      ),
                      onPressed: () => signIn(context, emailController.text, passwordController.text),
                      child: Text(
                        AppLocalizations.of(context)!.login,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Popins',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.noAccount,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () => Get.to(SignUp()),
                        child: Text(
                          AppLocalizations.of(context)!.register,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Popins',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.forgot,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () => Get.to(() => ForgotPassword()),
                        child: Text(
                          AppLocalizations.of(context)!.reset,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Popins',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void signIn(BuildContext context, String email, String password) async {
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
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pop();
      Get.to(TabsPage());
      Get.snackbar("Success", "Logged in successfully");
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      Get.snackbar("Error", e.message ?? "An error occurred");
    }
  }
}
