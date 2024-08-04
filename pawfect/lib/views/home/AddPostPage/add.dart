import 'dart:io';
import 'dart:typed_data';
import 'package:DogMatch/Helper/Constants/Colors.dart';
import 'package:DogMatch/views/home/HomePage/home_page.dart';
import 'package:DogMatch/views/home/TabsPage/tabs_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
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
            final double width = constraints.maxWidth < 600
                ? constraints.maxWidth / 1.2
                : constraints.maxWidth / 2;
            final double height = MediaQuery.of(context).size.height;

            return Center(
              child: Container(
                width: width,
                height: height,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 20.0),
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
    final String id = nameController.text.toString();
    if (nameController.text.isNotEmpty &&
        ageController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        interestsController.text.isNotEmpty &&
        _selectedFiles != null &&
        _selectedFiles!.isNotEmpty) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      try {
        List<String> urls = await uploadAllFiles(_selectedFiles!, id);

        await FirebaseFirestore.instance.collection("Posts").doc(id).set({
          "name": nameController.text,
          "age": ageController.text,
          "description": descriptionController.text,
          "interests": interestsController.text,
          "owner": FirebaseAuth.instance.currentUser!.email,
          "urls": urls
        });

        Navigator.of(context).pop();
        Get.snackbar("Success", "Posted Successfully");
        Get.to(() => TabsPage());
      } catch (e) {
        Navigator.of(context).pop();
        print('Error uploading post: $e');
        Get.snackbar("Error", "Failed to post: $e");
      }
    } else {
      Get.snackbar("Error", "Please enter all the details and select images");
    }
  }

 Future<List<String>> uploadAllFiles(List<XFile> selectedFiles, String id) async {
  List<String> uploadedFileUrls = [];

  try {
    for (XFile file in selectedFiles) {
      Uint8List imageData = await file.readAsBytes();

      Reference storageReference =
          FirebaseStorage.instance.ref('Posts/$id/${file.name}');
      UploadTask uploadTask;

      final metadata = SettableMetadata(
        contentType: 'image/jpeg', // Adjust the content type as needed
      );

      if (kIsWeb) {
        uploadTask = storageReference.putData(imageData, metadata);
      } else {
        uploadTask = storageReference.putFile(File(file.path), metadata);
      }

      await uploadTask.whenComplete(() {});
      String downloadURL = await storageReference.getDownloadURL();
      uploadedFileUrls.add(downloadURL);
      print('File uploaded: ${file.name}');
    }
    return uploadedFileUrls;
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
