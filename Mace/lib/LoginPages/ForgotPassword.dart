import 'dart:ffi';

import 'package:best_flutter_ui_templates/LoginPages/Login_page.dart';
import 'package:flutter/material.dart';
import '../app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late String email;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                                  CustomTheme.loginGradientStart,
                                  CustomTheme.loginGradientEnd
                                      ],
                                      begin: FractionalOffset(0.0, 0.0),
                                      end: FractionalOffset(1.0, 1.0),
                                      stops: <double>[0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                    ),
          child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                  height:
                  MediaQuery.of(context).size.height > 800 ? 191.0 : 150,
                  fit: BoxFit.fill,
                  image: const AssetImage('assets/images/Mace.png')),
              Text(
                '\nENTER YOUR REGISTERED EMAIL ADDRESS\n',
                style: TextStyle(fontSize: 23, color: Colors.black, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Email',
                  icon: Icon(
                    Icons.mail,
                    color: Colors.white,
                  ),
                  errorStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                onChanged: (value) { //Do something with the user input.
                  email = value;
                }),
              SizedBox(height: 20),

              RaisedButton(
                child: Text('Send Email'),
                onPressed: () {
                  passwordReset(email);
                },
              ),
              FlatButton(
                child: Text('Sign In'),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) =>
                      LoginPage()));
                },
              )
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> passwordReset(String email) async {
    final _auth = FirebaseAuth.instance;
    try {
      _formKey.currentState!.save();
    await _auth.sendPasswordResetEmail(email:email);
  }
    catch (e) {
      print(e);
    }
}}