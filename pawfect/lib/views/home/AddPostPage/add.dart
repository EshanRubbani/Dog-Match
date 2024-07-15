import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController interestsController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _selectedFiles;

  Future<void> _pickMultipleImages() async {
    try {
      final List<XFile>? selectedImages = await _picker.pickMultiImage();
      if (selectedImages != null) {
        setState(() {
          _selectedFiles = selectedImages;
        });
      }
    } catch (e) {
      // Handle errors if necessary
      print('Error picking images: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        title: const Text("Add Post"),
      ),
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double width =
                constraints.maxWidth < 600 ? constraints.maxWidth / 1.2 : constraints.maxWidth / 2;
            final double height = MediaQuery.of(context).size.height;

            return Center(
              child: Container(
                width: width,
                height: height,
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    buildTextFields(
                      nameController: nameController,
                      ageController: ageController,
                      descriptionController: descriptionController,
                      interestsController: interestsController,
                    ),
                    SizedBox(height: 20),
                    buildMedia(MediaQuery.of(context).size),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: ElevatedButton(
                      onPressed: () {
                        upload();
                      },
                      child: Text("Upload"),
                    ))
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void upload() async {
    if (nameController.text.isNotEmpty &&
        ageController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        interestsController.text.isNotEmpty &&
        _selectedFiles != null &&
        _selectedFiles!.isNotEmpty) {
      String email = FirebaseAuth.instance.currentUser!.email!;
      try {
        // Show progress dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Uploading Files'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Please wait...'),
                ],
              ),
            );
          },
        );

        await FirebaseFirestore.instance.collection("Post").doc(email).set({
          "name": nameController.text,
          "age": ageController.text,
          "description": descriptionController.text,
          "interests": interestsController.text,
        });

        await uploadAllFiles(_selectedFiles!.map((file) => File(file.path)).toList());

        // Close progress dialog
        Navigator.of(context).pop();

        // Show success snackbar
        Get.snackbar("Success", "Posted Successfully");
      } catch (e) {
        // Close progress dialog
        Navigator.of(context).pop();

        print('Error uploading post: $e');
        Get.snackbar("Error", "Failed to post: $e");
      }
    } else {
      Get.snackbar("Error", "Please enter all the details and select images");
    }
  }

  Future<void> uploadAllFiles(List<File> selectedFiles) async {
    String email = FirebaseAuth.instance.currentUser!.email!;
    try {
      for (File file in selectedFiles) {
        String fileName = file.path.split('/').last; // Get the file name from the path
        Reference storageReference = FirebaseStorage.instance.ref('$email/$fileName');
        UploadTask uploadTask = storageReference.putFile(file);

        // You can optionally listen to the upload progress
        uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
          print('Task state: ${snapshot.state}');
          print('Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
        });

        await uploadTask;
        print('File uploaded: $fileName');
      }
    } catch (e) {
      print('Error uploading files: $e');
      throw Exception('Failed to upload files: $e');
    }
  }

  Container buildMedia(Size size) {
    return Container(
      width: size.width / 1.2,
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await _pickMultipleImages();
            },
            child: Text("Select and Upload Images"),
          ),
          _selectedFiles != null
              ? Container(
                  color: Colors.grey.shade500.withOpacity(0.5),
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _selectedFiles!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: kIsWeb
                            ? Image.network(_selectedFiles![index].path)
                            : Image.file(File(_selectedFiles![index].path)),
                      );
                    },
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

class buildTextFields extends StatelessWidget {
  const buildTextFields({
    required this.nameController,
    required this.ageController,
    required this.descriptionController,
    required this.interestsController,
  });

  final TextEditingController nameController;
  final TextEditingController ageController;
  final TextEditingController descriptionController;
  final TextEditingController interestsController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              labelText: "Pet Name",
              labelStyle: TextStyle(color: Colors.blue),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: ageController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              labelText: "Pet Age",
              labelStyle: TextStyle(color: Colors.blue),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              labelText: "Description",
              labelStyle: TextStyle(color: Colors.blue),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: interestsController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              labelText: "Interests",
              labelStyle: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
