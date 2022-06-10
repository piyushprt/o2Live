import 'package:flutter/material.dart';
import 'package:o2live2/pages/tp_sub.dart';
import 'package:o2live2/pages/setup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:o2live2/pages/login_page.dart';
import 'package:o2live2/pages/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    // Enter your data from firebase
    apiKey: 'Enter_Your_ApIKey',
    appId: 'Enter_Your_AppId',
    messagingSenderId: 'Enter_Messaging_ID',
    projectId: 'Enter_Project_Id',
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.purple),
        initialRoute: "/login",
        routes: {
          "/login": (context) => const LoginPage(),
          "/signup": (context) => const SignUp(),
          "/setup": (context) => Setup(),
          "/sub": (context) => TpSub(),
        });
  }
}
