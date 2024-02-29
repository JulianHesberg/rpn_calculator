import 'package:flutter/material.dart';
import 'package:rpn_calculator/number_display.dart';

void main() {
  runApp(const MyApp());
}

const themeColor = Colors.green;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: themeColor)),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: themeColor, brightness: Brightness.dark),
      ),
      color: themeColor,
      home: NumberDisplay(),
    );
  }
}
