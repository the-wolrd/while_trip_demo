import 'package:flutter/material.dart';
import 'package:while_trip_demo/widget/set_button.dart';

class ActivityPageReview extends StatefulWidget {

  final bool isSet;
  final List<dynamic> reviews; // 이거 dynamic 부분 reviewKey 값들이 넘어온다.

  ActivityPageReview({this.reviews, this.isSet});

  @override
  _ActivityPageReviewState createState() => _ActivityPageReviewState();
}

class _ActivityPageReviewState extends State<ActivityPageReview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 30.0,
                  width: 3.0,
                  color: Colors.lightBlueAccent,
                ),
                Text('리뷰'),
                Expanded(child: Container()),
                SetButton(
                    setFunc: (){}
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
