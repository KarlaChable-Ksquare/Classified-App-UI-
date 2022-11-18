import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:practice_navigation/model/ads.dart';
import 'package:practice_navigation/services/ads.dart';
import 'package:practice_navigation/utils/circulator.dart';
import 'package:practice_navigation/utils/contants.dart';

class EditAdScreen extends StatefulWidget {
  dynamic data;
  EditAdScreen({super.key, required this.data});

  @override
  State<EditAdScreen> createState() => _EditAdScreenState();
}

class _EditAdScreenState extends State<EditAdScreen> {
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _priceCtrl = TextEditingController();
  final TextEditingController _mobileCtrl = TextEditingController();
  final TextEditingController _descriptionCtrl = TextEditingController();
  bool _isLoading = false;

  List<dynamic> _imagePath = [];
  List<String> _imageServerPath = [];

  void captureImageFromGallery() async {
    var files = await ImagePicker().pickMultiImage();
    if (files.isNotEmpty) {
      _uploadMultitpleFiles(files);
    }
  }

  _uploadMultitpleFiles(List<XFile> files) async {
    var url = Uri.parse("${Constants().serverUrl}/upload/photos");
    var request = http.MultipartRequest('POST', url);
    files.forEach((file) async {
      MultipartFile images =
          await http.MultipartFile.fromPath('photos', file.path);
      request.files.add(images);
    });
    var response = await request.send();
    var resp = await response.stream.bytesToString();
    //print(resp);
    var respJson = jsonDecode(resp);
    setState(() {
      _imagePath = respJson['data']['path'];
      _imageServerPath = _imagePath.map((str) => str.toString()).toList();
      //print(_imageServerPath);
    });
  }

  @override
  Widget build(BuildContext context) {
    _titleCtrl.text = widget.data['title'];
    _priceCtrl.text = widget.data['price'].toString();
    _mobileCtrl.text = widget.data['mobile'];
    _descriptionCtrl.text = widget.data['description'];

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("Edit Ad"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                    barrierColor: Color.fromRGBO(242, 87, 35, 0.35),
                    context: context,
                    builder: ((context) {
                      return AlertDialog(
                        title: Text("Delete AD"),
                        content: Text("Do you want delete this Ad?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                var ad = AdsModel(
                                    authorName: widget.data['authorName'],
                                    sId: widget.data['id'],
                                    title: _titleCtrl.text,
                                    mobile: _mobileCtrl.text,
                                    price: num.parse(_priceCtrl.text),
                                    description: _descriptionCtrl.text,
                                    images: _imageServerPath.isNotEmpty
                                        ? _imageServerPath
                                        : widget.data['images']);
                                GetAllAds().deletePost(ad, context);
                              },
                              child: Text("Yes")),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("No"))
                        ],
                      );
                    }));
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      captureImageFromGallery();
                                    },
                                    child: const Text("Capture Gallery",
                                        style: TextStyle(color: Colors.white))),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          size: 50,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Tap to upload")
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 105,
                  width: double.infinity,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _imageServerPath.isNotEmpty
                            ? _imageServerPath.length
                            : widget.data['images'].length,
                        itemBuilder: ((context, index) {
                          return Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      backgroundColor: const Color.fromRGBO(
                                          242, 87, 35, 0.4),
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          padding: const EdgeInsets.all(12),
                                          child: SizedBox(
                                            child: Image.network(
                                              _imageServerPath.isNotEmpty
                                                  ? "${_imageServerPath[index]}"
                                                  : "${widget.data['images'][index]}",
                                              fit: BoxFit.cover,
                                            ),
                                            height: 548,
                                            width: double.infinity,
                                          ),
                                        );
                                      });
                                },
                                child: Container(
                                  margin: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                                  height: 80,
                                  width: 88,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: Colors.grey.shade500,
                                      width: 1,
                                    ),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    height: double.infinity,
                                    width: double.infinity,
                                    child: Image.network(
                                      _imageServerPath.isNotEmpty
                                          ? _imageServerPath[index]
                                          : widget.data['images'][index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        })),
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
                                controller: _titleCtrl,
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  labelText: "Title",
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
                                controller: _priceCtrl,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: "Price",
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
                                  labelText: "Contact Number",
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
                                controller: _descriptionCtrl,
                                keyboardType: TextInputType.text,
                                maxLines: 4,
                                decoration: const InputDecoration(
                                  labelText: "Description",
                                  alignLabelWithHint: true,
                                  labelStyle: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey),
                                  ),
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 56,
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xfff25723),
                                  shape: const BeveledRectangleBorder(),
                                ),
                                child: _isLoading
                                    ? CirculatorManager().formUpdate()
                                    : const Text("Submit Ad",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                onPressed: () async {
                                  var ad = AdsModel(
                                      authorName: widget.data['authorName'],
                                      sId: widget.data['id'],
                                      title: _titleCtrl.text,
                                      mobile: _mobileCtrl.text,
                                      price: num.parse(_priceCtrl.text),
                                      description: _descriptionCtrl.text,
                                      images: _imageServerPath.isNotEmpty
                                          ? _imageServerPath
                                          : widget.data['images']);
                                  //print(ad.toJson());
                                  GetAllAds().patchPost(ad, context);
                                  if (_isLoading) return;
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  await Future.delayed(
                                      const Duration(seconds: 3));
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  //Navigator.pop(context);
                                },
                              ),
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
