import 'dart:io';
import 'package:DogMatch/Helper/Constants/Colors.dart';
import 'package:DogMatch/views/home/TabsPage/tabs_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddDesktop extends StatefulWidget {
  const AddDesktop({Key? key}) : super(key: key);

  @override
  _AddDesktopState createState() => _AddDesktopState();
}

class _AddDesktopState extends State<AddDesktop> {
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

  Future<void> upload() async {
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
          return const Center(
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

  Future<List<String>> uploadAllFiles(
      List<XFile> selectedFiles, String id) async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(child: Center(child: buildImg(context))),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: buildRightSide(context),
          ),
        ],
      ),
    );
  }

  Container buildImg(BuildContext context) {
    return Container(
       height: 500,
       width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          const BoxShadow(
            color:Colors.grey,
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),

      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10), // Curving the edges
          child: Container(
            color: Colors.white,
            width: 300,
            height: 450,
            child:  buildMedia(),
            // Add an Image widget if needed
            
          ),
        ),
      ),
    );
  }

  Container buildRightSide(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.9,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          end: Alignment(0.0, 0.4),
          begin: Alignment(0.0, -1),
          colors: <Color>[
            Colors.pink,
            Colors.deepOrange,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          BuildTextFields(
            nameController: nameController,
            ageController: ageController,
            descriptionController: descriptionController,
            interestsController: interestsController,
          ),
          const SizedBox(height: 20),
         
          const SizedBox(
            height: 20,
          ),
          Center(
              child: ElevatedButton(
            onPressed: () {
              upload();
            },
            child: const Text("Upload"),
          ))
        ],
      ),
    );
  }
Container buildMedia() {
  return Container(
    width: 350,
    height: 500, // Adjusted to fit the height of the carousel
    child: InkWell(
      onTap: () {
        _pickMultipleImages();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _selectedFiles == null
              ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.image_outlined),
                    Text(
                      "Select Images to Upload",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Lato",
                        color: KAppColors.darkPrimaryColor,
                      ),
                    )
                  ],
                )
              : Container(),
          _selectedFiles != null
              ? Container(
                  color: Colors.grey,
                  height: 450, // Adjusted to fit the height of the carousel
                  width: 350,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 450, // Ensure it matches the container height
                      aspectRatio: 1.0,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      animateToClosest: true,
                    ),
                    items: _selectedFiles!.map((file) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: 350, // Ensure it matches the container width
                            child: kIsWeb
                                ? Image.network(file.path, fit: BoxFit.cover)
                                : Image.file(File(file.path), fit: BoxFit.cover),
                          );
                        },
                      );
                    }).toList(),
                  ),
                )
              : Container(),
        ],
      ),
    ),
  );
}
}


class BuildTextFields extends StatelessWidget {
  const BuildTextFields({
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

         const Row(
            children: [
              SizedBox(width: 170,),
              Text("Pet Name", style: TextStyle(color: Colors.black,fontFamily: "lato",fontSize: 18),),
              
            ],
          ),
          const SizedBox(height: 5),
          Container(
           
            width: 350,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white             
            ),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(8),
                border: InputBorder.none

              ),
              style: const  TextStyle(
                color: Colors.black,
                fontFamily: "lato",
                fontSize: 18,    
              ),

            ),
          ),
          const SizedBox(height: 20),
          
         const Row(
            children: [
              SizedBox(width: 170,),
              Text("Pet Age", style: TextStyle(color: Colors.black,fontFamily: "lato",fontSize: 18),),
              
            ],
          ),
          const SizedBox(height: 5),
          Container(
           
            width: 350,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white             
            ),
            child: TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(8),
                border: InputBorder.none

              ),
              style: const  TextStyle(
                color: Colors.black,
                fontFamily: "lato",
                fontSize: 18,    
              ),

            ),
          ),
          const SizedBox(height: 20),
          
         const Row(
            children: [
              SizedBox(width: 170,),
              Text("Description", style: TextStyle(color: Colors.black,fontFamily: "lato",fontSize: 18),),
              
            ],
          ),
          const SizedBox(height: 5),
          Container(
           
            width: 350,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white             
            ),
            child: TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(8),
                border: InputBorder.none

              ),
              style: const  TextStyle(
                color: Colors.black,
                fontFamily: "lato",
                fontSize: 18,    
              ),

            ),
          ),
          const SizedBox(height: 20),
          
         const Row(
            children: [
              SizedBox(width: 170,),
              Text("Intrests", style: TextStyle(color: Colors.black,fontFamily: "lato",fontSize: 18),),
              
            ],
          ),
          const SizedBox(height: 5),
          Container(
           
            width: 350,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white             
            ),
            child: TextField(
              controller: interestsController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(8),
                border: InputBorder.none

              ),
              style: const  TextStyle(
                color: Colors.black,
                fontFamily: "lato",
                fontSize: 18,    
              ),

            ),
          ),
          const SizedBox(height: 20),
          
        ],
      ),
    );
  }
}
