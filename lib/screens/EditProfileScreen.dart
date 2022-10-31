import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _mobileCtrl = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Edit Profile"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              CircleAvatar(
                backgroundImage: AssetImage('images/miku_sakura.jpg'),
                radius: 50,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 25, 20, 5),
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
                              initialValue: "Karla Chable",
                              //controller: _nameCtrl,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                labelText: "Full Name",
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
                              initialValue: "Karla.Chable@itksquare.edu.mx",
                              //controller: _emailCtrl,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: "Email Address",
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
                              initialValue: "9999012345",
                              //controller: _mobileCtrl,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Mobile Number",
                                labelStyle:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.grey),
                                ),
                              )),
                          SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                            height: 55,
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(242, 87, 35, 1),
                                  shape: BeveledRectangleBorder(),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  // if (_formKey.currentState!.validate()) {
                                  //   Navigator.pushNamed(context, '/settings',
                                  //       arguments: {
                                  //         'name': _nameCtrl.text,
                                  //         'mobile': _mobileCtrl.text,
                                  //       });
                                  // }
                                },
                                child: Text("Update Profile",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold))),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/login',
                                    arguments: {});
                              },
                              child: Text("Logout",
                                  style: TextStyle(
                                      color: Color.fromRGBO(242, 87, 35, 1),
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
        ));
  }
}
