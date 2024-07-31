import 'dart:typed_data';
import 'package:DogMatch/Helper/Constants/Colors.dart';
import 'package:DogMatch/Helper/LangController/langcontroller.dart';
import 'package:DogMatch/Helper/Painter/curved_painter.dart';
import 'package:DogMatch/views/Auth/Verification/verifyEmail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class DpUploadDesktop extends StatefulWidget {
  const DpUploadDesktop({Key? key}) : super(key: key);

  @override
  _DpUploadDesktopState createState() => _DpUploadDesktopState();
}

class _DpUploadDesktopState extends State<DpUploadDesktop> {
  PlatformFile? pickedFile;
  Uint8List? fileBytes;
  UploadTask? uploadTask;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
      fileBytes = result.files.first.bytes;
    });
  }

  Future uploadFile() async {
    if (pickedFile == null) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.orangeAccent.shade400,
        ),
      ),
    );

    final path = 'Users/${FirebaseAuth.instance.currentUser!.uid}.jpg';
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putData(fileBytes!);

    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print(urlDownload);

    await FirebaseFirestore.instance
        .collection('Profiles')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'dp': urlDownload,
    });
    Navigator.pop(context);
    Get.snackbar("Success", "Profile Image Uploaded Successfully");
    Get.to(() => const VerifyEmail());
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
                      height: 100,
                      width: 400,
                      child: Text(
                        AppLocalizations.of(context)!.dpupload,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width / 65,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lato',
                        ),
                      ),
                    ),
                   
                   
                    SizedBox(height: 20 ,),
                     if (pickedFile != null )
                      Container(
                        
                        height: 200,

                        width:  MediaQuery.of(context).size.width / 7,
                        color: Colors.white,
                        child: Card(
                          margin: EdgeInsets.all(8),
                          elevation: 10,
                          child: Image.memory(
                            fileBytes!,
                            width:  MediaQuery.of(context).size.width / 65,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                       const SizedBox(height: 20),
                    Container(
                      height: 70,
                      width: 250,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: KAppColors.primaryColor,
                        ),
                        onPressed: selectFile,
                        child: const Row(
                          children: [
                            Text(
                              "Select Profile Image",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.photo_camera,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 70,
                      width: 250,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: KAppColors.primaryColor,
                        ),
                        onPressed: uploadFile,
                        child: const Row(
                          children: [
                            Text(
                              "Upload Profile Image",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.photo_camera,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                    
                    buildProgress(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
    stream: uploadTask?.snapshotEvents,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final data = snapshot.data!;
        double progressPercent = data.bytesTransferred / data.totalBytes;
        return SizedBox(
          height: 50,
          child: Stack(
            fit: StackFit.expand,
            children: [
              LinearProgressIndicator(
                value: progressPercent,
                backgroundColor: Colors.grey,
                color: KAppColors.primaryColor,
              ),
              Center(
                child: Text(
                  '${(progressPercent * 100).roundToDouble()}%',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      } else {
        return const SizedBox(height: 50);
      }
    },
  );
}
