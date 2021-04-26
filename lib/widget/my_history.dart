import 'package:flutter/material.dart';
import 'package:while_trip_demo/model/user_model.dart';

class MyHistoryScreen extends StatefulWidget {

  final UserModel user;

  MyHistoryScreen({this.user});

  @override
  _MyHistoryScreenState createState() => _MyHistoryScreenState();
}

class _MyHistoryScreenState extends State<MyHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(child: Text('히스토리 스크린')),
      ),
    );
  }
}
