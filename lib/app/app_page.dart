import 'package:flutter/material.dart';
import 'package:flutter_clock/app/home/home_module.dart';

class AppPage extends StatefulWidget {
  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeModule(),
    );
  }
}