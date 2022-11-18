import 'package:flutter/material.dart';
import 'package:practice_navigation/model/user.dart';
import 'package:practice_navigation/services/auth.dart';
import 'package:practice_navigation/utils/circulator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _mobileCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 340,
                  width: double.infinity,
                  child: Image.asset("images/merida.png", fit: BoxFit.cover),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 30, 20, 5),
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
                                  labelStyle: const TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey),
                                  ),
                                  prefixIcon: Icon(Icons.person,
                                      color: Colors.grey.shade300),
                                )),
                            const SizedBox(
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
                                  labelStyle: const TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey),
                                  ),
                                  prefixIcon: Icon(Icons.email,
                                      color: Colors.grey.shade300),
                                )),
                            const SizedBox(
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
                                  labelStyle: const TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey),
                                  ),
                                  prefixIcon: Icon(Icons.phone,
                                      color: Colors.grey.shade300),
                                )),
                            const SizedBox(
                              height: 12,
                            ),
                            TextFormField(
                                controller: _passwordCtrl,
                                obscureText: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "This is required";
                                  }
                                  if (value.length < 6) {
                                    return "Password must be 6 chars";
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  labelStyle: const TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey),
                                  ),
                                  prefixIcon: Icon(Icons.password,
                                      color: Colors.grey.shade300),
                                )),
                            const SizedBox(
                              height: 12,
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
                                    : const Text("Register Now",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    UserModel user = UserModel(
                                        name: _nameCtrl.text,
                                        email: _emailCtrl.text,
                                        mobile: _mobileCtrl.text,
                                        password: _passwordCtrl.text);
                                    AuthService().register(context, user);
                                  }
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
                              height: 12,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                                child: const Text("Already have an account?",
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
          ),
        ));
  }
}
