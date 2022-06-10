import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "";
  String password = "";

  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/signup.png"),
            // ignore: prefer_const_constructors
            SizedBox(
              height: 30.0,
            ),

            const Text(
              'Register',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textScaleFactor: 2.0,
            ),

            const SizedBox(
              height: 20.0,
            ),

            Container(
              padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    //Username
                    TextFormField(
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.email),
                          hintText: 'Enter your email',
                          labelText: 'Email',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          )),
                      onChanged: (value) {
                        email = value;
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
                    ),

                    const SizedBox(
                      height: 20.0,
                    ),

                    //Password
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.left,
                      obscureText: true,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.lock),
                          hintText: 'Enter password',
                          labelText: 'Password',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          )),
                      onChanged: (value) {
                        password = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field cannot be empty';
                        } else if (value.length < 6) {
                          return 'Minimum password length is 6 characters';
                        }
                      },
                    ),

                    const SizedBox(
                      height: 20.0,
                    ),

                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: email, password: password);
                            if (newUser != null) {
                              Navigator.pushNamed(context, "/login");
                            }
                            _formKey.currentState!.reset();
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'email-already-in-use') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Email is already registered! Try another email')));
                            }
                          }
                        }
                      },
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(100, 40)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          textStyle: MaterialStateProperty.all(const TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold))),
                      child: const Text(
                        'Sign Up',
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
