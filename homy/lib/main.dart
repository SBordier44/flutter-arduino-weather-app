import 'package:flutter/material.dart';
import 'package:homy/screens/loading_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Homy',
        theme: ThemeData.dark(),
        home: const Scaffold(body: LoadingScreen()));
  }
}
