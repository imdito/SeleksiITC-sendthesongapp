import 'package:flutter/material.dart';
import 'package:nyoba/pages/home.dart';
import 'package:nyoba/pages/search.dart';
import 'package:nyoba/pages/create.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      routes: {
        '/homepage': (context) => const Home(),
        '/browsepage' : (context) => const Search(),
        '/sendpage' : (context) => const Add(),

      },
    );
  }
}
