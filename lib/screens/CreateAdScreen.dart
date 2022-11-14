import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:practice_navigation/model/ads.dart';
import 'package:practice_navigation/services/ads.dart';
import 'package:practice_navigation/utils/contants.dart';
import 'package:image_picker/image_picker.dart';

class CreateAdScreen extends StatefulWidget {
  const CreateAdScreen({super.key});

  @override
  State<CreateAdScreen> createState() => _CreateAdScreenState();
}

class _CreateAdScreenState extends State<CreateAdScreen> {
  TextEditingController _titleCtrl = TextEditingController();
  TextEditingController _priceCtrl = TextEditingController();
  TextEditingController _mobileCtrl = TextEditingController();
  TextEditingController _descriptionCtrl = TextEditingController();
  //var _formKey = GlobalKey<FormState>();

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
    var url = Uri.parse("${Constants().serverUrl}/upload/photos");
    var request = http.MultipartRequest('POST', url);
    MultipartFile image = await http.MultipartFile.fromPath('photos', filePath);
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Create Ad"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
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
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade500,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: 136,
                    width: 136,
                    child: _imagePath.isNotEmpty
                        //_imageServerPath.isNotEmpty
                        ? Image.file(
                            File(_imagePath),
                            height: 136,
                            width: 136,
                            fit: BoxFit.cover,
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_a_photo_outlined,
                                size: 40,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text("Tap to upload")
                            ],
                          ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 36, 20, 4),
                  child: Form(
                    //key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextField(
                                controller: _titleCtrl,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  labelText: "Title",
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
                            TextField(
                                controller: _priceCtrl,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Price",
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
                            TextField(
                                controller: _mobileCtrl,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Contact Number",
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
                            TextField(
                                controller: _descriptionCtrl,
                                keyboardType: TextInputType.text,
                                maxLines: 4,
                                decoration: InputDecoration(
                                  labelText: "Description",
                                  alignLabelWithHint: true,
                                  labelStyle: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey),
                                  ),
                                )),
                            SizedBox(
                              height: 20,
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
                                    var ad = AdsModel(
                                      title: _titleCtrl.text,
                                      mobile: _mobileCtrl.text,
                                      price: int.parse(_priceCtrl.text),
                                      description: _descriptionCtrl.text,
                                      images: [
                                        "https://i.ibb.co/6sGYmSM/lyndis.jpg"
                                      ],
                                    );
                                    GetAllAds().createPost(ad);
                                    //Navigator.pop(context);
                                    Navigator.pushReplacementNamed(
                                      context,
                                      '/',
                                    );
                                  },
                                  child: Text("Submit Ad",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold))),
                            ),
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
