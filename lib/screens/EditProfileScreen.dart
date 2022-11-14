import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:practice_navigation/utils/contants.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String _imagePath = '';
  String _imageServerPath = '';
  void captureImageFromGallery() async {
    var file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      print(file.path);
      setState(() {
        _imagePath = file.path;
      });
      _upload(file.path);
    }
  }

  void captureImageFromCamera() async {
    var file = await ImagePicker().pickImage(source: ImageSource.camera);
    if (file != null) {
      print(file.path);
      setState(() {
        _imagePath = file.path;
      });
      _upload(file.path);
    }
  }

  _upload(filePath) async {
    var url = Uri.parse("${Constants().serverUrl}/upload/profile");
    var request = http.MultipartRequest('POST', url);
    MultipartFile image = await http.MultipartFile.fromPath('avatar', filePath);
    request.files.add(image);
    var response = await request.send();
    var resp = await response.stream.bytesToString();
    print(resp);
    var respJson = jsonDecode(resp);
    setState(() {
      _imageServerPath = respJson['data']['path'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Edit Profile"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        backgroundColor: Color(0xfff25723),
                        context: context,
                        builder: (context) {
                          return Container(
                            padding: EdgeInsets.all(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      captureImageFromGallery();
                                    },
                                    child: Text("Capture Gallery",
                                        style: TextStyle(color: Colors.white))),
                                TextButton(
                                    onPressed: () {
                                      captureImageFromCamera();
                                    },
                                    child: Text("Capture  Camera",
                                        style: TextStyle(color: Colors.white)))
                              ],
                            ),
                          );
                        });
                  },
                  child: CircleAvatar(
                    radius: 48,
                    child: _imagePath.isNotEmpty
                        //_imageServerPath.isNotEmpty
                        ? CircleAvatar(
                            radius: 48,
                            backgroundImage: FileImage(
                              File(/*_imageServerPath*/ _imagePath),
                            ),
                          )
                        : CircleAvatar(
                            radius: 48,
                            backgroundImage: AssetImage(
                              'images/miku_sakura.jpg',
                            ),
                          ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 24, 20, 4),
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormField(
                                initialValue: "Karla Chable",
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  labelText: "Full Name",
                                  labelStyle: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey),
                                  ),
                                )),
                            SizedBox(
                              height: 12,
                            ),
                            TextFormField(
                                initialValue: "Karla.Chable@itksquare.edu.mx",
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: "Email Address",
                                  labelStyle: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey),
                                  ),
                                )),
                            SizedBox(
                              height: 12,
                            ),
                            TextFormField(
                                initialValue: "+529999012345",
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Mobile Number",
                                  labelStyle: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey),
                                  ),
                                )),
                            SizedBox(
                              height: 28,
                            ),
                            SizedBox(
                              height: 56,
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xfff25723),
                                    shape: BeveledRectangleBorder(),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Update Profile",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold))),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/login',
                                      arguments: {});
                                },
                                child: Text("Logout",
                                    style: TextStyle(
                                        color: Color(0xfff25723),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
