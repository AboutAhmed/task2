import 'package:flutter/material.dart';
import 'form_page.dart'; // Import the FormPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter BLoC Form',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FormPage(),
    );
  }
}
