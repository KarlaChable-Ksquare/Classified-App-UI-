import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:practice_navigation/customs/columns.dart';
import 'package:practice_navigation/model/ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practice_navigation/services/ads.dart';
import 'package:practice_navigation/utils/contants.dart';
import 'package:practice_navigation/customs/textStyles.dart';
import 'package:practice_navigation/customs/circulatorManager.dart';

class CreateAdScreen extends StatefulWidget {
  const CreateAdScreen({
    super.key,
  });
  @override
  State<CreateAdScreen> createState() => _CreateAdScreenState();
}

class _CreateAdScreenState extends State<CreateAdScreen> {
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _priceCtrl = TextEditingController();
  final TextEditingController _mobileCtrl = TextEditingController();
  final TextEditingController _descriptionCtrl = TextEditingController();
  bool _isLoading = false;

  final List<String> _randomPics = [
    'https://picsum.photos/200/300',
  ];

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
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("Create Ad"),
          centerTitle: true,
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
                                    child: TextStyles().captureGallery()),
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
                    child: Columns().addPhoto(),
                  ),
                ),
                SizedBox(
                  height: _imageServerPath.isNotEmpty ? 105 : 1,
                  width: double.infinity,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _imageServerPath.length,
                        itemBuilder: ((context, index) {
                          return Container(
                            child: Row(
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
                                              height: 548,
                                              width: double.infinity,
                                              child: Image.network(
                                                _imageServerPath[index],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(4, 0, 4, 0),
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
                                        _imageServerPath[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        })),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 36, 20, 4),
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
                                child: CirculatorManager()
                                    .isLoadingNewAd(_isLoading),
                                onPressed: () async {
                                  var ad = AdsModel(
                                      title: _titleCtrl.text,
                                      mobile: _mobileCtrl.text,
                                      price: num.parse(_priceCtrl.text),
                                      description: _descriptionCtrl.text,
                                      images: _imageServerPath.isNotEmpty
                                          ? _imageServerPath
                                          : _randomPics);
                                  await Future.delayed(
                                      const Duration(milliseconds: 500));
                                  setState(() {
                                    GetAllAds().createPost(context, ad);
                                    _isLoading = false;
                                  });
                                  if (_isLoading) return;
                                  setState(() {
                                    _isLoading = true;
                                  });
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
