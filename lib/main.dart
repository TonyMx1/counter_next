//import 'package:counter_next/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:counter_next/pages/login_page.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyCDe79eWvgWuDEThKcfN55MQdWlmijoGmM',
    appId: '1:770023908940:web:1e76f273518d546ab9b6e9',
    messagingSenderId: '770023908940',
    projectId: 'logincounter-next',
    authDomain: 'logincounter-next.firebaseapp.com',
    storageBucket: 'logincounter-next.appspot.com',
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: LoginPage(),
    );
  }
}
