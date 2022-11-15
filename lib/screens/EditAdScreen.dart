import 'package:flutter/material.dart';
import 'package:practice_navigation/model/ads.dart';
import 'package:practice_navigation/services/ads.dart';

class EditAdScreen extends StatefulWidget {
  dynamic data;
  EditAdScreen({super.key, required this.data});

  @override
  State<EditAdScreen> createState() => _EditAdScreenState();
}

class _EditAdScreenState extends State<EditAdScreen> {
  TextEditingController _titleCtrl = TextEditingController();
  TextEditingController _priceCtrl = TextEditingController();
  TextEditingController _mobileCtrl = TextEditingController();
  TextEditingController _descriptionCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var authorName = widget.data['authorName'];
    _titleCtrl.text = widget.data['title'];
    _priceCtrl.text = widget.data['price'].toString();
    _mobileCtrl.text = widget.data['mobile'];
    _descriptionCtrl.text = widget.data['description'];

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Edit Ad"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
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
                SizedBox(
                  height: 105,
                  width: double.infinity,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20, 24, 20, 0),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.data['images'].length,
                        itemBuilder: ((context, index) {
                          return Container(
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        backgroundColor: Color(0xfff25723),
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            padding: EdgeInsets.all(12),
                                            child: SizedBox(
                                              child: Image.network(
                                                "${widget.data['images'][index]}",
                                                fit: BoxFit.cover,
                                              ),
                                              height: 548,
                                              width: double.infinity,
                                            ),
                                          );
                                        });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
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
                                      padding: EdgeInsets.all(4),
                                      height: double.infinity,
                                      width: double.infinity,
                                      child: Image.network(
                                        widget.data['images'][index],
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
                  margin: EdgeInsets.fromLTRB(20, 24, 20, 4),
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
                                      sId: widget.data['id'],
                                      authorName: authorName,
                                      title: _titleCtrl.text,
                                      mobile: _mobileCtrl.text,
                                      price: int.parse(_priceCtrl.text),
                                      description: _descriptionCtrl.text,
                                      images: [
                                        "https://i.ibb.co/9WQp2G3/Whats-App-Image-2022-09-15-at-11-58-24-AM.jpg"
                                      ],
                                    );
                                    GetAllAds().patchPost(ad);
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
