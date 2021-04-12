import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {

  final String keyword;

  ResultScreen({this.keyword});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Text(widget.keyword),
    ));
  }
}
