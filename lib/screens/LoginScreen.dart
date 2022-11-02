import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailCtrl = TextEditingController();
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
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.pushReplacementNamed(context, '/',
                                        arguments: {
                                          'email': _emailCtrl.text,
                                          'password': _passwordCtrl.text,
                                        });
                                  }
                                },
                                child: Text("Login",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16))),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/register');
                              },
                              child: Text("Don't have any account?",
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
