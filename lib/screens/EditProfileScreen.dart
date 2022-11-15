import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:practice_navigation/model/user.dart';
import 'package:practice_navigation/services/auth.dart';
import 'package:practice_navigation/utils/contants.dart';

class EditProfileScreen extends StatefulWidget {
  dynamic userData;
  EditProfileScreen({super.key, required this.userData});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _mobileCtrl = TextEditingController();

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
        print(_imageServerPath);
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
      print(_imageServerPath);
    });
  }

  @override
  Widget build(BuildContext context) {
    //_nameCtrl.text = 'karla';
    //_emailCtrl.text = 'karla@demo.com';
    //_mobileCtrl.text = '+529991698657';
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Edit Profile"),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: AuthService().myUserData(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                UserModel userData = snapshot.data!;
                return SingleChildScrollView(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              captureImageFromGallery();
                                            },
                                            child: Text("Capture Gallery",
                                                style: TextStyle(
                                                    color: Colors.white))),
                                        TextButton(
                                            onPressed: () {
                                              captureImageFromCamera();
                                            },
                                            child: Text("Capture  Camera",
                                                style: TextStyle(
                                                    color: Colors.white)))
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: CircleAvatar(
                            radius: 48,
                            child: _imagePath.isNotEmpty
                                ? CircleAvatar(
                                    radius: 48,
                                    backgroundImage: FileImage(
                                      File(_imagePath),
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
                                        controller: _nameCtrl,
                                        initialValue: userData.name,
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
                                        controller: _emailCtrl,
                                        initialValue: userData.email,
                                        keyboardType:
                                            TextInputType.emailAddress,
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
                                        controller: _mobileCtrl,
                                        initialValue: userData.mobile,
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
                                                  fontWeight:
                                                      FontWeight.bold))),
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
                );
              }
              if (snapshot.hasError) {
                print(snapshot.hasError);
                return const Center(child: Text("Something went wrong :( "));
              }
              return const Center(child: CircularProgressIndicator());
            })));
  }
}
