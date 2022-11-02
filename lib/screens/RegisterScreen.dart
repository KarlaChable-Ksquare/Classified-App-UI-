import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _mobileCtrl = TextEditingController();
  TextEditingController _passwordCtrl = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 340,
                width: double.infinity,
                child: Image.asset("images/merida.png", fit: BoxFit.cover),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 30, 20, 5),
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
                              controller: _nameCtrl,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "This is required";
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Full Name",
                                labelStyle:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.grey),
                                ),
                                prefixIcon: Icon(Icons.person,
                                    color: Colors.grey.shade300),
                              )),
                          SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                              controller: _emailCtrl,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "This is required";
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Email Address",
                                labelStyle:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.grey),
                                ),
                                prefixIcon: Icon(Icons.email,
                                    color: Colors.grey.shade300),
                              )),
                          SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                              controller: _mobileCtrl,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "This is required";
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Mobile Number",
                                labelStyle:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.grey),
                                ),
                                prefixIcon: Icon(Icons.phone,
                                    color: Colors.grey.shade300),
                              )),
                          SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                              controller: _passwordCtrl,
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "This is required";
                                }
                                if (value.length < 8) {
                                  return "Password must be 8 chars";
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.grey),
                                ),
                                prefixIcon: Icon(Icons.password,
                                    color: Colors.grey.shade300),
                              )),
                          SizedBox(
                            height: 12,
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
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.pushReplacementNamed(context, '/',
                                        arguments: {
                                          "name": _nameCtrl.text,
                                          'email': _emailCtrl.text,
                                          'mobile': int.parse(_mobileCtrl.text),
                                          'password': _passwordCtrl.text
                                        });
                                  }
                                },
                                child: Text("Register Now",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold))),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              child: Text("Already have an account?",
                                  style: TextStyle(
                                      color: Color.fromRGBO(242, 87, 35, 1),
                                      fontSize: 12,
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
