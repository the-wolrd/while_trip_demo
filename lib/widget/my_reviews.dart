import 'package:flutter/material.dart';
import 'package:while_trip_demo/model/user_model.dart';

class MyReviewScreen extends StatefulWidget {

  final UserModel user;

  const MyReviewScreen({this.user});

  @override
  _MyReviewScreenState createState() => _MyReviewScreenState();
}

class _MyReviewScreenState extends State<MyReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
              child: Center(
                child: Text('리뷰들 페이지'),
              ),
            )));
  }
}
