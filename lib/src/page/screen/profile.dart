import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movietime/src/auth/log_out.dart';
import 'package:movietime/src/page/widget/chang-pass.dart';
import 'package:movietime/src/page/widget/edit-profile.dart';
import 'package:movietime/src/page/widget/info.dart';
import 'package:movietime/src/page/widget/update.dart';
import 'package:movietime/src/service/authservice.dart';
import 'package:path_provider/path_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();

  XFile? _image;
  Future<void> saveImage() async {
    if (_image != null) {
      // Get the temporary directory using path_provider
      // Directory tempDir = await getTemporaryDirectory();
      Directory tempDir = await getTemporaryDirectory();
      // Create a unique filename for the saved image
      String fileName = DateTime.now().toIso8601String();
      String filePath = '${tempDir.path}/$fileName.png';

      // Copy the image to the new file
      await _image!.saveTo(filePath);

      // Now you can use the 'filePath' to access the saved image path
      print('Image saved at: $filePath');
    } else {
      print('No image selected.');
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);

      setState(() {
        _image = pickedFile;
      });
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  final _service = Get.find<AuthService>();
  User? _user;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    // Fetch the user data from the AuthService
    User? user = _service.getCurrentUser();

    // Update the state with the fetched user data
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Account"),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(300),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.circular(300),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 15,
                  //     vertical: 25,
                  //   ),
                  //   child: Stack(
                  //     children: [
                  //       CircleAvatar(
                  //         radius: 40,
                  //         backgroundColor: Colors.transparent,
                  //       ),
                  //       _image == null
                  //           ? Padding(
                  //               padding: const EdgeInsets.symmetric(
                  //                 horizontal: 15,
                  //                 vertical: 25,
                  //               ),
                  //               child: Image(
                  //                 height: 60,
                  //                 fit: BoxFit.cover,
                  //                 image: AssetImage(
                  //                   "assets/acc.png",
                  //                 ),
                  //               ),
                  //             )
                  //           : Image.file(
                  //               File(_image!.path),
                  //             ),
                  //       Positioned(
                  //         bottom: 0,
                  //         left: 50,
                  //         child: GestureDetector(
                  //           onTap: () {
                  //             _pickImage(ImageSource.gallery);
                  //           },
                  //           child: Icon(
                  //             Icons.camera_alt_outlined,
                  //             size: 26,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      height: 60,
                      image: AssetImage("assets/acc.png"),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text(
                          //   _user?.displayName ?? "username",
                          //   style: TextStyle(
                          //     fontSize: 18,
                          //     fontWeight: FontWeight.bold,
                          //     color: Colors.white,
                          //   ),
                          // ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _user?.email ?? "email",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          if (_image != null)
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  saveImage();
                                });
                              },
                              child: Icon(
                                Icons.save,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    EditProfile(),
                    SizedBox(
                      height: 10,
                    ),
                    ChangPassword(),
                    SizedBox(
                      height: 10,
                    ),
                    Info(),
                    SizedBox(
                      height: 10,
                    ),
                    Upgrade(),
                    SizedBox(
                      height: 10,
                    ),
                    Logout(),
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
