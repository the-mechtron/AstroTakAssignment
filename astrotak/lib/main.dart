import 'package:astrotak/Dashboard/Dashboard.dart';
import 'package:flutter/material.dart';

import 'LoginScreen/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Login(),
      ),
    );
  }
}

