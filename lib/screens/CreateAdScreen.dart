import 'package:flutter/material.dart';

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
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Create Ad"),
          centerTitle: true,
        ),
        body: Center(
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
              Container(
                margin: EdgeInsets.fromLTRB(20, 36, 20, 4),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                              controller: _titleCtrl,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                labelText: "Title",
                                labelStyle:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.grey),
                                ),
                              )),
                          SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                              controller: _priceCtrl,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Price",
                                labelStyle:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.grey),
                                ),
                              )),
                          SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                              controller: _mobileCtrl,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Contact Number",
                                labelStyle:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.grey),
                                ),
                              )),
                          SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                              controller: _descriptionCtrl,
                              keyboardType: TextInputType.text,
                              maxLines: 4,
                              decoration: InputDecoration(
                                labelText: "Description",
                                labelStyle:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.grey),
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
                                  primary: Color.fromRGBO(242, 87, 35, 1),
                                  shape: BeveledRectangleBorder(),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
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
        ));
  }
}
