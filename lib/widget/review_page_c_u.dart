import 'package:flutter/material.dart';
import 'package:while_trip_demo/model/store_model.dart';
import 'package:while_trip_demo/model/user_model.dart';

class ReviewCreateUpdate extends StatefulWidget {

  final StoreModel store;
  final UserModel user;

  ReviewCreateUpdate({this.store, this.user});

  @override
  _ReviewCreateUpdateState createState() => _ReviewCreateUpdateState();
}

class _ReviewCreateUpdateState extends State<ReviewCreateUpdate> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('0000 리뷰'),
            centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              
            ],
          ),
        ),
      ),
    );
  }
}
