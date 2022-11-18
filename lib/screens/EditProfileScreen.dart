import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:practice_navigation/model/user.dart';
import 'package:practice_navigation/services/myuser.dart';
import 'package:practice_navigation/utils/circulator.dart';
import 'package:practice_navigation/utils/contants.dart';

class EditProfileScreen extends StatefulWidget {
  dynamic data;
  EditProfileScreen({super.key, required this.data});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _mobileCtrl = TextEditingController();
  bool _isLoading = false;

  String _imagePath = '';
  String _imageServerPath = '';
  void captureImageFromGallery() async {
    var file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      //print(file.path);
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
        //print(_imageServerPath);
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
    //print(resp);
    var respJson = jsonDecode(resp);
    setState(() {
      _imageServerPath = respJson['data']['path'];
      //print(_imageServerPath);
    });
  }

  @override
  Widget build(BuildContext context) {
    _nameCtrl.text = widget.data['name'];
    _emailCtrl.text = widget.data['email'];
    _mobileCtrl.text = widget.data['mobile'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Edit Profile"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: MyUserService().myUserPost(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              //Map userData = snapshot.data!;
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              backgroundColor: const Color(0xfff25723),
                              context: context,
                              builder: (context) {
                                return Container(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            captureImageFromGallery();
                                          },
                                          child: const Text("Capture Gallery",
                                              style: TextStyle(
                                                  color: Colors.white))),
                                      TextButton(
                                          onPressed: () {
                                            captureImageFromCamera();
                                          },
                                          child: const Text("Capture  Camera",
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
                                  backgroundImage: NetworkImage(
                                    widget.data['imgURL'],
                                  ),
                                ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 24, 20, 4),
                        child: Form(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextField(
                                      controller: _nameCtrl,
                                      keyboardType: TextInputType.name,
                                      decoration: const InputDecoration(
                                        labelText: "Full Name",
                                        labelStyle: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey),
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  TextField(
                                      controller: _emailCtrl,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: const InputDecoration(
                                        labelText: "Email Address",
                                        labelStyle: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey),
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  TextField(
                                      controller: _mobileCtrl,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: "Mobile Number",
                                        labelStyle: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey),
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 28,
                                  ),
                                  SizedBox(
                                    height: 56,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: const Color(0xfff25723),
                                        shape: const BeveledRectangleBorder(),
                                      ),
                                      child: _isLoading
                                          ? CirculatorManager().formUpdate()
                                          : const Text("Update Profile",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                      onPressed: () async {
                                        var userData = UserModel(
                                            name: _nameCtrl.text,
                                            email: _emailCtrl.text,
                                            mobile: _mobileCtrl.text,
                                            imgURL: _imageServerPath.isNotEmpty
                                                ? _imageServerPath
                                                : '${widget.data['imgURL']}');
                                        MyUserService()
                                            .myUserPatch(context, userData);
                                        if (_isLoading) return;
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        await Future.delayed(
                                            const Duration(seconds: 3));
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(
                                            context, '/login',
                                            arguments: {});
                                      },
                                      child: const Text("Logout",
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
              //print(snapshot.hasError);
              return const Center(child: Text("Something went wrong :( "));
            }
            return CirculatorManager().circleUpdate();
          })),
    );
  }
}
