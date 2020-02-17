import 'package:flutter/material.dart';
import 'package:flutter_workshop/app/main_page.dart';

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: Calculator(title: 'Flutter Calculator'),
//      home: Calculator(),
    );
  }
}
