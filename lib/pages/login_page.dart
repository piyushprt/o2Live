// import 'dart:js';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:o2live/pages/home/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _username = "guest!";
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String email = "";
  String password = "";

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40.0),
                Image.asset(
                  "assets/images/hey.png",
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 0),
                  alignment: Alignment.center,
                  child: Text(
                    "Welcome, $_username",
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.purple,
                      fontWeight: FontWeight.w900,
                    ),
                    textScaleFactor: 1.3,
                  ),
                ),
                const SizedBox(height: 50.0),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 0),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            // Username
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              textAlign: TextAlign.left,
                              onChanged: (value) {
                                _username = value;
                                if (_username.isEmpty) {
                                  _username = "guest!";
                                }
                                email = value;
                                setState(() {});
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Enter email';
                                } else if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  return 'Required format "abc@example.com"';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                // errorText: 'Please enter some text',
                                icon: Icon(Icons.email),
                                hintText: 'Enter your email',
                                labelText: 'Email',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 20.0,
                            ),

                            //Password
                            TextFormField(
                              onChanged: (value) {
                                password = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Field cannot be empty';
                                } else {
                                  return null;
                                }
                              },
                              textAlign: TextAlign.left,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  icon: Icon(Icons.lock),
                                  hintText: 'Enter Password',
                                  labelText: 'Password',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          try {
                            UserCredential userCredential =
                                await _auth.signInWithEmailAndPassword(
                                    email: email, password: password);
                            if (userCredential != null) {
                              Navigator.pushNamed(context, "/setup");
                            }
                            _formkey.currentState!.reset();
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('User is not Registered')));
                            } else if (e.code == 'wrong-password') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Wrong Password')));
                            }
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                      style: ButtonStyle(
                          maximumSize:
                              MaterialStateProperty.all(const Size(150, 40)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.purple),
                          textStyle: MaterialStateProperty.all(const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold))),
                      child: const Text(
                        'Login',
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/signup");
                        _formkey.currentState!.reset();
                      },
                      child: const Text(
                        'Create New Account',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 155.0,
                ),
                const Text(
                  'Made by - Project Group G15',
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                      color: Colors.blueGrey,
                      wordSpacing: 1.5),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'Programmed by - Piyush and Nihit',
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.purpleAccent,
                      letterSpacing: 1.5,
                      wordSpacing: 1.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
