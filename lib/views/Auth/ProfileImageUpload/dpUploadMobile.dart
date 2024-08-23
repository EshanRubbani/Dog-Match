import 'dart:io';
import 'package:DogMatch/Helper/Constants/Colors.dart';
import 'package:DogMatch/Helper/Painter/curved_painter.dart';
import 'package:DogMatch/views/Auth/Verification/verifyEmail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DpUploadMobile extends StatefulWidget {
    final String fname;
  final String lname;
  const DpUploadMobile({Key? key, required this.fname, required this.lname}) : super(key: key);

  @override
  _DpUploadMobileState createState() => _DpUploadMobileState();
}

class _DpUploadMobileState extends State<DpUploadMobile> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }
Future uploadFile() async {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.orangeAccent.shade400,
            ),
          ));
  if (pickedFile == null) return;

  final path = 'Users/${FirebaseAuth.instance.currentUser!.uid}.jpg';
  final file = File(pickedFile!.path!);
  final ref = FirebaseStorage.instance.ref().child(path);
  uploadTask = ref.putFile(file);

  final snapshot = await uploadTask!.whenComplete(() {});
  final urlDownload = await snapshot.ref.getDownloadURL();

  final userDocRef = FirebaseFirestore.instance
      .collection('Profiles')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  // Get the existing document data
  final userDoc = await userDocRef.get();
  if (userDoc.exists) {
    final userData = userDoc.data() as Map<String, dynamic>;
    
    // Update only the dp field, keeping existing data
    await userDocRef.update({
      'dp': urlDownload,
      // Optionally, include other fields you want to preserve
      'firstName': widget.fname,
      'lastName': widget.lname,
      'email': FirebaseAuth.instance.currentUser!.email,
      // etc.
    });
  }

  Navigator.pop(context);
  Get.snackbar("Success", "Profile Image Uploaded Successfully");
  Get.to(() => const VerifyEmail());
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                end: Alignment(0.0, 0.4),
                begin: Alignment(0.0, -1),
                colors: <Color>[
                  Colors.pink,
                  Color(0xFFFF5722)
                ],
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                      "Please Upload Profile Image",
                      style: TextStyle(
                        color:KAppColors.mediumPrimaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lato',
                      ),
                    ),
                if (pickedFile != null)
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width -100,
                    child: Image.file(
                      File(pickedFile!.path!),
                      width: MediaQuery.of(context).size.width -100,
                      fit: BoxFit.cover,

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
        ],
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
