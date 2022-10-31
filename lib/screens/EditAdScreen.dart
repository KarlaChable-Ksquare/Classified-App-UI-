import 'package:flutter/material.dart';

class EditAdScreen extends StatefulWidget {
  dynamic data;
  EditAdScreen({super.key, required this.data});

  @override
  State<EditAdScreen> createState() => _EditAdScreenState();
}

class _EditAdScreenState extends State<EditAdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Edit Ad"),
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
                height: 130,
                width: 130,
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
                  margin: EdgeInsets.fromLTRB(20, 25, 20, 0),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.data['imagesAll'].length,
                      itemBuilder: ((context, index) {
                        return Container(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      backgroundColor:
                                          Color.fromARGB(180, 242, 87, 35),
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          padding: EdgeInsets.all(10),
                                          child: SizedBox(
                                            child: Image.network(
                                              "${widget.data['imagesAll'][index]}",
                                              fit: BoxFit.cover,
                                            ),
                                            height: 550,
                                            width: double.infinity,
                                          ),
                                        );
                                      });
                                },
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  height: 80,
                                  width: 90,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Colors.grey.shade500,
                                      width: 1,
                                    ),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    child: Image.network(
                                      widget.data['imagesAll'][index],
                                      height: 80,
                                      width: 70,
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
                margin: EdgeInsets.fromLTRB(20, 25, 20, 5),
                child: Form(
                  //key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                              initialValue: widget.data['title'],
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
                              initialValue: widget.data['price'].toString(),
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
                              initialValue: widget.data['mobile'],
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
                              initialValue: widget.data['description'],
                              keyboardType: TextInputType.text,
                              maxLines: 5,
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
                            height: 55,
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(242, 87, 35, 1),
                                  shape: BeveledRectangleBorder(),
                                ),
                                // onPressed: () {
                                //   Navigator.pushNamed(context, '/myads',
                                //       arguments: {});
                                // },
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
